import 'package:flutter/widgets.dart';
import 'package:iism_2025/constants/sport.dart';
import 'package:iism_2025/models/user.dart';
import 'package:iism_2025/services/api_service.dart';
import 'package:iism_2025/viewmodel/user.dart';

class TeamsViewModel extends ChangeNotifier {
  String? _institute;
  Sports _sport;
  Gender _gender;
  List<GetPlayersData>? _playerData;

  final ApiService _apiService;
  final UserViewModel _userViewModel;

  TeamsViewModel({required ApiService api, required UserViewModel user})
    : _sport = Sports.athletics,
      _gender = Gender.men,
      _playerData = null,
      _apiService = api,
      _userViewModel = user;

  Gender get gender => _gender;
  Sports get sport => _sport;
  List<GetPlayersData>? get playersData => _playerData;
  String? get institute => _institute;

  void updateGender(Gender gender) {
    _gender = gender;
    notifyListeners();
    updatePlayerData();
  }

  void updateSport(Sports sport) {
    _sport = sport;
    _gender = Gender.men;
    notifyListeners();
    updatePlayerData();
  }

  void updateInstitute(String institute) {
    _institute = institute;
    notifyListeners();
    updatePlayerData();
  }

  void updatePlayerData() async {
    if (institute != null) {
      _playerData = await _apiService.getPlayersData(
        getSportIdFromSport(
          sport,
          gender == Gender.men ? 1 : 2,
          _userViewModel.me!.staff,
        ),
        _institute!,
      );
      notifyListeners();
    }
  }
}
