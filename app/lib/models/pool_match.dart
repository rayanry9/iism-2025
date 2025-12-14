enum MatchStatus {
  pending(1),
  ongoing(2),
  concluded(3);

  final int value;
  const MatchStatus(this.value);

  static MatchStatus fromJson(int v) {
    return MatchStatus.values.firstWhere(
      (e) => e.value == v,
      orElse: () => MatchStatus.pending,
    );
  }

  int toJson() => value;
}

enum PoolMatchType {
  league(1),
  preQuarter(2),
  quarterFinal(3),
  semiFinal(4),
  finalMatch(5);

  final int value;
  const PoolMatchType(this.value);

  static PoolMatchType fromJson(int v) {
    return PoolMatchType.values.firstWhere(
      (e) => e.value == v,
      orElse: () => PoolMatchType.league, // fallback if needed
    );
  }

  int toJson() => value;
}

class GetAllPoolMatchesResponse {
  final int id;
  final int sportId;
  final String team1TempName;
  final int? team1Id;
  final String team2TempName;
  final int? team2Id;
  final MatchStatus status;
  final int? result;
  final DateTime startTime;
  final DateTime? endTime;
  final String? venue;
  final PoolMatchType type;
  final String? matchName;
  final String? liveStreamLink;

  GetAllPoolMatchesResponse({
    required this.id,
    required this.sportId,
    required this.team1TempName,
    this.team1Id,
    required this.team2TempName,
    this.team2Id,
    required this.status,
    this.result,
    required this.startTime,
    this.endTime,
    this.venue,
    required this.type,
    this.matchName,
    this.liveStreamLink,
  });

  factory GetAllPoolMatchesResponse.fromJson(Map<String, dynamic> json) {
    return GetAllPoolMatchesResponse(
      id: json["id"],
      sportId: json["sportId"],
      team1TempName: json["team1TempName"],
      team1Id: json["team1Id"],
      team2TempName: json["team2TempName"],
      team2Id: json["team2Id"],
      status: MatchStatus.fromJson(json["status"]),
      result: json["result"],
      startTime: DateTime.parse(json["startTime"]),
      endTime: json["endTime"] != null ? DateTime.parse(json["endTime"]) : null,
      venue: json["venue"],
      type: PoolMatchType.fromJson(json["type"]),
      matchName: json["matchName"],
      liveStreamLink: json["liveStreamLink"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "sportId": sportId,
      "team1TempName": team1TempName,
      "team1Id": team1Id,
      "team2TempName": team2TempName,
      "team2Id": team2Id,
      "status": status.toJson(),
      "result": result,
      "startTime": startTime.toIso8601String(),
      "endTime": endTime?.toIso8601String(),
      "venue": venue,
      "type": type.toJson(),
      "matchName": matchName,
      "liveStreamLink": liveStreamLink,
    };
  }
}
