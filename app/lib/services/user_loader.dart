import 'package:iism_2025/services/api_service.dart';
import 'package:iism_2025/services/user_cache.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> loadUserData() async {
  if (UserCache().hasData) return;

  try {
    final response = await dio.get('/api/me');

    UserCache().fromJson(response.data);

    if (dotenv.env['DEBUG'] == 'TRUE') {
      UserCache().sports = [
        {"sportId": 6, "name": "Tennis", "staff": false, "type": 1},
      ];
      UserCache().assignedId = '1';
      UserCache().role = 2; // Forces the outing card to appear
    }
  } catch (e) {
    print("User API error: $e");
  }
}
