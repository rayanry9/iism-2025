class GetOutingDataResponse {
  final int outingId;
  final String reason;
  final DateTime entryTime;
  final DateTime exitTime;
  final DateTime createdAt;
  final String firstName;
  final String lastName;
  final int status;

  GetOutingDataResponse({
    required this.outingId,
    required this.reason,
    required this.entryTime,
    required this.exitTime,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.status,
  });

  factory GetOutingDataResponse.fromJson(Map<String, dynamic> json) {
    return GetOutingDataResponse(
      outingId: json['outingId'] as int,
      reason: json['reason'] as String,
      entryTime: DateTime.parse(json['entryTime']),
      exitTime: DateTime.parse(json['exitTime']),
      createdAt: DateTime.parse(json['createdAt']),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      status: json['status'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'outingId': outingId,
      'reason': reason,
      'entryTime': entryTime.toIso8601String(),
      'exitTime': exitTime.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'firstName': firstName,
      'lastName': lastName,
      'status': status,
    };
  }
}
