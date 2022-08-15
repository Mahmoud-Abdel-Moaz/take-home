import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? fullName, 
      String? phoneNumber, 
      Timestamp? time,}){
    _fullName = fullName;
    _company = phoneNumber;
    _time = time;
}

  User.fromJson(dynamic json) {
    _fullName = json['full_name'];
    _company = json['phoneNumber'];
    _time = json['time'];
  }
  String? _fullName;
  String? _company;
  Timestamp? _time;
User copyWith({  String? fullName,
  String? phoneNumber,
  Timestamp? time,
}) => User(  fullName: fullName ?? _fullName,
  phoneNumber: phoneNumber ?? _company,
  time: time ?? _time,
);
  String? get fullName => _fullName;
  String? get phoneNumber => _company;
  Timestamp? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['full_name'] = _fullName;
    map['phoneNumber'] = _company;
    map['time'] = _time;
    return map;
  }

}