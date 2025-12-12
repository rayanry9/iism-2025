import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:iism_2025/services/api_service.dart';

class AuthStatus extends ChangeNotifier {
  final ApiService _apiService;
  bool _loggedIn = false;
  bool get isLoggedIn => _loggedIn;

  AuthStatus._(this._apiService) {
    _apiService.dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            on401Error();
            return handler.resolve(
              Response(requestOptions: e.requestOptions, statusCode: 401),
            );
          }
          return handler.next(e);
        },
      ),
    );
  }

  static Future<AuthStatus> init({required ApiService apiService}) async {
    AuthStatus instance = AuthStatus._(apiService);
    await instance.checkLoginState();
    return instance;
  }

  Future<void> checkLoginState() async {
    final res = await _apiService.dio.get("/api/me");
    _loggedIn = res.statusCode == 200;
    notifyListeners();
  }

  void on401Error() {
    _loggedIn = false;
    notifyListeners();
  }
}
