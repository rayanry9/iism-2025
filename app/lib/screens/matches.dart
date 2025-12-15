import 'package:flutter/material.dart';
import 'package:iism_2025/constants/sport.dart';
import 'package:iism_2025/viewmodel/common_data_view_model.dart';
import 'package:iism_2025/viewmodel/matches_view_model.dart';
import 'package:iism_2025/viewmodel/user.dart';
import 'package:iism_2025/widgets/sport_selector.dart';
import 'package:provider/provider.dart';

class MatchesScreen extends StatelessWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userVM = context.watch<UserViewModel>();
    final commonDataVM = context.watch<CommonDataViewModel>();
    final matchesVM = context.watch<MatchesViewModel>();

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
                firstText: matchesVM.isLiveMatchScreen
                    ? "All Matches"
                    : "Leaderboard",
                selectedSport: matchesVM.selectedSport,
                onUpdate: (v) {
                  matchesVM.updateSelectedSport(v);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
