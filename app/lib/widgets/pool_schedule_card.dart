import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/constants/iit.dart';
import 'package:iism_2025/constants/sport.dart';
import 'package:iism_2025/models/institute.dart';
import 'package:iism_2025/models/pool_match.dart';
import 'package:url_launcher/url_launcher.dart';

class PoolScheduleCard extends StatelessWidget {
  final GetAllPoolMatchesResponse data;
  final List<GetAllInstitutesResponse> institutes;
  const PoolScheduleCard({
    super.key,
    required this.data,
    required this.institutes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: BoxBorder.all(color: CustomColors.gray),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: Constants.screenWidthPadding,
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: CustomColors.lightGray,
              border: BoxBorder.fromLTRB(
                bottom: BorderSide(color: CustomColors.gray),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                Image.asset(
                  getSportImageSrc(getSportFromSportId(data.sportId)!)!,
                  height: 28,
                ),
                Center(
                  child: Text(
                    '${getSportFromSportId(data.sportId)!.displayName.toUpperCase()} - ${data.matchName?.toUpperCase()}',
                    style: TextStyle(
                      height: 1.5,
                      fontSize: Constants.buttonTextSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: isSportIdFemale(data.sportId)
                        ? Icon(Icons.female, size: 24, color: CustomColors.pink)
                        : Icon(
                            Icons.male,
                            size: 24,
                            color: CustomColors.lightBlue,
                          ),
                  ),
                ),
              ],
            ),
          ),

          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Constants.screenWidthPadding,
                    vertical: 8,
                  ),
                  child: Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 12,
                        children: [
                          data.team1Id != null
                              ? Image.asset(
                                  getIITImgSrcFromName(
                                    institutes
                                        .firstWhere(
                                          (elem) => elem.id == data.team1Id,
                                        )
                                        .name,
                                  ),
                                  width: 24,
                                )
                              : SizedBox.shrink(),
                          data.team1Id != null
                              ? Text(
                                  'IIT ${institutes.firstWhere((elem) => elem.id == data.team1Id).name}',

                                  style: TextStyle(
                                    height: 1.4,
                                    fontSize: Constants.buttonTextSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : Text(
                                  data.team1TempName,
                                  style: TextStyle(
                                    height: 1.4,
                                    fontSize: Constants.buttonTextSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ],
                      ),
                      Row(
                        spacing: 12,
                        children: [
                          data.team2Id != null
                              ? Image.asset(
                                  getIITImgSrcFromName(
                                    institutes
                                        .firstWhere(
                                          (elem) => elem.id == data.team2Id,
                                        )
                                        .name,
                                  ),
                                  width: 24,
                                )
                              : SizedBox.shrink(),
                          data.team2Id != null
                              ? Text(
                                  'IIT ${institutes.firstWhere((elem) => elem.id == data.team2Id).name}',

                                  style: TextStyle(
                                    height: 1.4,
                                    fontSize: Constants.buttonTextSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              : Text(
                                  data.team2TempName,
                                  style: TextStyle(
                                    height: 1.4,
                                    fontSize: Constants.buttonTextSize,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: BoxBorder.fromLTRB(
                    left: BorderSide(color: CustomColors.gray),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: Constants.screenWidthPadding,
                ),
                child: Column(
                  children: [
                    Text(
                      "STATUS - ",
                      style: TextStyle(
                        fontSize: Constants.buttonTextSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (data.liveStreamLink != null) {
                          launchUrl(Uri.parse(data.liveStreamLink!));
                        }
                      },
                      child: Text(
                        data.status == MatchStatus.pending
                            ? "PENDING"
                            : data.status == MatchStatus.ongoing &&
                                  data.liveStreamLink != null
                            ? "LIVE"
                            : data.status == MatchStatus.ongoing &&
                                  data.liveStreamLink == null
                            ? "ONGOING"
                            : data.status == MatchStatus.concluded
                            ? "DONE"
                            : "",
                        style: TextStyle(
                          fontSize: Constants.buttonTextSize,
                          decoration:
                              data.status == MatchStatus.ongoing &&
                                  data.liveStreamLink != null
                              ? TextDecoration.underline
                              : null,
                          fontWeight: FontWeight.w600,
                          color: data.status == MatchStatus.pending
                              ? CustomColors.yellow
                              : data.status == MatchStatus.ongoing
                              ? CustomColors.orange
                              : data.status == MatchStatus.concluded
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
