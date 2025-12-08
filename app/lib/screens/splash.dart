import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/widgets/animated_pattern_bg.dart';

// import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Schedule navigation after first frame is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 4));
      // if (!mounted) return;
      //
      // context.replace('/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPatternBackground(),
        ClipPath(
          clipper: SplashClipper(),
          child: Container(color: CustomColors.yellow),
        ),
      ],
    );
  }
}

class SplashClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.01);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.02);
    path.lineTo(0, size.height * 0.05);
    path.close();

    path.moveTo(0, size.height);
    path.lineTo(size.width, size.height * 0.99);
    path.lineTo(size.width, size.height * 0.95);
    path.lineTo(0, size.height * 0.98);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
