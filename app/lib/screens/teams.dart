import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/constants/iit.dart';
import 'package:iism_2025/constants/sport.dart';
import 'package:iism_2025/models/user.dart';
import 'package:iism_2025/services/user_cache.dart';
import 'package:iism_2025/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  Sports _selectedSport = Sports.athletics;
  Gender _selectedGender = Gender.men;
  List<GetPlayersData>? _playersData;

  @override
  Widget build(BuildContext context) {
    final teamState = context.watch<TeamPageState>();
    if (teamState.selectedCollege == null) {
      return Text("Select a College");
    } else {
      return Column(
        spacing: 12,
        children: [
          Image.asset(
            getIITImgSrcFromName(teamState.selectedCollege!),
            height: 120,
          ),
          Column(children: [Text('IIT ${teamState.selectedCollege}')]),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              vertical: 8,
              horizontal: Constants.screenWidthPadding,
            ),
            child: Wrap(
              spacing: 12,
              runSpacing: 16,
              children: getSportsAll(UserCache().staff!).map((val) {
                return Transform(
                  alignment: AlignmentGeometry.center,
                  transform: Matrix4.skewX(-Constants.skewXValue),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _selectedSport = val;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedSport == val
                          ? CustomColors.blue
                          : Colors.white,
                      elevation: _selectedSport == val ? 2 : 0,
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(color: CustomColors.blue),
                      ),
                    ),
                    child: Transform(
                      transform: Matrix4.skewX(Constants.skewXValue),
                      alignment: AlignmentGeometry.center,
                      child: Image.asset(getSportImageSrc(val)!, height: 30),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Divider(thickness: 1, color: CustomColors.lightGray),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.screenWidthPadding,
            ),
            child: _selectedSport != null
                ? Row(
                    spacing: 8,
                    children: [
                      Image.asset(
                        getSportImageSrc(_selectedSport!)!,
                        height: 60,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _selectedSport!.displayName.toUpperCase(),
                              style: TextStyle(
                                fontSize: Constants.titlesTextSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Team Players",
                              style: TextStyle(
                                color: CustomColors.teal,
                                fontSize: Constants.buttonTextSize,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomSlidingSegmentedControl<Gender>(
                        initialValue: Gender.men,
                        innerPadding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: BoxBorder.all(
                            color: CustomColors.gray,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        thumbDecoration: BoxDecoration(
                          color: CustomColors.blue,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        children: {
                          Gender.men: Icon(
                            Icons.male,
                            color: CustomColors.lightBlue,
                          ),
                          Gender.women: Icon(
                            Icons.female,
                            color: CustomColors.pink,
                          ),
                        },
                        onValueChanged: (v) {},
                      ),
                    ],
                  )
                : SizedBox(),
          ),
        ],
      );
    }
  }
}
