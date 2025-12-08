import 'package:flutter/foundation.dart';
import 'package:iism_2025/services/api_service.dart';

late final AuthStatus auth;

class AuthStatus extends ChangeNotifier {
  bool _loggedIn = false;
  bool get isLoggedIn => _loggedIn;

  Future<void> checkLoginState() async {
    final res = await dio.get("/api/me");
    _loggedIn = res.statusCode == 200;
    notifyListeners();
  }

  void on401Error() {
    _loggedIn = false;
    notifyListeners();
  }
}
