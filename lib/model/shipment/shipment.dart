import 'locations.dart';

class Shipment {
  Shipment({
      this.id, 
      this.driverId, 
      this.locations,});

  Shipment.fromJson(dynamic json) {
    id = json['id'];
    driverId = json['driverId'];
    if (json['locations'] != null) {
      locations = [];
      json['locations'].forEach((v) {
        locations!.add(ShipmentLocation.fromJson(v));
      });
    }
  }
  String? id;
  String? driverId;
  List<ShipmentLocation>? locations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['driverId'] = driverId;
    if (locations != null) {
      map['locations'] = locations!.map((v) => v.toJson()).toList();
    }
    return map;
  }

}