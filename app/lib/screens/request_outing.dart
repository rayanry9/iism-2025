import 'package:flutter/material.dart';

class RequestOutingScreen extends StatelessWidget {
  const RequestOutingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        "REQUEST OUTING PAGE\n(For role 2 - Students)",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
