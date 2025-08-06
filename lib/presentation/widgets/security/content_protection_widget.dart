import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:html' as html;
import 'dart:js' as js;

import 'right_click_blocker.dart';
import 'devtools_detector.dart';
import 'watermark_overlay.dart';
import 'security_utils.dart';

/// 콘텐츠 보호 위젯 - 우클릭 방지, 선택 방지, 개발자 도구 감지, 워터마크 기능
/// Flutter Web 전용 보안 기능을 제공
class ContentProtectionWidget extends StatefulWidget {
  final Widget child;
  final String? watermarkText;
  final bool enableRightClickPrevention;
  final bool enableTextSelectionPrevention;
  final bool enableDragPrevention;
  final bool enableDevToolsDetection;
  final bool enableScreenshotPrevention;
  final bool enableWatermark;
  final VoidCallback? onSecurityViolation;
  final Color watermarkColor;
  final double watermarkOpacity;
  final double watermarkFontSize;

  const ContentProtectionWidget({
    Key? key,
    required this.child,
    this.watermarkText,
    this.enableRightClickPrevention = true,
    this.enableTextSelectionPrevention = true,
    this.enableDragPrevention = true,
    this.enableDevToolsDetection = true,
    this.enableScreenshotPrevention = true,
    this.enableWatermark = true,
    this.onSecurityViolation,
    this.watermarkColor = Colors.white,
    this.watermarkOpacity = 0.15,
    this.watermarkFontSize = 14.0,
  }) : super(key: key);

  @override
  State<ContentProtectionWidget> createState() => _ContentProtectionWidgetState();
}

class _ContentProtectionWidgetState extends State<ContentProtectionWidget> {
  bool _isDevToolsOpen = false;
  String? _currentWatermarkText;

  @override
  void initState() {
    super.initState();
    _currentWatermarkText = widget.watermarkText ?? '© 구독자 전용 콘텐츠';
    
    // Web 전용 보안 기능 초기화
    if (kIsWeb) {
      _initializeWebSecurity();
    }
  }

  /// Web 보안 기능 초기화
  void _initializeWebSecurity() {
    // 개발자 도구 감지 설정
    if (widget.enableDevToolsDetection) {
      _setupDevToolsDetection();
    }

    // 우클릭 방지 설정
    if (widget.enableRightClickPrevention) {
      _setupContextMenuPrevention();
    }

    // 키보드 단축키 방지 설정
    if (widget.enableScreenshotPrevention) {
      _setupKeyboardShortcutPrevention();
    }

    // 화면 보호 CSS 설정
    _setupScreenProtectionCSS();
  }

  /// 개발자 도구 감지 설정
  void _setupDevToolsDetection() {
    // JavaScript로 개발자 도구 감지 스크립트 삽입
    js.context.callMethod('eval', ['''
      (function() {
        var devtools = {
          open: false,
          orientation: null
        };
        
        var threshold = 160;
        
        setInterval(function() {
          if (window.outerHeight - window.innerHeight > threshold || 
              window.outerWidth - window.innerWidth > threshold) {
            if (!devtools.open) {
              devtools.open = true;
              window.postMessage({type: 'DEVTOOLS_OPENED'}, '*');
            }
          } else {
            if (devtools.open) {
              devtools.open = false;
              window.postMessage({type: 'DEVTOOLS_CLOSED'}, '*');
            }
          }
        }, 500);
        
        // 디버거 감지
        var element = new Image();
        Object.defineProperty(element, 'id', {
          get: function() {
            window.postMessage({type: 'DEVTOOLS_OPENED'}, '*');
            return 'devtools-detector';
          }
        });
        
        setInterval(function() {
          console.clear();
          console.log(element);
        }, 1000);
      })();
    ''']);

    // 메시지 리스너 등록
    html.window.addEventListener('message', (event) {
      final messageEvent = event as html.MessageEvent;
      if (messageEvent.data['type'] == 'DEVTOOLS_OPENED' && !_isDevToolsOpen) {
        setState(() {
          _isDevToolsOpen = true;
        });
        _handleSecurityViolation('개발자 도구가 감지되었습니다');
      } else if (messageEvent.data['type'] == 'DEVTOOLS_CLOSED' && _isDevToolsOpen) {
        setState(() {
          _isDevToolsOpen = false;
        });
      }
    });
  }

  /// 우클릭 방지 설정
  void _setupContextMenuPrevention() {
    js.context.callMethod('eval', ['''
      document.addEventListener('contextmenu', function(e) {
        e.preventDefault();
        window.postMessage({type: 'CONTEXT_MENU_BLOCKED'}, '*');
        return false;
      });
    ''']);
  }

  /// 키보드 단축키 방지 설정
  void _setupKeyboardShortcutPrevention() {
    js.context.callMethod('eval', ['''
      document.addEventListener('keydown', function(e) {
        // F12, Ctrl+Shift+I, Ctrl+Shift+J, Ctrl+U 등 방지
        if (e.keyCode == 123 || // F12
            (e.ctrlKey && e.shiftKey && e.keyCode == 73) || // Ctrl+Shift+I
            (e.ctrlKey && e.shiftKey && e.keyCode == 74) || // Ctrl+Shift+J
            (e.ctrlKey && e.keyCode == 85) || // Ctrl+U
            (e.ctrlKey && e.shiftKey && e.keyCode == 67) || // Ctrl+Shift+C
            (e.ctrlKey && e.keyCode == 83) || // Ctrl+S
            (e.keyCode == 44)) { // PrtScr
          e.preventDefault();
          window.postMessage({type: 'KEYBOARD_SHORTCUT_BLOCKED', keyCode: e.keyCode}, '*');
          return false;
        }
      });
    ''']);
  }

  /// 화면 보호 CSS 설정
  void _setupScreenProtectionCSS() {
    js.context.callMethod('eval', ['''
      // 텍스트 선택 방지 CSS 삽입
      var style = document.createElement('style');
      style.innerHTML = 
        '.content-protection {' +
        '  -webkit-user-select: none !important;' +
        '  -moz-user-select: none !important;' +
        '  -ms-user-select: none !important;' +
        '  user-select: none !important;' +
        '  -webkit-touch-callout: none !important;' +
        '  -webkit-tap-highlight-color: transparent !important;' +
        '  pointer-events: none !important;' +
        '  -webkit-user-drag: none !important;' +
        '  -khtml-user-drag: none !important;' +
        '  -moz-user-drag: none !important;' +
        '  -o-user-drag: none !important;' +
        '  user-drag: none !important;' +
        '}';
      document.head.appendChild(style);
    ''']);
  }

  /// 보안 위반 처리
  void _handleSecurityViolation(String message) {
    if (widget.onSecurityViolation != null) {
      widget.onSecurityViolation!();
    }
    
    // 기본 경고 메시지 표시
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.security, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.red[600],
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget protectedContent = widget.child;

    // 우클릭 방지 레이어
    if (widget.enableRightClickPrevention) {
      protectedContent = RightClickBlocker(
        enableTouchContextMenuBlock: true,
        enableKeyboardShortcutBlock: widget.enableScreenshotPrevention,
        enableImageProtection: true,
        enableTextSelectionBlock: widget.enableTextSelectionPrevention,
        onRightClickAttempt: () => _handleSecurityViolation('우클릭이 차단되었습니다'),
        customBlockMessage: '이 콘텐츠는 보호되어 있습니다',
        child: protectedContent,
      );
    }

    // 개발자 도구 감지 레이어
    if (widget.enableDevToolsDetection) {
      protectedContent = DevToolsDetector(
        enableBlurOnDetection: true,
        enableOverlayOnDetection: true,
        enableAutoReload: false,
        customWarningMessage: '보안상의 이유로 개발자 도구 사용이 제한됩니다.\n페이지를 새로고침하여 계속 이용해주세요.',
        overlayColor: Colors.black87,
        onDevToolsStateChanged: (isOpen, method) {
          setState(() {
            _isDevToolsOpen = isOpen;
          });
          if (isOpen) {
            _handleSecurityViolation('개발자 도구가 감지되었습니다 ($method)');
          }
        },
        onSecurityViolation: (type) {
          _handleSecurityViolation('보안 위반: $type');
        },
        child: protectedContent,
      );
    }

    // 워터마크 오버레이 레이어
    if (widget.enableWatermark && _currentWatermarkText != null) {
      protectedContent = WatermarkOverlay(
        text: _currentWatermarkText!,
        color: widget.watermarkColor,
        opacity: widget.watermarkOpacity,
        fontSize: widget.watermarkFontSize,
        fontWeight: FontWeight.w500,
        pattern: WatermarkPattern.diagonal,
        spacing: 180.0,
        rotation: -0.2,
        enableAnimation: false,
        enableTimestamp: true,
        enableUserInfo: true,
        child: protectedContent,
      );
    }

    // 텍스트 선택 방지 레이어 (추가 보안)
    if (widget.enableTextSelectionPrevention) {
      protectedContent = SelectionContainer.disabled(
        child: protectedContent,
      );
    }

    return protectedContent;
  }

}