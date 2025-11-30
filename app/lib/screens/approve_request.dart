import 'package:flutter/material.dart';

class ApproveRequestScreen extends StatelessWidget {
  const ApproveRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        "OUTING APPROVAL PAGE\n(For role 6 - Managers/Admins)",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
