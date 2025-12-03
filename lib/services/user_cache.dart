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
  }
}
