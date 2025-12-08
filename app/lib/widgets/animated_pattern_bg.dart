import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class AnimatedPatternBackground extends StatefulWidget {
  final bool animated;

  const AnimatedPatternBackground({
    super.key,
    this.animated = true, // default: animated pattern
  });

  @override
  State<AnimatedPatternBackground> createState() =>
      _AnimatedPatternBackgroundState();
}

class _AnimatedPatternBackgroundState extends State<AnimatedPatternBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ui.Image? _pattern;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );

    // Only animate when widget.animated == true
    if (widget.animated) {
      _controller.repeat();
    }

    _loadPattern();
  }

  Future<void> _loadPattern() async {
    final data = await rootBundle.load('assets/pattern.webp');
    final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    final frame = await codec.getNextFrame();

    setState(() {
      _pattern = frame.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_pattern == null) {
      return const SizedBox.expand();
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return SizedBox.expand(
        child: CustomPaint(
          painter: PatternPainter(
            image: _pattern!,
            shift: widget.animated ? _controller.value : 0,
          ),
        ),
      );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class PatternPainter extends CustomPainter {
  final ui.Image image;
  final double shift;

  PatternPainter({required this.image, required this.shift});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.4);

    // Rotation
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(0.06);
    canvas.translate(-size.width / 2, -size.height / 2);

    // Movement for animation (or static)
    final dx = shift * 150;
    final dy = shift * 150;

    // Tile scaling
    const scale = 0.3;
    final tileW = image.width * scale;
    final tileH = image.height * scale;

    final src = Rect.fromLTWH(
      0,
      0,
      image.width.toDouble(),
      image.height.toDouble(),
    );

    // Draw tiling
    for (double x = -tileW + dx; x < size.width + tileW; x += tileW) {
      for (double y = -tileH + dy; y < size.height + tileH; y += tileH) {
        final dst = Rect.fromLTWH(x, y, tileW, tileH);
        canvas.drawImageRect(image, src, dst, paint);
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
