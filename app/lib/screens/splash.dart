import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/widgets/animated_pattern_bg.dart';

// import 'home.dart';

class SplashScreen extends StatelessWidget {
  // Schedule navigation after first frame is built
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 4));
      // if (!mounted) return;
      //
      // context.replace('/login');
    });
    return Stack(
      children: [
        ClipPath(
          clipper: SplashClipperYellow(),
          child: Container(color: CustomColors.yellow),
        ),
        ClipPath(
          clipper: SplashClipperBlue(),
          child: Stack(
            children: [
              Container(color: CustomColors.blue),
              AnimatedPatternBackground(),
              Center(
                child: SvgPicture.asset(
                  "assets/logo-no-text.svg",
                  height: 140,
                  width: 119,
                  colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SplashClipperYellow extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.01);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.99);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class SplashClipperBlue extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.05);
    path.lineTo(size.width, size.height * 0.02);
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
