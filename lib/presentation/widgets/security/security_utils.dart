import 'package:flutter/foundation.dart';
import 'dart:html' as html;
import 'dart:js' as js;

/// 보안 유틸리티 클래스 - Flutter Web 보안 기능 제공
class SecurityUtils {
  static bool _isInitialized = false;
  
  /// 데모 모드 플래그 - 개발/데모 시 보안 기능 비활성화
  static bool isDemoMode = true; // 데모 상태에서는 보안 기능 비활성화
  
  /// 데모 모드 설정
  static void setDemoMode(bool enabled) {
    isDemoMode = enabled;
    if (enabled) {
      // 데모 모드 활성화 시 기존 보안 기능 정리
      dispose();
      _isInitialized = false;
    } else {
      // 데모 모드 비활성화 시 보안 기능 재초기화
      initialize();
    }
  }
  
  /// 보안 기능 초기화
  static void initialize() {
    if (!kIsWeb || _isInitialized || isDemoMode) return;
    
    _setupGlobalSecurity();
    _isInitialized = true;
  }

  /// 전역 보안 설정
  static void _setupGlobalSecurity() {
    // 콘솔 메시지 차단
    _blockConsoleMessages();
    
    // 페이지 소스 보기 방지
    _preventViewSource();
    
    // 이미지 저장 방지
    _preventImageSaving();
    
    // 브라우저 컨텍스트 메뉴 커스터마이징
    _customizeContextMenu();
  }

  /// 콘솔 메시지 차단
  static void _blockConsoleMessages() {
    js.context.callMethod('eval', ['''
      (function() {
        var originalConsole = console;
        console = {
          log: function() { return false; },
          error: function() { return false; },
          warn: function() { return false; },
          info: function() { return false; },
          debug: function() { return false; },
          clear: function() { return false; },
          dir: function() { return false; },
          dirxml: function() { return false; },
          table: function() { return false; },
          trace: function() { return false; },
          group: function() { return false; },
          groupCollapsed: function() { return false; },
          groupEnd: function() { return false; },
          time: function() { return false; },
          timeLog: function() { return false; },
          timeEnd: function() { return false; },
          timeStamp: function() { return false; },
          profile: function() { return false; },
          profileEnd: function() { return false; },
          count: function() { return false; },
          countReset: function() { return false; }
        };
        
        // 개발 모드에서는 원본 콘솔 유지
        if (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1') {
          console = originalConsole;
        }
      })();
    ''']);
  }

  /// 페이지 소스 보기 방지
  static void _preventViewSource() {
    js.context.callMethod('eval', ['''
      document.addEventListener('keydown', function(e) {
        // Ctrl+U (페이지 소스)
        if (e.ctrlKey && e.keyCode === 85) {
          e.preventDefault();
          return false;
        }
        
        // Ctrl+Shift+C (요소 검사)
        if (e.ctrlKey && e.shiftKey && e.keyCode === 67) {
          e.preventDefault();
          return false;
        }
        
        // Ctrl+A (전체 선택) - 콘텐츠에서만 방지
        if (e.ctrlKey && e.keyCode === 65 && e.target.closest('.content-protection')) {
          e.preventDefault();
          return false;
        }
      });
    ''']);
  }

  /// 이미지 저장 방지
  static void _preventImageSaving() {
    js.context.callMethod('eval', ['''
      document.addEventListener('dragstart', function(e) {
        if (e.target.tagName === 'IMG') {
          e.preventDefault();
          return false;
        }
      });
      
      // 이미지 우클릭 방지
      document.addEventListener('contextmenu', function(e) {
        if (e.target.tagName === 'IMG') {
          e.preventDefault();
          return false;
        }
      });
    ''']);
  }

  /// 브라우저 컨텍스트 메뉴 커스터마이징
  static void _customizeContextMenu() {
    js.context.callMethod('eval', ['''
      document.addEventListener('contextmenu', function(e) {
        // 보호된 콘텐츠 영역에서 우클릭 방지
        if (e.target.closest('.content-protection')) {
          e.preventDefault();
          
          // 커스텀 알림 표시
          var notification = document.createElement('div');
          notification.textContent = '이 콘텐츠는 보호되어 있습니다';
          notification.style.cssText = 
            'position: fixed; top: 20px; right: 20px; background: #f44336; color: white; ' +
            'padding: 12px 16px; border-radius: 4px; font-size: 14px; z-index: 9999; ' +
            'box-shadow: 0 4px 12px rgba(0,0,0,0.3); animation: slideIn 0.3s ease;';
          
          document.body.appendChild(notification);
          
          setTimeout(function() {
            document.body.removeChild(notification);
          }, 2000);
          
          return false;
        }
      });
      
      // 슬라이드인 애니메이션 CSS
      var style = document.createElement('style');
      style.innerHTML = 
        '@keyframes slideIn {' +
        '  from { transform: translateX(100%); opacity: 0; }' +
        '  to { transform: translateX(0); opacity: 1; }' +
        '}';
      document.head.appendChild(style);
    ''']);
  }

  /// 워터마크 텍스트 생성
  static String generateWatermarkText(String? userId, String? username) {
    if (userId != null && username != null) {
      final now = DateTime.now();
      return '$username (${now.day}/${now.month}/${now.year})';
    }
    return '© 구독자 전용 콘텐츠';
  }

  /// 화면 녹화 감지 (실험적 기능)
  static void setupScreenRecordingDetection(Function? onDetected) {
    if (!kIsWeb || isDemoMode) return;
    
    js.context.callMethod('eval', ['''
      (function() {
        var isRecording = false;
        
        // Media Devices API를 통한 화면 캡처 감지
        if (navigator.mediaDevices && navigator.mediaDevices.getDisplayMedia) {
          var originalGetDisplayMedia = navigator.mediaDevices.getDisplayMedia;
          
          navigator.mediaDevices.getDisplayMedia = function() {
            isRecording = true;
            window.postMessage({type: 'SCREEN_RECORDING_DETECTED'}, '*');
            return originalGetDisplayMedia.apply(this, arguments);
          };
        }
        
        // Performance API를 통한 녹화 프로그램 감지 (간접적)
        setInterval(function() {
          if (performance.now() - window.performance.timing.navigationStart > 1000) {
            var entries = performance.getEntriesByType('resource');
            var suspiciousEntries = entries.filter(function(entry) {
              return entry.name.includes('record') || 
                     entry.name.includes('capture') ||
                     entry.name.includes('screen');
            });
            
            if (suspiciousEntries.length > 0 && !isRecording) {
              isRecording = true;
              window.postMessage({type: 'SCREEN_RECORDING_SUSPECTED'}, '*');
            }
          }
        }, 2000);
      })();
    ''']);

    // 메시지 리스너
    html.window.addEventListener('message', (event) {
      final messageEvent = event as html.MessageEvent;
      if (messageEvent.data['type'] == 'SCREEN_RECORDING_DETECTED' ||
          messageEvent.data['type'] == 'SCREEN_RECORDING_SUSPECTED') {
        onDetected?.call();
      }
    });
  }

  /// 개발자 도구 열림 감지 고급 버전
  static void setupAdvancedDevToolsDetection(Function(bool) onStateChanged) {
    if (!kIsWeb || isDemoMode) return;
    
    js.context.callMethod('eval', ['''
      (function() {
        var devtools = {open: false, orientation: null};
        var threshold = 160;
        var lastCheck = Date.now();
        
        function check() {
          var now = Date.now();
          var timeDiff = now - lastCheck;
          lastCheck = now;
          
          // 시간 기반 감지 (디버거로 인한 지연)
          if (timeDiff > 100) {
            if (!devtools.open) {
              devtools.open = true;
              window.postMessage({type: 'DEVTOOLS_OPENED', method: 'timing'}, '*');
            }
            return;
          }
          
          // 크기 기반 감지
          if (window.outerHeight - window.innerHeight > threshold || 
              window.outerWidth - window.innerWidth > threshold) {
            if (!devtools.open) {
              devtools.open = true;
              devtools.orientation = window.outerWidth - window.innerWidth > threshold ? 'vertical' : 'horizontal';
              window.postMessage({type: 'DEVTOOLS_OPENED', method: 'size', orientation: devtools.orientation}, '*');
            }
          } else {
            if (devtools.open) {
              devtools.open = false;
              window.postMessage({type: 'DEVTOOLS_CLOSED'}, '*');
            }
          }
        }
        
        // 여러 방법으로 감지
        setInterval(check, 500);
        
        // Console API 후킹
        var element = new Image();
        Object.defineProperty(element, 'id', {
          get: function() {
            if (!devtools.open) {
              devtools.open = true;
              window.postMessage({type: 'DEVTOOLS_OPENED', method: 'console'}, '*');
            }
            throw new Error('DevTools detected');
          }
        });
        
        setInterval(function() {
          console.clear();
          console.log(element);
          console.clear();
        }, 1000);
        
        // toString 후킹
        var func = function() {};
        func.toString = function() {
          if (!devtools.open) {
            devtools.open = true;
            window.postMessage({type: 'DEVTOOLS_OPENED', method: 'toString'}, '*');
          }
          return 'function() { [native code] }';
        };
        
        setInterval(function() {
          console.log(func);
        }, 1000);
      })();
    ''']);

    // 메시지 리스너
    html.window.addEventListener('message', (event) {
      final messageEvent = event as html.MessageEvent;
      if (messageEvent.data['type'] == 'DEVTOOLS_OPENED') {
        onStateChanged(true);
      } else if (messageEvent.data['type'] == 'DEVTOOLS_CLOSED') {
        onStateChanged(false);
      }
    });
  }

  /// 보안 이벤트 로깅
  static void logSecurityEvent(String event, Map<String, dynamic>? data) {
    if (kDebugMode) {
      print('🔒 Security Event: $event');
      if (data != null) {
        print('   Data: $data');
      }
    }
    
    // 실제 앱에서는 서버로 보안 이벤트 전송
    // _sendSecurityEventToServer(event, data);
  }

  /// 현재 보안 상태 확인
  static Map<String, bool> getSecurityStatus() {
    return {
      'isInitialized': _isInitialized,
      'isWebPlatform': kIsWeb,
      'isDebugMode': kDebugMode,
      'isProfileMode': kProfileMode,
      'isReleaseMode': kReleaseMode,
      'isDemoMode': isDemoMode,
    };
  }

  /// 보안 기능 정리
  static void dispose() {
    if (!kIsWeb || isDemoMode) return;
    
    // JavaScript 이벤트 리스너 정리
    js.context.callMethod('eval', ['''
      // 생성된 이벤트 리스너들을 정리
      if (window.securityListeners) {
        window.securityListeners.forEach(function(cleanup) {
          if (typeof cleanup === 'function') cleanup();
        });
        window.securityListeners = [];
      }
    ''']);
  }
}