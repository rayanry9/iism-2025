class GetAllInstitutesResponse {
  final int id;
  final String name;

  GetAllInstitutesResponse({required this.id, required this.name});

  factory GetAllInstitutesResponse.fromJson(Map<String, dynamic> json) {
    return GetAllInstitutesResponse(id: json["id"], name: json["name"]);
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name};
  }
}
