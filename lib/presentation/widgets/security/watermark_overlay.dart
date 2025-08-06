import 'package:flutter/material.dart';
import 'dart:math' as math;

/// 워터마크 오버레이 위젯
/// 동적이고 다양한 패턴의 워터마크를 생성하여 콘텐츠 보호
class WatermarkOverlay extends StatefulWidget {
  final Widget child;
  final String text;
  final Color color;
  final double opacity;
  final double fontSize;
  final FontWeight fontWeight;
  final WatermarkPattern pattern;
  final double spacing;
  final double rotation;
  final bool enableAnimation;
  final Duration animationDuration;
  final bool enableTimestamp;
  final bool enableUserInfo;
  final String? userId;
  final String? username;

  const WatermarkOverlay({
    Key? key,
    required this.child,
    required this.text,
    this.color = Colors.white,
    this.opacity = 0.15,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w500,
    this.pattern = WatermarkPattern.diagonal,
    this.spacing = 200.0,
    this.rotation = -0.3,
    this.enableAnimation = false,
    this.animationDuration = const Duration(seconds: 30),
    this.enableTimestamp = true,
    this.enableUserInfo = true,
    this.userId,
    this.username,
  }) : super(key: key);

  @override
  State<WatermarkOverlay> createState() => _WatermarkOverlayState();
}

class _WatermarkOverlayState extends State<WatermarkOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late String _finalWatermarkText;

  @override
  void initState() {
    super.initState();
    
    // 애니메이션 컨트롤러 설정
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * math.pi,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.linear,
    ));

    // 워터마크 텍스트 생성
    _generateWatermarkText();

    // 애니메이션 시작
    if (widget.enableAnimation) {
      _animationController.repeat();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  /// 워터마크 텍스트 생성
  void _generateWatermarkText() {
    final buffer = StringBuffer();
    buffer.write(widget.text);

    if (widget.enableUserInfo && widget.username != null) {
      buffer.write(' - ${widget.username}');
    }

    if (widget.enableTimestamp) {
      final now = DateTime.now();
      buffer.write(' (${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')})');
    }

    if (widget.userId != null) {
      buffer.write(' #${widget.userId}');
    }

    _finalWatermarkText = buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 원본 콘텐츠
        widget.child,
        
        // 워터마크 오버레이
        Positioned.fill(
          child: IgnorePointer(
            child: widget.enableAnimation
                ? AnimatedBuilder(
                    animation: _rotationAnimation,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: WatermarkPainter(
                          text: _finalWatermarkText,
                          color: widget.color.withOpacity(widget.opacity),
                          fontSize: widget.fontSize,
                          fontWeight: widget.fontWeight,
                          pattern: widget.pattern,
                          spacing: widget.spacing,
                          rotation: widget.rotation + _rotationAnimation.value * 0.1,
                        ),
                      );
                    },
                  )
                : CustomPaint(
                    painter: WatermarkPainter(
                      text: _finalWatermarkText,
                      color: widget.color.withOpacity(widget.opacity),
                      fontSize: widget.fontSize,
                      fontWeight: widget.fontWeight,
                      pattern: widget.pattern,
                      spacing: widget.spacing,
                      rotation: widget.rotation,
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}

/// 워터마크 패턴 열거형
enum WatermarkPattern {
  diagonal,      // 대각선 패턴
  grid,         // 격자 패턴
  circular,     // 원형 패턴
  wave,         // 웨이브 패턴
  random,       // 랜덤 패턴
}

/// 워터마크 페인터 클래스
class WatermarkPainter extends CustomPainter {
  final String text;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final WatermarkPattern pattern;
  final double spacing;
  final double rotation;

  WatermarkPainter({
    required this.text,
    required this.color,
    required this.fontSize,
    required this.fontWeight,
    required this.pattern,
    required this.spacing,
    required this.rotation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    switch (pattern) {
      case WatermarkPattern.diagonal:
        _paintDiagonalPattern(canvas, size, textPainter);
        break;
      case WatermarkPattern.grid:
        _paintGridPattern(canvas, size, textPainter);
        break;
      case WatermarkPattern.circular:
        _paintCircularPattern(canvas, size, textPainter);
        break;
      case WatermarkPattern.wave:
        _paintWavePattern(canvas, size, textPainter);
        break;
      case WatermarkPattern.random:
        _paintRandomPattern(canvas, size, textPainter);
        break;
    }
  }

  /// 대각선 패턴 그리기
  void _paintDiagonalPattern(Canvas canvas, Size size, TextPainter textPainter) {
    final rows = (size.height / spacing).ceil() + 2;
    final cols = (size.width / spacing).ceil() + 2;

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        final x = j * spacing - (i.isEven ? 0 : spacing / 2);
        final y = i * spacing;
        
        if (x < size.width + textPainter.width && y < size.height + textPainter.height) {
          canvas.save();
          canvas.translate(x, y);
          canvas.rotate(rotation);
          textPainter.paint(canvas, Offset.zero);
          canvas.restore();
        }
      }
    }
  }

  /// 격자 패턴 그리기
  void _paintGridPattern(Canvas canvas, Size size, TextPainter textPainter) {
    final rows = (size.height / spacing).ceil() + 1;
    final cols = (size.width / spacing).ceil() + 1;

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        final x = j * spacing;
        final y = i * spacing;
        
        canvas.save();
        canvas.translate(x, y);
        canvas.rotate(rotation);
        textPainter.paint(canvas, Offset.zero);
        canvas.restore();
      }
    }
  }

  /// 원형 패턴 그리기
  void _paintCircularPattern(Canvas canvas, Size size, TextPainter textPainter) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = math.max(size.width, size.height) / 2;
    final radiusStep = spacing / 2;
    
    for (double radius = radiusStep; radius < maxRadius; radius += radiusStep) {
      final circumference = 2 * math.pi * radius;
      final count = (circumference / (spacing * 1.5)).floor();
      
      for (int i = 0; i < count; i++) {
        final angle = (2 * math.pi * i) / count;
        final x = center.dx + radius * math.cos(angle);
        final y = center.dy + radius * math.sin(angle);
        
        canvas.save();
        canvas.translate(x, y);
        canvas.rotate(angle + rotation);
        textPainter.paint(canvas, 
          Offset(-textPainter.width / 2, -textPainter.height / 2));
        canvas.restore();
      }
    }
  }

  /// 웨이브 패턴 그리기
  void _paintWavePattern(Canvas canvas, Size size, TextPainter textPainter) {
    final rows = (size.height / spacing).ceil() + 1;
    final cols = (size.width / spacing).ceil() + 1;

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        final baseX = j * spacing;
        final baseY = i * spacing;
        
        // 사인파를 이용한 웨이브 효과
        final waveX = baseX + math.sin(baseY / 100) * 50;
        final waveY = baseY + math.cos(baseX / 100) * 30;
        
        canvas.save();
        canvas.translate(waveX, waveY);
        canvas.rotate(rotation + math.sin((baseX + baseY) / 200) * 0.2);
        textPainter.paint(canvas, Offset.zero);
        canvas.restore();
      }
    }
  }

  /// 랜덤 패턴 그리기
  void _paintRandomPattern(Canvas canvas, Size size, TextPainter textPainter) {
    final random = math.Random(42); // 일관된 시드 사용
    final count = ((size.width * size.height) / (spacing * spacing)).ceil();

    for (int i = 0; i < count; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final randomRotation = rotation + (random.nextDouble() - 0.5) * 1.0;
      
      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(randomRotation);
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant WatermarkPainter oldDelegate) {
    return oldDelegate.text != text ||
           oldDelegate.color != color ||
           oldDelegate.fontSize != fontSize ||
           oldDelegate.fontWeight != fontWeight ||
           oldDelegate.pattern != pattern ||
           oldDelegate.spacing != spacing ||
           oldDelegate.rotation != rotation;
  }
}

/// 고급 워터마크 위젯
/// 더 많은 기능과 커스터마이징 옵션 제공
class AdvancedWatermarkOverlay extends StatefulWidget {
  final Widget child;
  final List<WatermarkLayer> layers;
  final bool enableInteractivePrevention;
  final BlendMode blendMode;

  const AdvancedWatermarkOverlay({
    Key? key,
    required this.child,
    required this.layers,
    this.enableInteractivePrevention = true,
    this.blendMode = BlendMode.overlay,
  }) : super(key: key);

  @override
  State<AdvancedWatermarkOverlay> createState() => _AdvancedWatermarkOverlayState();
}

class _AdvancedWatermarkOverlayState extends State<AdvancedWatermarkOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 원본 콘텐츠
        widget.child,
        
        // 다층 워터마크
        ...widget.layers.map((layer) => Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: LayeredWatermarkPainter(
                layer: layer,
                blendMode: widget.blendMode,
              ),
            ),
          ),
        )).toList(),
        
        // 상호작용 방지 레이어
        if (widget.enableInteractivePrevention)
          Positioned.fill(
            child: Container(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () {},
                onLongPress: () {},
                onPanStart: (_) {},
                child: const SizedBox.expand(),
              ),
            ),
          ),
      ],
    );
  }
}

/// 워터마크 레이어 클래스
class WatermarkLayer {
  final String text;
  final Color color;
  final double opacity;
  final double fontSize;
  final FontWeight fontWeight;
  final WatermarkPattern pattern;
  final double spacing;
  final double rotation;
  final Offset offset;

  const WatermarkLayer({
    required this.text,
    this.color = Colors.white,
    this.opacity = 0.15,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w500,
    this.pattern = WatermarkPattern.diagonal,
    this.spacing = 200.0,
    this.rotation = -0.3,
    this.offset = Offset.zero,
  });
}

/// 다층 워터마크 페인터
class LayeredWatermarkPainter extends CustomPainter {
  final WatermarkLayer layer;
  final BlendMode blendMode;

  LayeredWatermarkPainter({
    required this.layer,
    required this.blendMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..blendMode = blendMode;
    
    canvas.saveLayer(Offset.zero & size, paint);
    
    final watermarkPainter = WatermarkPainter(
      text: layer.text,
      color: layer.color.withOpacity(layer.opacity),
      fontSize: layer.fontSize,
      fontWeight: layer.fontWeight,
      pattern: layer.pattern,
      spacing: layer.spacing,
      rotation: layer.rotation,
    );
    
    canvas.translate(layer.offset.dx, layer.offset.dy);
    watermarkPainter.paint(canvas, size);
    
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant LayeredWatermarkPainter oldDelegate) {
    return oldDelegate.layer != layer || oldDelegate.blendMode != blendMode;
  }
}