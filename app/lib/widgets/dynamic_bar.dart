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
    return AppBar(
      backgroundColor: background,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.all(16),
        child:Row(
        children: [
          left ?? SizedBox(width: 0),
          Expanded(child: center ?? SizedBox()),
          right ?? SizedBox(width: 0),
        ],
      ),
      )
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
