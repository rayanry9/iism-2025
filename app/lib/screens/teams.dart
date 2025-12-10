import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/constants/iit.dart';
import 'package:iism_2025/constants/sport.dart';
import 'package:iism_2025/services/user_cache.dart';
import 'package:iism_2025/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  Sports? selectedSport = Sports.athletics;
  List<bool> gender = [true, false];

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
                        selectedSport = val;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedSport == val
                          ? CustomColors.blue
                          : Colors.white,
                      elevation: selectedSport == val ? 2 : 0,
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
          selectedSport != null
              ? Row(
                  children: [
                    Image.asset(getSportImageSrc(selectedSport!)!, width: 60),
                    Expanded(
                      child: Column(
                        children: [
                          Text(selectedSport!.displayName.toUpperCase()),
                          Text("Text Players"),
                        ],
                      ),
                    ),
                    SegmentedButton(
                      segments: [
                        ButtonSegment(
                          value: "Men",
                          label: Text("Men"),
                          enabled: true,
                        ),
                        ButtonSegment(
                          value: "Men",
                          label: Text("Men"),
                          enabled: false,
                        ),
                      ],
                      selected: {"Set"},
                    ),
                  ],
                )
              : SizedBox(),
        ],
      );
    }
  }
}
