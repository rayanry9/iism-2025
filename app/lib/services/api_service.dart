import 'dart:developer';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:iism_2025/models/athletic_match.dart';
import 'package:iism_2025/models/institute.dart';
import 'package:iism_2025/models/leaderboard.dart';
import 'package:iism_2025/models/pool_match.dart';
import 'package:iism_2025/models/sport.dart';
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
    var res = await dio.get(
      "/api/get-players?sport_id=$sportId&institute=$institute",
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
      log("Failed to fetch my data", name: "Api Service");
    }
    return null;
  }

  Future<List<GetAllSportsResponse>?> getAllSports() async {
    try {
      final res = (await dio.get('/api/get-all-sports')).data;

      return (res as List).map((elem) {
        return GetAllSportsResponse.fromJson(elem);
      }).toList();
    } catch (e) {
      log("Failed to fetch all sports", name: "Api Service");
    }
    return null;
  }

  Future<List<GetAllInstitutesResponse>?> getAllInstitutes() async {
    try {
      final res = (await dio.get('/api/get-all-institutes')).data;

      return (res as List).map((elem) {
        return GetAllInstitutesResponse.fromJson(elem);
      }).toList();
    } catch (e) {
      log("Failed to fetch all institutes", name: "Api Service");
    }
    return null;
  }

  Future<List<GetAllPoolMatchesResponse>?> getAllPoolMatches() async {
    try {
      final res = (await dio.get('/api/get-all-pool-matches')).data;
      return (res as List).map((elem) {
        return GetAllPoolMatchesResponse.fromJson(elem);
      }).toList();
    } catch (e) {
      log("Failed to fetch all pool matches", name: "Api Service");
    }
    return null;
  }

  Future<List<GetAllAthleticMatchesResponse>?> getAllAthleticMatches() async {
    try {
      final res = (await dio.get('/api/get-all-athletic-matches')).data;
      return (res as List).map((elem) {
        return GetAllAthleticMatchesResponse.fromJson(elem);
      }).toList();
    } catch (e) {
      log("Failed to fetch all athletic matches", name: "Api Service");
    }
    return null;
  }

  Future<List<GetLeaderboardDataResponse>?> getLeaderboardData() async {
    try {
      final res = (await dio.get('/api/get-leaderboard')).data;
      return (res as List).map((elem) {
        return GetLeaderboardDataResponse.fromJson(elem);
      }).toList();
    } catch (e) {
      log("Failed to fetch all athletic matches $e", name: "Api Service");
    }
    return null;
  }
}
