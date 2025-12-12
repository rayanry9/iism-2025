import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/viewmodel/user.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<UserViewModel>();
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: Constants.screenWidthPadding,
      ),
      child: Column(
        children: [
          Material(
            elevation: 3,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias, // ensures ripple is clipped to radius
            child: InkWell(
              onTap: () {
                context.push("/campus-map");
              }, // your onPressed action
              child: Ink(
                height: 145,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/campus_map_hero.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CAMPUS MAP",
                        style: TextStyle(
                          fontSize: Constants.heading2TextSize,
                          fontWeight: FontWeight.w600,
                          color: CustomColors.darkTeal,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Find match venues and\nlocations easily.",
                        style: TextStyle(
                          color: CustomColors.darkTeal,
                          fontSize: Constants.buttonTextSize,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
