import 'package:flutter/material.dart';
import 'package:iism_2025/constants/sport.dart';
import 'package:iism_2025/viewmodel/common_data_view_model.dart';
import 'package:iism_2025/viewmodel/user.dart';
import 'package:iism_2025/widgets/sport_selector.dart';
import 'package:provider/provider.dart';

class MatchesScreen extends StatefulWidget {
  const MatchesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  Sports? _selectedSport;

  @override
  void initState() {
    _selectedSport = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            children: [
              SportSelector(
                isStaff: context.read<UserViewModel>().me!.staff,
                firstText: "All Matches",
                selectedSport: _selectedSport,
                onUpdate: (v) {
                  setState(() {
                    _selectedSport = v;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
