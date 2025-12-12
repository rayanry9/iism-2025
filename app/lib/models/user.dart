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

class Me {
  // ---------- Fields ----------
  String firstName;
  String? middleName;
  String? lastName;
  String gender;
  String email;
  String? profilePic;
  String? contactNo;
  String? emergencyContactNo;
  String? bloodGroup;
  int? jerseyNo;
  String? designation;
  String? foodPreference;
  String? hostel;
  String? checkInDate;
  String? checkOutDate;
  int role;
  bool staff;
  String? extra;
  String? remark;
  String? assignedId;
  String institute;
  dynamic sports; // can be list or null

  Me({
    required this.firstName,
    this.middleName,
    this.lastName,
    required this.gender,
    required this.email,
    this.profilePic,
    this.contactNo,
    this.emergencyContactNo,
    this.bloodGroup,
    this.jerseyNo,
    this.designation,
    this.foodPreference,
    this.hostel,
    this.checkInDate,
    this.checkOutDate,
    required this.role,
    required this.staff,
    this.extra,
    this.remark,
    this.assignedId,
    required this.institute,
    this.sports,
  });

  // ---------- Fill cache from JSON ----------
  static Me fromJson(Map<String, dynamic> json) {
    return Me(
      firstName: json["firstName"],
      middleName: json["middleName"],
      lastName: json["lastName"],
      gender: json["gender"],
      email: json["email"],
      profilePic: json["profilePic"],
      contactNo: json["contactNo"],
      emergencyContactNo: json["emergencyContactNo"],
      bloodGroup: json["bloodGroup"],
      jerseyNo: json["jersey_no"],
      designation: json["designation"],
      foodPreference: json["foodPreference"],
      hostel: json["hostel"],
      checkInDate: json["checkInDate"],
      checkOutDate: json["checkOutDate"],
      role: json["role"],
      staff: json["staff"],
      extra: json["extra"],
      remark: json["remark"],
      assignedId: json["assignedId"],
      institute: json["institute"],
      sports: json["sports"],
    );
  }
}
