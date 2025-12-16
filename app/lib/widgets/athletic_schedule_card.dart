import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/constants/iit.dart';
import 'package:iism_2025/constants/sport.dart';
import 'package:iism_2025/models/athletic_match.dart';
import 'package:iism_2025/models/institute.dart';
import 'package:iism_2025/models/pool_match.dart';
import 'package:iism_2025/models/sport.dart';
import 'package:url_launcher/url_launcher.dart';

class AthleticScheduleCard extends StatelessWidget {
  final GetAllAthleticMatchesResponse data;
  final List<GetAllInstitutesResponse> institutes;
  final List<GetAllSportsResponse> sports;
  const AthleticScheduleCard({
    super.key,
    required this.data,
    required this.institutes,
    required this.sports,
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
              spacing: 8,
              children: [
                Image.asset(getSportImageSrc(Sports.athletics)!, height: 28),
                Center(
                  child: Text(
                    'ATHLETICS - ${sports.firstWhere((s) => s.id == data.sportId).name.toUpperCase()}',
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 4,
                      children: [
                        isSportIdFemale(data.sportId)
                            ? Icon(
                                Icons.female,
                                size: 24,
                                color: CustomColors.pink,
                              )
                            : Icon(
                                Icons.male,
                                size: 24,
                                color: CustomColors.lightBlue,
                              ),
                        isSportIdMixed(data.sportId)
                            ? Icon(
                                Icons.female,
                                size: 24,
                                color: CustomColors.pink,
                              )
                            : SizedBox.shrink(),
                      ],
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
                  decoration: BoxDecoration(
                    border: BoxBorder.fromLTRB(
                      right: BorderSide(color: CustomColors.gray),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: Constants.screenWidthPadding,
                    vertical: 8,
                  ),
                  child: Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      data.participants.isEmpty
                          ? Text(
                              data.participantsTempText,
                              style: TextStyle(
                                fontSize: Constants.buttonTextSize,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : Text(
                              "(${data.participants.length == 23 ? ' All' : ''} ${data.participants.length} IITS)",
                              style: TextStyle(
                                fontSize: Constants.buttonTextSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                      data.participants.isEmpty
                          ? SizedBox.shrink()
                          : Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              alignment: WrapAlignment.center,
                              runAlignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: data.participants.map((parti) {
                                return Image.asset(
                                  getIITImgSrcFromName(
                                    institutes
                                        .firstWhere((i) => i.id == parti)
                                        .name,
                                  ),
                                  height: 20,
                                );
                              }).toList(),
                            ),
                    ],
                  ),
                ),
              ),
              Container(
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
                          decoration: data.status == MatchStatus.ongoing
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
