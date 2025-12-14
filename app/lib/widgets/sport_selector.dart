import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/constants/sport.dart';

class SportSelector extends StatelessWidget {
  final Sports? _selectedSport;
  final String firstText;
  final bool _isStaff;
  final Function(Sports?) onUpdate;

  const SportSelector({
    super.key,
    required this.firstText,
    required Sports? selectedSport,
    required bool isStaff,
    required this.onUpdate,
  }) : _selectedSport = selectedSport,
       _isStaff = isStaff;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Constants.screenWidthPadding,
          ),
          child: Text(
            "Select a Sport",
            style: TextStyle(
              fontSize: Constants.buttonTextSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Constants.screenWidthPadding,
            ),
            child: Row(
              spacing: 16,
              children:
                  (_isStaff
                          ? [
                              null,
                              Sports.athletics,
                              Sports.badminton,
                              Sports.basketball,
                              Sports.chess,
                              Sports.cricket,
                              Sports.football,
                              Sports.tableTennis,
                              Sports.tennis,
                              Sports.volleyball,
                              Sports.squash,
                            ]
                          : [
                              null,
                              Sports.athletics,
                              Sports.football,
                              Sports.cricket,
                              Sports.hockey,
                              Sports.volleyball,
                            ])
                      .map((elem) {
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.skewX(-Constants.skewXValue),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedSport == elem
                                  ? CustomColors.orange
                                  : Colors.white,
                              foregroundColor: _selectedSport == elem
                                  ? Colors.white
                                  : Colors.black,
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 24,
                                vertical: 6,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(
                                  color: _selectedSport == elem
                                      ? Colors.transparent
                                      : CustomColors.lightGray,
                                ),
                              ),
                            ),
                            onPressed: () {
                              onUpdate(elem);
                            },
                            child: Transform(
                              transform: Matrix4.skewX(Constants.skewXValue),
                              alignment: Alignment.center,
                              child: Text(
                                elem?.displayName ?? firstText,
                                style: TextStyle(
                                  fontSize: Constants.buttonTextSize,
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                      .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
