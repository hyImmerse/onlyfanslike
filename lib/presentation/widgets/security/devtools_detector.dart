import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:async';
import 'dart:ui';

import 'security_utils.dart';

/// 개발자 도구 감지기
/// 다양한 방법을 통해 개발자 도구 열림을 감지하고 대응하는 전문 위젯
class DevToolsDetector extends StatefulWidget {
  final Widget child;
  final Function(bool isOpen, String method)? onDevToolsStateChanged;
  final Function(String violationType)? onSecurityViolation;
  final bool enableBlurOnDetection;
  final bool enableOverlayOnDetection;
  final bool enableAutoReload;
  final String? customWarningMessage;
  final Color overlayColor;

  const DevToolsDetector({
    Key? key,
    required this.child,
    this.onDevToolsStateChanged,
    this.onSecurityViolation,
    this.enableBlurOnDetection = true,
    this.enableOverlayOnDetection = true,
    this.enableAutoReload = false,
    this.customWarningMessage,
    this.overlayColor = Colors.black87,
  }) : super(key: key);

  @override
  State<DevToolsDetector> createState() => _DevToolsDetectorState();
}

class _DevToolsDetectorState extends State<DevToolsDetector>
    with SingleTickerProviderStateMixin {
  bool _isDevToolsOpen = false;
  String _detectionMethod = '';
  late String _warningMessage;
  StreamSubscription? _messageSubscription;
  Timer? _detectionTimer;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _warningMessage = widget.customWarningMessage ??
        '보안상의 이유로 개발자 도구 사용이 제한됩니다.\n페이지를 새로고침하여 계속 이용해주세요.';

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    ));

    // 데모 모드가 아닐 때만 개발자 도구 감지 활성화
    if (kIsWeb && !SecurityUtils.isDemoMode) {
      _initializeDevToolsDetection();
    }
  }

  @override
  void dispose() {
    _detectionTimer?.cancel();
    _messageSubscription?.cancel();
    _animationController.dispose();
    _cleanupDetection();
    super.dispose();
  }

  /// 개발자 도구 감지 초기화
  void _initializeDevToolsDetection() {
    // 다중 감지 방법 설정
    _setupMultiMethodDetection();
    
    // 메시지 리스너 설정
    _setupMessageListener();
    
    // 주기적 검사 시작
    _startPeriodicCheck();
  }

  /// 다중 감지 방법 설정
  void _setupMultiMethodDetection() {
    js.context.callMethod('eval', ['''
      (function() {
        var devtools = {
          open: false,
          orientation: null,
          methods: []
        };
        
        var threshold = 160;
        var startTime = Date.now();
        
        // 방법 1: 브라우저 창 크기 감지
        function checkWindowSize() {
          if (window.outerHeight - window.innerHeight > threshold || 
              window.outerWidth - window.innerWidth > threshold) {
            if (!devtools.open) {
              devtools.open = true;
              devtools.orientation = window.outerWidth - window.innerWidth > threshold ? 'vertical' : 'horizontal';
              devtools.methods.push('window-size');
              window.postMessage({
                type: 'DEVTOOLS_DETECTED',
                method: 'window-size',
                orientation: devtools.orientation
              }, '*');
            }
          } else {
            if (devtools.open && devtools.methods.includes('window-size')) {
              devtools.open = false;
              devtools.methods = devtools.methods.filter(m => m !== 'window-size');
              window.postMessage({type: 'DEVTOOLS_CLOSED', method: 'window-size'}, '*');
            }
          }
        }
        
        // 방법 2: Console API 후킹
        function setupConsoleHook() {
          var image = new Image();
          Object.defineProperty(image, 'id', {
            get: function() {
              if (!devtools.open) {
                devtools.open = true;
                devtools.methods.push('console-hook');
                window.postMessage({type: 'DEVTOOLS_DETECTED', method: 'console-hook'}, '*');
              }
              return 'devtools-detector';
            }
          });
          
          setInterval(function() {
            console.clear();
            console.log(image);
            console.clear();
          }, 1000);
        }
        
        // 방법 3: Function.prototype.toString 후킹
        function setupToStringHook() {
          var func = function() {};
          func.toString = function() {
            if (!devtools.open) {
              devtools.open = true;
              devtools.methods.push('toString-hook');
              window.postMessage({type: 'DEVTOOLS_DETECTED', method: 'toString-hook'}, '*');
            }
            return 'function() { [native code] }';
          };
          
          setInterval(function() {
            console.log(func);
          }, 2000);
        }
        
        // 방법 4: 디버거 문 감지
        function setupDebuggerDetection() {
          setInterval(function() {
            var before = Date.now();
            debugger;
            var after = Date.now();
            
            if (after - before > 100) {
              if (!devtools.open) {
                devtools.open = true;
                devtools.methods.push('debugger-statement');
                window.postMessage({type: 'DEVTOOLS_DETECTED', method: 'debugger-statement'}, '*');
              }
            }
          }, 5000);
        }
        
        // 방법 5: 성능 기반 감지
        function setupPerformanceDetection() {
          var element = document.createElement('div');
          Object.defineProperty(element, 'id', {
            get: function() {
              if (!devtools.open) {
                devtools.open = true;
                devtools.methods.push('performance-based');
                window.postMessage({type: 'DEVTOOLS_DETECTED', method: 'performance-based'}, '*');
              }
              return 'performance-detector';
            }
          });
          
          setInterval(function() {
            console.log(element);
          }, 3000);
        }
        
        // 방법 6: DevTools Protocol 감지
        function setupProtocolDetection() {
          if (window.chrome && window.chrome.runtime) {
            window.chrome.runtime.onConnect.addListener(function(port) {
              if (!devtools.open) {
                devtools.open = true;
                devtools.methods.push('protocol-detection');
                window.postMessage({type: 'DEVTOOLS_DETECTED', method: 'protocol-detection'}, '*');
              }
            });
          }
        }
        
        // 모든 감지 방법 활성화
        setupConsoleHook();
        setupToStringHook();
        setupDebuggerDetection();
        setupPerformanceDetection();
        setupProtocolDetection();
        
        // 주기적 크기 검사
        setInterval(checkWindowSize, 500);
        
        // 창 크기 변경 이벤트
        window.addEventListener('resize', checkWindowSize);
        
        // 포커스 이벤트
        window.addEventListener('focus', function() {
          setTimeout(checkWindowSize, 100);
        });
        
        // 키보드 이벤트 감지
        document.addEventListener('keydown', function(e) {
          if (e.keyCode === 123 || // F12
              (e.ctrlKey && e.shiftKey && (e.keyCode === 73 || e.keyCode === 74))) { // Ctrl+Shift+I/J
            window.postMessage({type: 'DEVTOOLS_HOTKEY_DETECTED', keyCode: e.keyCode}, '*');
          }
        });
      })();
    ''']);
  }

  /// 메시지 리스너 설정
  void _setupMessageListener() {
    _messageSubscription = html.window.onMessage.listen((html.MessageEvent event) {
      final data = event.data;
      
      if (data['type'] == 'DEVTOOLS_DETECTED') {
        _handleDevToolsDetected(data['method'] ?? 'unknown');
      } else if (data['type'] == 'DEVTOOLS_CLOSED') {
        _handleDevToolsClosed(data['method'] ?? 'unknown');
      } else if (data['type'] == 'DEVTOOLS_HOTKEY_DETECTED') {
        _handleDevToolsHotkey(data['keyCode']);
      }
    });
  }

  /// 주기적 검사 시작
  void _startPeriodicCheck() {
    _detectionTimer = Timer.periodic(const Duration(milliseconds: 1000), (_) {
      if (mounted && _isDevToolsOpen) {
        _checkDevToolsStillOpen();
      }
    });
  }

  /// 개발자 도구 감지 처리
  void _handleDevToolsDetected(String method) {
    if (!_isDevToolsOpen) {
      setState(() {
        _isDevToolsOpen = true;
        _detectionMethod = method;
      });

      _animationController.forward();

      // 콜백 호출
      widget.onDevToolsStateChanged?.call(true, method);
      widget.onSecurityViolation?.call('devtools_opened');

      // 자동 새로고침
      if (widget.enableAutoReload) {
        _scheduleAutoReload();
      }

      // 로깅
      if (kDebugMode) {
        print('🔒 DevTools detected using method: $method');
      }
    }
  }

  /// 개발자 도구 닫힘 처리
  void _handleDevToolsClosed(String method) {
    if (_isDevToolsOpen && _detectionMethod == method) {
      setState(() {
        _isDevToolsOpen = false;
        _detectionMethod = '';
      });

      _animationController.reverse();

      // 콜백 호출
      widget.onDevToolsStateChanged?.call(false, method);
    }
  }

  /// 개발자 도구 단축키 감지 처리
  void _handleDevToolsHotkey(int keyCode) {
    widget.onSecurityViolation?.call('devtools_hotkey');
    
    // 단축키 차단 알림
    _showHotkeyBlockedNotification(keyCode);
  }

  /// 개발자 도구가 여전히 열려있는지 확인
  void _checkDevToolsStillOpen() {
    js.context.callMethod('eval', ['''
      var threshold = 160;
      if (!(window.outerHeight - window.innerHeight > threshold || 
            window.outerWidth - window.innerWidth > threshold)) {
        window.postMessage({type: 'DEVTOOLS_POSSIBLY_CLOSED'}, '*');
      }
    ''']);
  }

  /// 자동 새로고침 예약
  void _scheduleAutoReload() {
    Timer(const Duration(seconds: 5), () {
      if (_isDevToolsOpen && mounted) {
        html.window.location.reload();
      }
    });
  }

  /// 단축키 차단 알림 표시
  void _showHotkeyBlockedNotification(int keyCode) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.block, color: Colors.white, size: 16),
            const SizedBox(width: 8),
            Text('개발자 도구 단축키가 차단되었습니다 (F${keyCode == 123 ? "12" : ""})',
              style: const TextStyle(fontSize: 12)),
          ],
        ),
        backgroundColor: Colors.red[600],
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  /// 감지 정리
  void _cleanupDetection() {
    if (!kIsWeb) return;
    
    js.context.callMethod('eval', ['''
      // 생성된 타이머들 정리
      if (window.devToolsCleanup) {
        window.devToolsCleanup.forEach(function(cleanup) {
          if (typeof cleanup === 'function') cleanup();
        });
      }
    ''']);
  }

  @override
  Widget build(BuildContext context) {
    // 데모 모드일 때는 보안 기능 비활성화
    if (SecurityUtils.isDemoMode) {
      return widget.child;
    }

    return Stack(
      children: [
        // 원본 콘텐츠
        widget.enableBlurOnDetection && _isDevToolsOpen
            ? ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: widget.child,
              )
            : widget.child,

        // 개발자 도구 감지 오버레이
        if (widget.enableOverlayOnDetection && _isDevToolsOpen)
          _buildDetectionOverlay(),
      ],
    );
  }

  /// 감지 오버레이 생성
  Widget _buildDetectionOverlay() {
    return Positioned.fill(
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              color: widget.overlayColor,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(32),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.red[600],
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.security,
                        color: Colors.white,
                        size: 64,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        '🛡️ 보안 경고',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _warningMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '감지 방법: $_detectionMethod',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              html.window.location.reload();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.red[600],
                            ),
                            icon: const Icon(Icons.refresh, size: 16),
                            label: const Text('새로고침'),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              js.context.callMethod('alert', [
                                '개발자 도구를 닫은 후 페이지를 새로고침하세요.'
                              ]);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white),
                            ),
                            icon: const Icon(Icons.help_outline, size: 16),
                            label: const Text('도움말'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}