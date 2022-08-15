

import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/shipment/shipment.dart';
import '../shared/components/constants.dart';

class DatabaseService{
  static final users = FirebaseFirestore.instance.collection('users');
  static final _shipments = FirebaseFirestore.instance.collection('shipments');

  static Future<void> addUser(String name,String phoneNumber) {
   return users.doc(userId).set({
      'full_name': name,
      'company': phoneNumber,
      'time': Timestamp.fromDate(DateTime.now())
    });
  }

  static Future<void> addShipment(Shipment shipment) {
    return _shipments.doc(shipment.id.toString()).set(shipment.toJson());
  }
}