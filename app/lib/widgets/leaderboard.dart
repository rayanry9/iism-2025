import 'package:flutter/cupertino.dart';
import 'package:iism_2025/models/institute.dart';
import 'package:iism_2025/models/leaderboard.dart';

class Leaderboard extends StatelessWidget {
  final List<GetLeaderboardDataResponse> _leaderboard;
  final List<GetAllInstitutesResponse> _institutes;
  const Leaderboard({
    super.key,
    required List<GetLeaderboardDataResponse> leaderboard,
    required List<GetAllInstitutesResponse> institutes,
  }) : _leaderboard = leaderboard,
       _institutes = institutes;

  @override
  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }
}
