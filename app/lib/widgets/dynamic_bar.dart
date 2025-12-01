import 'package:flutter/material.dart';

class DynamicNavbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? left;
  final Widget? center;
  final Widget? right;
  final Color background;

  const DynamicNavbar({
    this.left,
    this.center,
    this.right,
    this.background = const Color(0xff191C2A),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: preferredSize.height - 70, // 🔥 Make navbar area taller
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          
          
          Positioned(
            top: kToolbarHeight + 25, // aligned with above
            left: 100,
            right: -40,
            child: Transform.rotate(
              angle: 0.07,
              child: Container(
                height: 15,
                color: const Color(0xFFFFD265),
              ),
            ),
          ),
          Positioned(
            top: kToolbarHeight + 13, // 🔥 push BELOW BLUE
            left: -40,
            right: -40,
            child: Transform.rotate(
              angle: 0.0, // tilt correctly
              child: Container(
                height: 20,
                color: const Color(0xFFFF9F1C),
              ),
            ),
          ),

          Positioned.fill(
            top: -80,
            left:-10,
            child: Transform.rotate(
              angle: -0.05, // adjust tilt here 🔥
              child: Container(
                color: background,
              ),
            ),
          ),

          // APPBAR (inside blue)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: SizedBox(
                height: kToolbarHeight,
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  automaticallyImplyLeading: false,
                  titleSpacing: 0,
                  title: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        left ?? const SizedBox(width: 0),
                        Expanded(child: center ?? const SizedBox()),
                        right ?? const SizedBox(width: 0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 100);
}
