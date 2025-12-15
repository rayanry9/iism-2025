import 'package:flutter/widgets.dart';
import 'package:iism_2025/models/athletic_match.dart';
import 'package:iism_2025/models/institute.dart';
import 'package:iism_2025/models/leaderboard.dart';
import 'package:iism_2025/models/pool_match.dart';
import 'package:iism_2025/models/sport.dart';
import 'package:iism_2025/services/api_service.dart';

class CommonDataViewModel extends ChangeNotifier {
  late List<GetAllSportsResponse> _sportData;
  late List<GetAllInstitutesResponse> _institutesData;
  late List<GetAllPoolMatchesResponse> _poolMatchesData;
  late List<GetAllAthleticMatchesResponse> _athleticMatchesData;
  late List<GetLeaderboardDataResponse> _leaderboardData;
  final ApiService _apiService;

  CommonDataViewModel({required ApiService api})
    : _apiService = api,
      _sportData = [],
      _athleticMatchesData = [],
      _institutesData = [],
      _poolMatchesData = [],
      _leaderboardData = [];

  Future<void> init() async {
    _sportData = (await _apiService.getAllSports()) ?? [];
    _institutesData = (await _apiService.getAllInstitutes()) ?? [];
    _poolMatchesData = (await _apiService.getAllPoolMatches()) ?? [];
    _athleticMatchesData = (await _apiService.getAllAthleticMatches()) ?? [];
    _leaderboardData = (await _apiService.getLeaderboardData()) ?? [];
    notifyListeners();
  }

  List<GetAllSportsResponse> get sports => _sportData;
  List<GetAllInstitutesResponse> get institutes => _institutesData;
  List<GetAllPoolMatchesResponse> get poolMatches => _poolMatchesData;
  List<GetAllAthleticMatchesResponse> get athleticMatches =>
      _athleticMatchesData;
  List<GetLeaderboardDataResponse> get leaderboard => _leaderboardData;

  Future<void> refetchData() async {
    _poolMatchesData = (await _apiService.getAllPoolMatches()) ?? [];
    _athleticMatchesData = (await _apiService.getAllAthleticMatches()) ?? [];
    notifyListeners();
    _leaderboardData = (await _apiService.getLeaderboardData()) ?? [];
  }
}
