import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';

class DaySelector extends StatelessWidget {
  final bool _isStaff;
  final DateTime _selectedDate;

  final Function(DateTime dt) onUpdate;
  const DaySelector({
    super.key,
    required bool isStaff,
    required this.onUpdate,
    required DateTime selectedDate,
  }) : _isStaff = isStaff,
       _selectedDate = selectedDate;

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
            "Select a Day",
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
                              DateTime(2025, 12, 23),
                              DateTime(2025, 12, 24),
                              DateTime(2025, 12, 25),
                              DateTime(2025, 12, 26),
                              DateTime(2025, 12, 27),
                              DateTime(2025, 12, 28),
                              DateTime(2025, 12, 29),
                            ]
                          : [
                              DateTime(2025, 12, 13),
                              DateTime(2025, 12, 14),
                              DateTime(2025, 12, 15),
                              DateTime(2025, 12, 16),
                              DateTime(2025, 12, 17),
                              DateTime(2025, 12, 18),
                              DateTime(2025, 12, 19),
                              DateTime(2025, 12, 20),
                              DateTime(2025, 12, 21),
                            ])
                      .indexed
                      .map((elem) {
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.skewX(-Constants.skewXValue),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _selectedDate == elem.$2
                                  ? CustomColors.teal
                                  : Colors.white,
                              foregroundColor: _selectedDate == elem.$2
                                  ? Colors.white
                                  : Colors.black,
                              padding: EdgeInsetsGeometry.symmetric(
                                horizontal: 24,
                                vertical: 6,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: BorderSide(
                                  color: _selectedDate == elem.$2
                                      ? Colors.transparent
                                      : CustomColors.lightGray,
                                ),
                              ),
                            ),
                            onPressed: () {
                              onUpdate(elem.$2);
                            },
                            child: Transform(
                              transform: Matrix4.skewX(Constants.skewXValue),
                              alignment: Alignment.center,
                              child: Text(
                                "DAY ${elem.$1} - ${elem.$2.day}/${elem.$2.month}/${elem.$2.year}",
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
