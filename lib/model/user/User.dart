import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? fullName, 
      String? company, 
      String? time,}){
    _fullName = fullName;
    _company = company;
    _time = time;
}

  User.fromJson(dynamic json) {
    _fullName = json['full_name'];
    _company = json['company'];
    _time = json['time'];
  }
  String? _fullName;
  String? _company;
  String? _time;
User copyWith({  String? fullName,
  String? company,
  String? time,
}) => User(  fullName: fullName ?? _fullName,
  company: company ?? _company,
  time: time ?? _time,
);
  String? get fullName => _fullName;
  String? get company => _company;
  String? get time => _time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['full_name'] = _fullName;
    map['company'] = _company;
    map['time'] = _time;
    return map;
  }

}