import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/shipment/shipment.dart';
import '../model/user/User.dart';
import '../shared/components/constants.dart';

class DatabaseService {
  static final users = FirebaseFirestore.instance.collection('users');
  static final _shipments = FirebaseFirestore.instance.collection('shipments');

  static Future<void> addUser(User user) {
    return users.doc(userId).set(user.toJson());
  }

  static Future<void> addShipment(Shipment shipment) {
    return _shipments.doc(shipment.id.toString()).set(shipment.toJson());
  }
}
