import 'package:iism_2025/models/pool_match.dart';

enum AthleticMatchType {
  heats(1),
  quarterFinal(2),
  semiFinal(3),
  finalMatch(4);

  final int value;
  const AthleticMatchType(this.value);

  static AthleticMatchType fromJson(int v) {
    return AthleticMatchType.values.firstWhere(
      (e) => e.value == v,
      orElse: () => AthleticMatchType.heats,
    );
  }

  int toJson() => value;
}

class GetAllAthleticMatchesResponse {
  final int id;
  final int sportId;
  final String participantsTempText;
  final List<int> participants;
  final DateTime startTime;
  final DateTime? endTime;
  final String? venue;
  final MatchStatus status;
  final AthleticMatchType type;
  final String? liveStreamLink;

  GetAllAthleticMatchesResponse({
    required this.id,
    required this.sportId,
    required this.participantsTempText,
    required this.participants,
    required this.startTime,
    this.endTime,
    this.venue,
    required this.status,
    required this.type,
    this.liveStreamLink,
  });

  factory GetAllAthleticMatchesResponse.fromJson(Map<String, dynamic> json) {
    return GetAllAthleticMatchesResponse(
      id: json["id"],
      sportId: json["sportId"],
      participantsTempText: json["participantsTempText"],
      participants: List<int>.from(json["participants"]),
      startTime: DateTime.parse(json["startTime"]),
      endTime: json["endTime"] != null ? DateTime.parse(json["endTime"]) : null,
      venue: json["venue"],
      status: MatchStatus.fromJson(json["status"]),
      type: AthleticMatchType.fromJson(json["type"]),
      liveStreamLink: json["liveStreamLink"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "sportId": sportId,
      "participantsTempText": participantsTempText,
      "participants": participants,
      "startTime": startTime.toIso8601String(),
      "endTime": endTime?.toIso8601String(),
      "venue": venue,
      "status": status.toJson(),
      "type": type.toJson(),
      "liveStreamLink": liveStreamLink,
    };
  }
}
