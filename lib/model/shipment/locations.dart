import 'package:cloud_firestore/cloud_firestore.dart';

class ShipmentLocation {
  ShipmentLocation({
      this.latitude, 
      this.longitude, 
      this.time,});

  ShipmentLocation.fromJson(dynamic json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
    time = json['time'];
  }
  double? latitude;
  double? longitude;
  Timestamp? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = latitude;
    map['longitude'] = longitude;
    map['time'] = time;
    return map;
  }

}