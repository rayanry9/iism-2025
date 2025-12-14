enum SportType {
  male(1),
  female(2),
  mixed(3),
  athleticsMale(4),
  athleticsFemale(5),
  athleticsMixed(6),
  athleticsMaleRelay(7),
  athleticsFemaleRelay(8),
  athleticsMixedRelay(9);

  final int value;
  const SportType(this.value);

  static SportType fromJson(int v) {
    return SportType.values.firstWhere(
      (e) => e.value == v,
      orElse: () => SportType.male,
    );
  }

  int toJson() => value;
}

class GetAllSportsResponse {
  final int id;
  final String name;
  final bool staff;
  final SportType type;

  GetAllSportsResponse({
    required this.id,
    required this.name,
    required this.staff,
    required this.type,
  });

  factory GetAllSportsResponse.fromJson(Map<String, dynamic> json) {
    return GetAllSportsResponse(
      id: json["id"],
      name: json["name"],
      staff: json["staff"],
      type: SportType.fromJson(json["type"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "staff": staff, "type": type.toJson()};
  }
}
