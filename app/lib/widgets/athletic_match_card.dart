import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/constants/iit.dart';
import 'package:iism_2025/models/athletic_match.dart';
import 'package:iism_2025/viewmodel/common_data_view_model.dart';
import 'package:iism_2025/widgets/sport_card_full.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AthleticMatchCard extends StatelessWidget {
  final CommonDataViewModel _commonDataViewModel;
  final GetAllAthleticMatchesResponse _elem;

  const AthleticMatchCard({
    super.key,
    required GetAllAthleticMatchesResponse am,
    required CommonDataViewModel cm,
  }) : _commonDataViewModel = cm,
       _elem = am;

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 8,
                children: [
                  Text(
                    _commonDataViewModel.sports
                        .firstWhere((i) => i.id == _elem.sportId)
                        .name
                        .toUpperCase(),
                    style: TextStyle(
                      color: CustomColors.blue,
                      fontSize: Constants.buttonTextSize,
                    ),
                  ),
                  _elem.participants.isEmpty
                      ? Text(
                          _elem.participantsTempText,
                          style: TextStyle(fontSize: Constants.titlesTextSize),
                        )
                      : Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.center,
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: _elem.participants.map((parti) {
                            return Image.asset(
                              getIITImgSrcFromName(
                                _commonDataViewModel.institutes
                                    .firstWhere((i) => i.id == parti)
                                    .name,
                              ),
                              height: 24,
                            );
                          }).toList(),
                        ),
                ],
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
                  backgroundColor: CustomColors.orange,
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
