import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/constants/iit.dart';
import 'package:iism_2025/constants/sport.dart';
import 'package:iism_2025/models/pool_match.dart';
import 'package:iism_2025/viewmodel/common_data_view_model.dart';
import 'package:iism_2025/widgets/sport_card_full.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class PoolMatchCard extends StatelessWidget {
  final CommonDataViewModel _commonDataViewModel;
  final GetAllPoolMatchesResponse _elem;

  const PoolMatchCard({
    super.key,
    required GetAllPoolMatchesResponse pm,
    required CommonDataViewModel cm,
  }) : _commonDataViewModel = cm,
       _elem = pm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SportCardFull(
          sportId: _elem.sportId,
          role: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Started at",
                style: TextStyle(
                  color: CustomColors.orange,
                  fontSize: Constants.buttonTextSize,
                ),
              ),
              Text(
                DateFormat(
                  "hh:mm a",
                ).format(_elem.startTime.toLocal()).toUpperCase(),
                style: TextStyle(
                  fontSize: Constants.heading2TextSize,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: CustomColors.gray),
                ),
                child: Text(
                  _elem.venue ?? '',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: Constants.buttonTextSize,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),

        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: Constants.screenWidthPadding,
                vertical: 28,
              ),
              decoration: BoxDecoration(
                border: BoxBorder.fromLTRB(
                  left: BorderSide(color: CustomColors.gray),
                  bottom: BorderSide(color: CustomColors.gray),
                  right: BorderSide(color: CustomColors.gray),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset(
                          getIITImgSrcFromName(
                            _commonDataViewModel.institutes
                                .firstWhere((i) => i.id == _elem.team1Id)
                                .name,
                          ),
                          height: 48,
                        ),

                        Text(
                          'IIT ${getIITShortCode(_commonDataViewModel.institutes.firstWhere((i) => i.id == _elem.team1Id).name)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Constants.buttonTextSize,
                          ),
                        ),
                      ],
                    ),
                  ),

                  getSportFromSportId(_elem.sportId) == Sports.cricket
                      ? Row(
                          spacing: 12,
                          children: [
                            Transform(
                              transform: Matrix4.skewX(-Constants.skewXValue),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 24, 0),
                                decoration: BoxDecoration(
                                  border: BoxBorder.fromLTRB(
                                    right: BorderSide(color: CustomColors.gray),
                                  ),
                                ),
                                child: Transform(
                                  transform: Matrix4.skewX(
                                    Constants.skewXValue,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${_elem.team1Score[0]}-${_elem.team1Wickets}',
                                        style: TextStyle(
                                          color: CustomColors.orange,
                                          fontSize: Constants.titlesTextSize,
                                        ),
                                      ),
                                      Text(
                                        'Over ${(_elem.team1Balls / 6).floor()}${_elem.team1Balls % 6 != 0 ? (_elem.team1Balls % 6) : ''}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Constants.buttonTextSize,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Column(
                              children: [
                                Text(
                                  '${_elem.team2Score[0]}-${_elem.team2Wickets}',
                                  style: TextStyle(
                                    color: CustomColors.orange,
                                    fontSize: Constants.titlesTextSize,
                                  ),
                                ),
                                Text(
                                  'Over ${(_elem.team2Balls / 6).floor()}${_elem.team2Balls % 6 != 0 ? (_elem.team2Balls % 6) : ''}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Constants.buttonTextSize,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : getSportFromSportId(_elem.sportId) == Sports.volleyball
                      ? Column(
                          children: List.generate(5, (idx) {
                            return Text(
                              '${_elem.team1Score[idx]} : ${_elem.team2Score[idx]}',
                              style: TextStyle(
                                color: CustomColors.orange,
                                fontSize: Constants.buttonTextSize,
                              ),
                            );
                          }),
                        )
                      : Text(
                          '${_elem.team1Score[0]} : ${_elem.team2Score[0]}',
                          style: TextStyle(
                            color: CustomColors.orange,
                            fontSize: Constants.heading1TextSize,
                          ),
                        ),

                  Expanded(
                    child: Column(
                      spacing: 4,
                      children: [
                        Image.asset(
                          getIITImgSrcFromName(
                            _commonDataViewModel.institutes
                                .firstWhere((i) => i.id == _elem.team2Id)
                                .name,
                          ),
                          height: 48,
                        ),

                        Text(
                          'IIT ${getIITShortCode(_commonDataViewModel.institutes.firstWhere((i) => i.id == _elem.team2Id).name)}',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Constants.buttonTextSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 4,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  _elem.matchName ?? '',
                  style: TextStyle(
                    color: CustomColors.blue,
                    fontSize: Constants.buttonTextSize,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -24,
              child: ElevatedButton(
                onPressed: () {
                  if (_elem.liveStreamLink != null) {
                    launchUrl(Uri.parse(_elem.liveStreamLink!));
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  backgroundColor: _elem.liveStreamLink != null
                      ? CustomColors.orange
                      : CustomColors.gray,
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4,
                  children: [
                    Icon(Icons.play_arrow, color: Colors.white),
                    Text(
                      _elem.liveStreamLink != null ? "WATCH" : "N/A",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Constants.buttonTextSize,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
