import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:html' as html;
import 'dart:js' as js;

/// 우클릭 방지 전용 위젯
/// 모든 형태의 우클릭, 롱프레스, 컨텍스트 메뉴를 차단하는 전문 위젯
class RightClickBlocker extends StatefulWidget {
  final Widget child;
  final bool enableTouchContextMenuBlock;
  final bool enableKeyboardShortcutBlock;
  final bool enableImageProtection;
  final bool enableTextSelectionBlock;
  final VoidCallback? onRightClickAttempt;
  final String? customBlockMessage;

  const RightClickBlocker({
    Key? key,
    required this.child,
    this.enableTouchContextMenuBlock = true,
    this.enableKeyboardShortcutBlock = true,
    this.enableImageProtection = true,
    this.enableTextSelectionBlock = true,
    this.onRightClickAttempt,
    this.customBlockMessage,
  }) : super(key: key);

  @override
  State<RightClickBlocker> createState() => _RightClickBlockerState();
}

class _RightClickBlockerState extends State<RightClickBlocker> {
  late String _blockMessage;

  @override
  void initState() {
    super.initState();
    _blockMessage = widget.customBlockMessage ?? '이 콘텐츠는 보호되어 있습니다';
    
    if (kIsWeb) {
      _initializeWebRightClickBlocking();
    }
  }

  /// Web 우클릭 차단 초기화
  void _initializeWebRightClickBlocking() {
    // 컨텍스트 메뉴 완전 차단
    _setupContextMenuBlocking();
    
    // 키보드 단축키 차단
    if (widget.enableKeyboardShortcutBlock) {
      _setupKeyboardShortcutBlocking();
    }
    
    // 이미지 보호
    if (widget.enableImageProtection) {
      _setupImageProtection();
    }
    
    // 드래그 방지
    _setupDragPrevention();
    
    // 선택 방지 CSS
    if (widget.enableTextSelectionBlock) {
      _setupSelectionPrevention();
    }
  }

  /// 컨텍스트 메뉴 차단 설정
  void _setupContextMenuBlocking() {
    js.context.callMethod('eval', ['''
      (function() {
        // 우클릭 완전 차단
        document.addEventListener('contextmenu', function(e) {
          e.preventDefault();
          e.stopPropagation();
          e.stopImmediatePropagation();
          
          // 커스텀 알림 표시
          window.postMessage({
            type: 'RIGHT_CLICK_BLOCKED',
            x: e.clientX,
            y: e.clientY,
            target: e.target.tagName
          }, '*');
          
          return false;
        }, { passive: false, capture: true });
        
        // 마우스 다운 이벤트에서도 우클릭 차단
        document.addEventListener('mousedown', function(e) {
          if (e.button === 2) { // 우클릭
            e.preventDefault();
            e.stopPropagation();
            return false;
          }
        }, { passive: false, capture: true });
        
        // 마우스 업 이벤트에서도 우클릭 차단
        document.addEventListener('mouseup', function(e) {
          if (e.button === 2) { // 우클릭
            e.preventDefault();
            e.stopPropagation();
            return false;
          }
        }, { passive: false, capture: true });
        
        // 터치 이벤트에서 롱프레스 차단
        var touchTimer;
        document.addEventListener('touchstart', function(e) {
          if (e.target.closest('.content-protection')) {
            touchTimer = setTimeout(function() {
              e.preventDefault();
              window.postMessage({type: 'LONG_PRESS_BLOCKED'}, '*');
            }, 500);
          }
        });
        
        document.addEventListener('touchend', function(e) {
          if (touchTimer) {
            clearTimeout(touchTimer);
          }
        });
        
        document.addEventListener('touchmove', function(e) {
          if (touchTimer) {
            clearTimeout(touchTimer);
          }
        });
      })();
    ''']);

    // 메시지 리스너 등록
    html.window.addEventListener('message', (html.MessageEvent event) {
      if (event.data['type'] == 'RIGHT_CLICK_BLOCKED') {
        _handleRightClickBlocked(event.data);
      } else if (event.data['type'] == 'LONG_PRESS_BLOCKED') {
        _handleLongPressBlocked();
      }
    });
  }

  /// 키보드 단축키 차단 설정
  void _setupKeyboardShortcutBlocking() {
    js.context.callMethod('eval', ['''
      document.addEventListener('keydown', function(e) {
        var isBlocked = false;
        
        // 차단할 키 조합들
        if (
          // 개발자 도구 관련
          e.keyCode === 123 || // F12
          (e.ctrlKey && e.shiftKey && e.keyCode === 73) || // Ctrl+Shift+I
          (e.ctrlKey && e.shiftKey && e.keyCode === 74) || // Ctrl+Shift+J
          (e.ctrlKey && e.shiftKey && e.keyCode === 67) || // Ctrl+Shift+C
          
          // 소스 보기 관련
          (e.ctrlKey && e.keyCode === 85) || // Ctrl+U
          
          // 저장 관련
          (e.ctrlKey && e.keyCode === 83) || // Ctrl+S
          
          // 인쇄 관련
          (e.ctrlKey && e.keyCode === 80) || // Ctrl+P
          
          // 스크린샷 관련
          e.keyCode === 44 || // PrtScr
          (e.altKey && e.keyCode === 44) || // Alt+PrtScr
          
          // 전체 선택 (보호된 콘텐츠에서만)
          (e.ctrlKey && e.keyCode === 65 && e.target.closest('.content-protection'))
        ) {
          isBlocked = true;
        }
        
        if (isBlocked) {
          e.preventDefault();
          e.stopPropagation();
          e.stopImmediatePropagation();
          
          window.postMessage({
            type: 'KEYBOARD_SHORTCUT_BLOCKED',
            keyCode: e.keyCode,
            ctrl: e.ctrlKey,
            shift: e.shiftKey,
            alt: e.altKey
          }, '*');
          
          return false;
        }
      }, { passive: false, capture: true });
    ''']);
  }

  /// 이미지 보호 설정
  void _setupImageProtection() {
    js.context.callMethod('eval', ['''
      // 이미지 드래그 방지
      document.addEventListener('dragstart', function(e) {
        if (e.target.tagName === 'IMG' || 
            e.target.style.backgroundImage ||
            e.target.closest('.content-protection')) {
          e.preventDefault();
          window.postMessage({type: 'IMAGE_DRAG_BLOCKED'}, '*');
          return false;
        }
      }, { passive: false, capture: true });
      
      // 이미지 선택 방지
      document.addEventListener('selectstart', function(e) {
        if (e.target.tagName === 'IMG' || 
            e.target.closest('.content-protection')) {
          e.preventDefault();
          return false;
        }
      }, { passive: false, capture: true });
      
      // 이미지 저장 방지 (우클릭 차단과 함께)
      document.addEventListener('contextmenu', function(e) {
        if (e.target.tagName === 'IMG') {
          e.preventDefault();
          e.stopPropagation();
          window.postMessage({type: 'IMAGE_CONTEXT_BLOCKED'}, '*');
          return false;
        }
      }, { passive: false, capture: true });
    ''']);
  }

  /// 드래그 방지 설정
  void _setupDragPrevention() {
    js.context.callMethod('eval', ['''
      document.addEventListener('drag', function(e) {
        if (e.target.closest('.content-protection')) {
          e.preventDefault();
          return false;
        }
      }, { passive: false });
      
      document.addEventListener('dragstart', function(e) {
        if (e.target.closest('.content-protection')) {
          e.preventDefault();
          window.postMessage({type: 'CONTENT_DRAG_BLOCKED'}, '*');
          return false;
        }
      }, { passive: false });
    ''']);
  }

  /// 선택 방지 CSS 설정
  void _setupSelectionPrevention() {
    js.context.callMethod('eval', ['''
      var style = document.createElement('style');
      style.innerHTML = 
        '.content-protection, .content-protection * {' +
        '  -webkit-user-select: none !important;' +
        '  -moz-user-select: none !important;' +
        '  -ms-user-select: none !important;' +
        '  user-select: none !important;' +
        '  -webkit-touch-callout: none !important;' +
        '  -webkit-tap-highlight-color: transparent !important;' +
        '}' +
        '.content-protection img {' +
        '  -webkit-user-drag: none !important;' +
        '  -khtml-user-drag: none !important;' +
        '  -moz-user-drag: none !important;' +
        '  -o-user-drag: none !important;' +
        '  user-drag: none !important;' +
        '  pointer-events: none !important;' +
        '}';
      document.head.appendChild(style);
    ''']);
  }

  /// 우클릭 차단 처리
  void _handleRightClickBlocked(Map<String, dynamic> data) {
    if (widget.onRightClickAttempt != null) {
      widget.onRightClickAttempt!();
    }

    // 차단 알림 표시
    _showBlockNotification(
      message: _blockMessage,
      position: Offset(
        data['x']?.toDouble() ?? 0,
        data['y']?.toDouble() ?? 0,
      ),
    );
  }

  /// 롱프레스 차단 처리
  void _handleLongPressBlocked() {
    if (widget.onRightClickAttempt != null) {
      widget.onRightClickAttempt!();
    }

    // 햅틱 피드백
    HapticFeedback.lightImpact();

    // 알림 표시
    _showBlockNotification(message: '롱프레스가 차단되었습니다');
  }

  /// 차단 알림 표시
  void _showBlockNotification({
    required String message,
    Offset? position,
  }) {
    if (!mounted) return;

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: position?.dx ?? MediaQuery.of(context).size.width * 0.5 - 100,
        top: position?.dy ?? MediaQuery.of(context).size.height * 0.3,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.red[600],
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.block,
                  color: Colors.white,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // 2초 후 제거
    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 모바일에서 롱프레스 차단
      onLongPress: widget.enableTouchContextMenuBlock
          ? () {
              HapticFeedback.lightImpact();
              _showBlockNotification(message: '롱프레스가 차단되었습니다');
            }
          : null,
      
      // 드래그 차단
      onPanStart: (_) {
        _showBlockNotification(message: '드래그가 차단되었습니다');
      },
      
      child: Container(
        // CSS 클래스 적용을 위한 키 설정
        key: const Key('content-protection'),
        child: widget.child,
      ),
    );
  }
}