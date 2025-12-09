import 'package:flutter/material.dart';
import 'package:iism_2025/constants/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: Constants.screenWidthPadding,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 145,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              image: DecorationImage(
                image: AssetImage("assets/campus_map_hero.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Text("CAMPUS MAP"),
                  Text("Find match venues and\nlocations easily."),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
