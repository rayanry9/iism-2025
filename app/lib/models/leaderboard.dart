class GetLeaderboardDataResponse {
  final int instituteId;
  final int hostingIIT;
  final int points;
  final String achievedFrom;

  GetLeaderboardDataResponse({
    required this.instituteId,
    required this.hostingIIT,
    required this.points,
    required this.achievedFrom,
  });

  factory GetLeaderboardDataResponse.fromJson(Map<String, dynamic> json) {
    return GetLeaderboardDataResponse(
      instituteId: json["instituteId"],
      hostingIIT: json["hostingIIT"],
      points: json["points"],
      achievedFrom: json["achievedFrom"],
    );
  }
}
