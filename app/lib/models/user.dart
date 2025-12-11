import 'package:iism_2025/services/api_service.dart';

class GetPlayersData {
  final int userId;
  final String? profilePic;
  final String firstName;
  final String? middleName;
  final String? lastName;
  final String? extra;
  final bool isPrimary;

  GetPlayersData({
    required this.userId,
    required this.firstName,
    required this.isPrimary,
    this.profilePic,
    this.middleName,
    this.lastName,
    this.extra,
  });

  factory GetPlayersData.fromJson(Map<String, dynamic> json) {
    return GetPlayersData(
      userId: json['userId'],
      firstName: json['firstName'],
      isPrimary: json['isPrimary'],
      middleName: json['middleName'],
      profilePic: json['profilePic'],
      lastName: json['lastName'],
      extra: json['extra'],
    );
  }
}

class GetPlayersModel {
  static Future<List<GetPlayersData>?> get(
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
}
