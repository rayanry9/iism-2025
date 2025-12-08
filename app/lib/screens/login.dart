import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iism_2025/constants/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0.4,
          child: Image.asset(
            "assets/legacy-mobile.webp",
            width: double.infinity,
          ),
        ),
        ClipPath(
          clipper: _SplashClipperYellow(),
          child: Container(color: CustomColors.yellow),
        ),
        ClipPath(
          clipper: _SplashClipperBlue(),
          child: Container(color: CustomColors.blue),
        ),
        ClipPath(
          clipper: _SplashClipperBlue(),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Transform(
              transform: Matrix4.identity()
                ..scaleByDouble(2.5, 2.5, 1, 1)
                ..rotateZ(0.4),
              alignment: Alignment.center,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  "assets/pattern.webp",
                  repeat: ImageRepeat.repeat,
                  scale: 7,
                ),
              ),
            ),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: null,
                height: constraints.maxHeight / 2,
                child: Center(
                  child: SvgPicture.asset(
                    "assets/logo-no-text.svg",
                    width: 140,
                    height: 119,
                    colorFilter: ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        LayoutBuilder(
          builder: (context, constraints) {
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: constraints.maxHeight / 2,
                width: null,
                child: Center(
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.skewX(-0.26),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.orange,
                        foregroundColor: Colors.white,
                        padding: EdgeInsetsGeometry.symmetric(
                          horizontal: 42,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      onPressed: () {
                        context.push("/logindetails");
                      },
                      child: Transform(
                        transform: Matrix4.skewX(0.26),
                        alignment: Alignment.center,
                        child: Text("LOGIN", style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _SplashClipperYellow extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.45);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class _SplashClipperBlue extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.5);
    path.lineTo(size.width, size.height * 0.47);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
