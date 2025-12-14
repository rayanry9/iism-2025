import 'package:flutter/widgets.dart';
import 'package:iism_2025/models/athletic_match.dart';
import 'package:iism_2025/models/institute.dart';
import 'package:iism_2025/models/pool_match.dart';
import 'package:iism_2025/models/sport.dart';
import 'package:iism_2025/services/api_service.dart';

class CommonDataViewModel extends ChangeNotifier {
  late List<GetAllSportsResponse> _sportData;
  late List<GetAllInstitutesResponse> _institutesData;
  late List<GetAllPoolMatchesResponse> _poolMatchesData;
  late List<GetAllAthleticMatchesResponse> _athleticMatchesData;
  final ApiService _apiService;

  static CommonDataViewModel base(ApiService api) {
    final vm = CommonDataViewModel._(api: api);
    vm._sportData = [];
    vm._athleticMatchesData = [];
    vm._institutesData = [];
    vm._poolMatchesData = [];
    return vm;
  }

  static Future<CommonDataViewModel> init(ApiService api) async {
    final vm = CommonDataViewModel._(api: api);
    vm._sportData = (await api.getAllSports()) ?? [];
    vm._institutesData = (await api.getAllInstitutes()) ?? [];
    vm._poolMatchesData = (await api.getAllPoolMatches()) ?? [];
    vm._athleticMatchesData = (await api.getAllAthleticMatches()) ?? [];
    return vm;
  }

  List<GetAllSportsResponse> get sports => _sportData;
  List<GetAllInstitutesResponse> get institutes => _institutesData;
  List<GetAllPoolMatchesResponse> get poolMatches => _poolMatchesData;
  List<GetAllAthleticMatchesResponse> get athleticMatches =>
      _athleticMatchesData;

  CommonDataViewModel._({required ApiService api}) : _apiService = api;

  Future<void> refetchData() async {
    _poolMatchesData = (await _apiService.getAllPoolMatches()) ?? [];
    _athleticMatchesData = (await _apiService.getAllAthleticMatches()) ?? [];
    notifyListeners();
  }
}
