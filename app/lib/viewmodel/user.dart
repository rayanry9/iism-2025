import 'package:flutter/material.dart';
import 'package:iism_2025/models/user.dart';
import 'package:iism_2025/services/api_service.dart';

class UserViewModel extends ChangeNotifier {
  final ApiService _apiService;
  bool isLoggedIn;
  Me? me;
  UserViewModel._({required ApiService apiService})
    : _apiService = apiService,
      isLoggedIn = false;
  static Future<UserViewModel> init(ApiService apiService) async {
    final instance = UserViewModel._(apiService: apiService);
    await instance.refetchData();
    print(instance.me);
    return instance;
  }

  Future<void> refetchData() async {
    var me = await _apiService.getMyData();
    if (me == null) {
      isLoggedIn = false;
    } else {
      isLoggedIn = true;
      this.me = me;
      notifyListeners();
    }
  }
}
