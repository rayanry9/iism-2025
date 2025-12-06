import 'package:flutter/material.dart';

class GlobalFAB extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color background;

  const GlobalFAB({
    super.key,
    this.onPressed,
    this.icon = Icons.add,
    this.background = Colors.orange,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: background,
      child: Icon(icon),
    );
  }
}
