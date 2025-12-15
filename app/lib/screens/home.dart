import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/models/pool_match.dart';
import 'package:iism_2025/viewmodel/common_data_view_model.dart';
import 'package:iism_2025/viewmodel/user.dart';
import 'package:iism_2025/widgets/pool_match_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<UserViewModel>();
    final commonDataVM = context.watch<CommonDataViewModel>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Column(
        spacing: 24,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Constants.screenWidthPadding,
                ),
                child: Row(
                  spacing: 24,
                  children: [
                    Expanded(
                      child: Text(
                        "Ongoing Matches",
                        style: TextStyle(
                          fontSize: Constants.titlesTextSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.skewX(-Constants.skewXValue),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.orange,
                          foregroundColor: Colors.white,
                          padding: EdgeInsetsGeometry.symmetric(
                            horizontal: 24,
                            vertical: 4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () {
                          context.go("/matches");
                        },
                        child: Transform(
                          transform: Matrix4.skewX(Constants.skewXValue),
                          alignment: Alignment.center,
                          child: Text(
                            "VIEW ALL",
                            style: TextStyle(
                              fontSize: Constants.buttonTextSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ...commonDataVM.poolMatches
                            .where((elem) {
                              return elem.status == MatchStatus.ongoing;
                            })
                            .take(3)
                            .indexed
                            .map((elem) {
                              return Container(
                                padding: EdgeInsets.fromLTRB(
                                  elem.$1 == 0
                                      ? Constants.screenWidthPadding
                                      : 0,
                                  24,
                                  Constants.screenWidthPadding,
                                  32,
                                ),
                                width:
                                    constraints.maxWidth -
                                    Constants.screenWidthPadding * 2,
                                child: PoolMatchCard(
                                  pm: elem.$2,
                                  cm: commonDataVM,
                                ),
                              );
                            }),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.screenWidthPadding,
            ),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(16),
              clipBehavior:
                  Clip.antiAlias, // ensures ripple is clipped to radius
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
          ),
        ],
      ),
    );
  }
}
