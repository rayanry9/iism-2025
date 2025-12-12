import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iism_2025/models/user.dart';
import 'package:path_provider/path_provider.dart';

class ApiService {
  late final Dio dio;

  late final PersistCookieJar _cookieJar;
  ApiService._();
  static Future<ApiService> init() async {
    var service = ApiService._();

    service.dio = Dio(
      BaseOptions(
        baseUrl: dotenv.get(
          "API_URL",
          fallback: "https://iism25.sports.iith.ac.in",
        ),
      ),
    );

    final cachePath = (await getApplicationCacheDirectory()).path;
    service._cookieJar = PersistCookieJar(storage: FileStorage(cachePath));

    service.dio.interceptors.add(CookieManager(service._cookieJar));

    return service;
  }

  Future<List<GetPlayersData>?> getPlayersData(
    int sportId,
    String institute,
  ) async {
    final res = await dio.get(
      "/api/get-players?sportId=$sportId&institute=$institute",
    );
    if (res.statusCode != 200) {
      return null;
    }
    return (res.data as List)
        .map((val) => GetPlayersData.fromJson(val))
        .toList();
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await dio.post(
        "/api/login",
        data: {"email": email, "password": password},
      );
      return response.statusCode == 200;
    } on DioException catch (_) {
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<Me?> getMyData() async {
    try {
      final response = await dio.get('/api/me');

      var instance = Me.fromJson(response.data);

      if (dotenv.env['DEBUG'] == 'TRUE') {
        instance.sports = [
          {"sportId": 6, "name": "Tennis", "staff": false, "type": 1},
        ];
        instance.assignedId = '1';
        instance.role = 6; // Forces the outing card to appear
      }
      return instance;
    } catch (e) {
      print("User API error: $e");
    }
    return null;
  }
}
