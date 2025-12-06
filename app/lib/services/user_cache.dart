<<<<<<< HEAD
class UserCache {
  // ---------- Singleton ----------
  static final UserCache _instance = UserCache._internal();
  factory UserCache() => _instance;
  UserCache._internal();

  // ---------- Fields ----------
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? email;
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
  int? role;
  bool? staff;
  String? extra;
  String? remark;
  String? assignedId;
  String? institute;
  dynamic sports;      // can be list or null

  bool hasData = false;

  // ---------- Fill cache from JSON ----------
  void fromJson(Map<String, dynamic> json) {
    firstName            = json["firstName"];
    middleName           = json["middleName"];
    lastName             = json["lastName"];
    gender               = json["gender"];
    email                = json["email"];
    profilePic           = json["profilePic"];
    contactNo            = json["contactNo"];
    emergencyContactNo   = json["emergencyContactNo"];
    bloodGroup           = json["bloodGroup"];
    jerseyNo             = json["jersey_no"];
    designation          = json["designation"];
    foodPreference       = json["foodPreference"];
    hostel               = json["hostel"];
    checkInDate          = json["checkInDate"];
    checkOutDate         = json["checkOutDate"];
    role                 = json["role"];
    staff                = json["staff"];
    extra                = json["extra"];
    remark               = json["remark"];
    assignedId           = json["assignedId"];
    institute            = json["institute"];
    sports               = json["sports"];

    hasData = true;
=======
import 'package:flutter/material.dart';

class UserCache {
  static final UserCache _instance = UserCache._internal();

  String? name;
  String? email;
  String? avatar;

  factory UserCache() => _instance;

  UserCache._internal();

  bool get hasData => name != null;
  
  void clear() {
    name = null;
    email = null;
    avatar = null;
>>>>>>> feature/chat-ui
  }
}
