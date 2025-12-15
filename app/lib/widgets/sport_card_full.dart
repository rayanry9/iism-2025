import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/constants/sport.dart';

class SportCardFull extends StatelessWidget {
  final Widget child;
  final int? sportId;
  final int role;
  const SportCardFull({
    super.key,
    required this.child,
    this.sportId,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      height: 120,
      decoration: BoxDecoration(
        border: BoxBorder.all(color: CustomColors.lightGray, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    ClipPath(
                      clipper: _ClipperLightBlue(),
                      child: Container(
                        color: CustomColors.lightBlue,
                        width: double.infinity,
                      ),
                    ),
                    ClipPath(
                      clipper: _ClipperBlue(),
                      child: Container(
                        color: CustomColors.blue,
                        width: double.infinity,
                      ),
                    ),
                    ClipPath(
                      clipper: _ClipperDarkBlue(),
                      child: Container(
                        color: CustomColors.darkBlue,
                        width: double.infinity,
                      ),
                    ),
                    Positioned(
                      top: constraints.maxHeight * 0.1,
                      left: 0,
                      right: constraints.maxWidth * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            sportId != null
                                ? getSportFromSportId(
                                    sportId!,
                                  )!.displayName.toUpperCase()
                                : role == 6
                                ? "Staff"
                                : "Members",
                            style: TextStyle(
                              fontSize: Constants.titlesTextSize,
                              color: Colors.white,
                            ),
                          ),
                          sportId != null
                              ? !isSportIdFemale(sportId!)
                                    ? Icon(
                                        Icons.male,
                                        color: Colors.lightBlueAccent,
                                        size: 24,
                                      )
                                    : Icon(
                                        Icons.female,
                                        color: CustomColors.pink,
                                        size: 24,
                                      )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),

                    sportId != null
                        ? Positioned(
                            bottom: constraints.maxHeight * -0.4,
                            left: 0,
                            right: constraints.maxWidth * 0.2,
                            child: Image.asset(
                              getSportImageSrc(getSportFromSportId(sportId!))!,
                              fit: BoxFit.contain,
                              height: constraints.maxHeight,
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                );
              },
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _ClipperDarkBlue extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.8, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class _ClipperLightBlue extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.87, 0);
    path.lineTo(size.width * 0.98, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class _ClipperBlue extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.91, 0);
    path.lineTo(size.width * 0.90, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
