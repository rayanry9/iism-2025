import 'package:flutter/material.dart';
import 'package:iism_2025/constants/colors.dart';
import 'package:iism_2025/constants/constants.dart';
import 'package:iism_2025/constants/sport.dart';
import 'package:iism_2025/viewmodel/common_data_view_model.dart';
import 'package:iism_2025/viewmodel/user.dart';
import 'package:iism_2025/widgets/athletic_schedule_card.dart';
import 'package:iism_2025/widgets/day_selector.dart';
import 'package:iism_2025/widgets/pool_schedule_card.dart';
import 'package:iism_2025/widgets/sport_selector.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});
  @override
  State<StatefulWidget> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late DateTime _selectedDate;
  late Sports? _selectedSport;
  @override
  void initState() {
    super.initState();
    _selectedDate = context.read<UserViewModel>().me!.staff
        ? DateTime.now().isBefore(DateTime(2025, 12, 29))
              ? DateTime.now()
              : DateTime(2025, 12, 29)
        : DateTime.now().isBefore(DateTime(2025, 12, 21))
        ? DateTime.now()
        : DateTime(2025, 12, 21);
    _selectedSport = null;
  }

  @override
  Widget build(BuildContext context) {
    final commonDataVM = context.watch<CommonDataViewModel>();

    final List<DateTime> possibleTimeValues = [
      ...commonDataVM.poolMatches
          .where((elem) {
            return getSportFromSportId(elem.sportId) == _selectedSport ||
                _selectedSport == null;
          })
          .map((elem) {
            return elem.startTime;
          }),
      ...commonDataVM.athleticMatches
          .where(
            (elem) =>
                _selectedSport == null || _selectedSport == Sports.athletics,
          )
          .map((elem) {
            return elem.startTime;
          }),
    ];

    final List<DateTime> uniqueTimeValues =
        possibleTimeValues.indexed
            .where((elem) {
              return possibleTimeValues.indexWhere(
                    (d) =>
                        d.day == elem.$2.day &&
                        d.hour == elem.$2.hour &&
                        d.minute == elem.$2.minute &&
                        d.day == _selectedDate.day,
                  ) ==
                  elem.$1;
            })
            .map((elem) {
              return elem.$2;
            })
            .toList()
          ..sort((a, b) => a.compareTo(b));

    return RefreshIndicator(
      onRefresh: () async {
        await context.read<UserViewModel>().refetchData();
        if (context.mounted) {
          await context.read<CommonDataViewModel>().refetchData();
        }
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Column(
            spacing: 16,
            children: [
              SportSelector(
                selectedSport: _selectedSport,
                isStaff: context.read<UserViewModel>().me!.staff,
                firstText: "ALL MATCHES",
                onUpdate: (v) {
                  setState(() {
                    _selectedSport = v;
                  });
                },
              ),
              DaySelector(
                selectedDate: _selectedDate,
                isStaff: context.read<UserViewModel>().me!.staff,
                onUpdate: (dt) {
                  setState(() {
                    _selectedDate = dt;
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: Constants.screenWidthPadding,
                ),
                child: Column(
                  spacing: 16,
                  children: uniqueTimeValues.map((elem) {
                    return Column(
                      spacing: 8,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: CustomColors.lightBlue,
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: Constants.screenWidthPadding,
                          ),
                          child: Text(
                            DateFormat("hh:mm a").format(elem.toLocal()),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Constants.titlesTextSize,
                            ),
                          ),
                        ),
                        ...commonDataVM.poolMatches
                            .where(
                              (item) =>
                                  item.startTime.hour == elem.hour &&
                                  item.startTime.minute == elem.minute &&
                                  item.startTime.day == elem.day &&
                                  (_selectedSport == null ||
                                      getSportFromSportId(item.sportId)! ==
                                          _selectedSport),
                            )
                            .map((elem) {
                              return PoolScheduleCard(
                                data: elem,
                                institutes: commonDataVM.institutes,
                              );
                            }),
                        ...((_selectedSport == Sports.athletics ||
                                _selectedSport == null)
                            ? commonDataVM.athleticMatches
                                  .where(
                                    (item) =>
                                        item.startTime.hour == elem.hour &&
                                        item.startTime.minute == elem.minute &&
                                        item.startTime.day == elem.day,
                                  )
                                  .map((elem) {
                                    return AthleticScheduleCard(
                                      data: elem,
                                      institutes: commonDataVM.institutes,
                                      sports: commonDataVM.sports,
                                    );
                                  })
                            : []),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
