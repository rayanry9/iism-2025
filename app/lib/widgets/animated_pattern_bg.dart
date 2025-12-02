import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class AnimatedPatternBackground extends StatefulWidget {
  const AnimatedPatternBackground({super.key});

  @override
  State<AnimatedPatternBackground> createState() => _AnimatedPatternBackgroundState();
}

class _AnimatedPatternBackgroundState extends State<AnimatedPatternBackground>
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  ui.Image? _pattern; // this will hold the loaded WEBP image

  @override
  void initState() {
    super.initState();

    // Animation controller (0 → 1 → 0 → repeat)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _loadPattern();
  }

  /// Load WEBP image as ui.Image for use in CustomPaint
  Future<void> _loadPattern() async {
    final data = await rootBundle.load('assets/pattern.webp');

    final codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
    );

    final frame = await codec.getNextFrame();

    setState(() {
      _pattern = frame.image; // ready to draw!
    });
  }

  @override
  Widget build(BuildContext context) {
    // If image not loaded, just show nothing
    if (_pattern == null) {
      return const SizedBox.expand();
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return CustomPaint(
          painter: PatternPainter(
            image: _pattern!,
            shift: _controller.value,
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

  PatternPainter({
    required this.image,
    required this.shift,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // 🌟 1. Rotate the entire canvas (adjust angle for your look)
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(0.25); // ~ -26°, tweak to match exactly
    canvas.translate(-size.width / 2, -size.height / 2);

    // 🌟 2. Movement for animation
    final dx = shift * 200;
    final dy = shift * 200;

    // 🌟 3. Tile size (adjust as needed)
    final scale = 0.45;  // ratio based on your reference tile density
    final tileW = image.width * scale;
    final tileH = image.height * scale;

    // Source rectangle
    final src = Rect.fromLTWH(
      0,
      0,
      image.width.toDouble(),
      image.height.toDouble(),
    );

    // 🌟 4. Tile the pattern in a grid
    for (double x = -tileW + dx; x < size.width + tileW; x += tileW) {
      for (double y = -tileH + dy; y < size.height + tileH; y += tileH) {
        final dst = Rect.fromLTWH(x, y, tileW, tileH);
        canvas.drawImageRect(image, src, dst, paint);
      }
    }

    canvas.restore(); // restore rotation
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
