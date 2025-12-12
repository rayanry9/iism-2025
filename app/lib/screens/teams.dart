import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/constants/iit.dart';
import 'package:iism_2025/constants/sport.dart';
import 'package:iism_2025/viewmodel/teams_view_model.dart';
import 'package:iism_2025/viewmodel/user.dart';
import 'package:provider/provider.dart';

class TeamsScreen extends StatelessWidget {
  final UserViewModel _userViewModel;
  const TeamsScreen({super.key, required UserViewModel user})
    : _userViewModel = user;

  @override
  Widget build(BuildContext context) {
    return Consumer<TeamsViewModel>(
      builder: (context, teams, _) {
        if (teams.institute == null) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo-no-text.png",
                  color: CustomColors.gray,
                  colorBlendMode: BlendMode.srcIn,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    "Select a College",
                    style: TextStyle(fontSize: Constants.heading2TextSize),
                  ),
                ),
              ],
            ),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              spacing: 12,
              children: [
                Image.asset(
                  getIITImgSrcFromName(teams.institute!),
                  height: 120,
                ),
                Column(children: [Text('IIT ${teams.institute}')]),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 8,
                    horizontal: Constants.screenWidthPadding,
                  ),
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 16,
                    children: getSportsAll(_userViewModel.me!.staff).map((val) {
                      return Transform(
                        alignment: AlignmentGeometry.center,
                        transform: Matrix4.skewX(-Constants.skewXValue),
                        child: ElevatedButton(
                          onPressed: () {
                            teams.updateSport(val);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: teams.sport == val
                                ? CustomColors.blue
                                : Colors.white,
                            elevation: teams.sport == val ? 2 : 0,
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
                            child: Image.asset(
                              getSportImageSrc(val)!,
                              height: 30,
                            ),
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
                  child: Row(
                    spacing: 8,
                    children: [
                      Image.asset(getSportImageSrc(teams.sport)!, height: 60),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              teams.sport.displayName.toUpperCase(),
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
                        initialValue: teams.gender,
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
                        onValueChanged: (v) {
                          teams.updateGender(v);
                        },
                      ),
                    ],
                  ),
                ),

                teams.playersData != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Constants.screenWidthPadding,
                        ),
                        child: GridView(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 6,
                                mainAxisSpacing: 12,
                                childAspectRatio:
                                    teams.sport == Sports.athletics ? 0.5 : 0.6,
                              ),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: teams.playersData!.map((item) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Image.network(
                                  "${dotenv.env["API_URL"]}/api/profile-pic/${(item.profilePic ?? '')}.webp",
                                ),
                                SizedBox(height: 4),
                                Text(
                                  item.firstName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Constants.titlesTextSize,
                                  ),
                                ),
                                Text(
                                  item.extra ?? '',
                                  style: TextStyle(
                                    fontSize: Constants.buttonTextSize,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          );
        }
      },
    );
  }
}
