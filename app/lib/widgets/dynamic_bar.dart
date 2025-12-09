import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';

class DynamicNavbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? child;
  final Color background;

  const DynamicNavbar({
    this.child,
    this.background = CustomColors.darkBlue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height + 20, // 🔥 Make navbar area taller
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: kToolbarHeight + 30, // aligned with above
            left: 0,
            right: 0,
            child: Transform.rotate(
              angle: 0.07,
              child: Container(height: 45, color: CustomColors.yellow),
            ),
          ),
          Positioned(
            top: kToolbarHeight + 23, // 🔥 push BELOW BLUE
            left: 0,
            right: 0,
            child: Transform.rotate(
              angle: 0.0, // tilt correctly
              child: Container(height: 50, color: CustomColors.orange),
            ),
          ),

          Positioned(
            top: -20,
            left: -0,
            right: 0,
            child: Transform.rotate(
              angle: -0.05, // adjust tilt here 🔥
              child: Container(
                color: background,
                height: preferredSize.height + 20,
              ),
            ),
          ),

          // APPBAR (inside blue)
          Positioned(
            top: 5,
            left: 0,
            right: 0,
            child: SizedBox(
              height: preferredSize.height,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  Constants.screenWidthPadding,
                  40,
                  Constants.screenWidthPadding,
                  0,
                ),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 70);
}
