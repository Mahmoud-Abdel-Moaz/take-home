import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

import '../model/shipment/locations.dart';
import '../model/shipment/shipment.dart';
import '../shared/components/constants.dart';
import 'database.dart';

class LocationService {
  static bool _serviceEnabled = false;
  static PermissionStatus? _permissionGranted;
  static Location location = Location();
  static List<ShipmentLocation> _shipmentLocations = [];

  static Future<bool> checkLocationServicesInDevice() async {
    _shipmentLocations = [];
    _serviceEnabled = await location.serviceEnabled();
    if (_serviceEnabled) {
      return  true;
    } else {
      _serviceEnabled = await location.requestService();
      return _serviceEnabled;
    }
  }

  static Future<bool> checkLocationPermission() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.granted) {
      return true;
    } else {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }

  static Future<void> getCurrentLocation(String shipmentId) async {
    if (Platform.isAndroid) {
      {
        bool isBackgroundModeEnabled = await location.isBackgroundModeEnabled();
        if (!isBackgroundModeEnabled) {
          location.enableBackgroundMode(enable: true);
        }
      }
    }
    location.onLocationChanged.listen((LocationData currentLocation) {
      if (kDebugMode) {
        print(
            'currentLocation: ${currentLocation.latitude} ${currentLocation.longitude} ');
      }
      _shipmentLocations.add(ShipmentLocation(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
          time: Timestamp.fromDate(DateTime.now())));
      Shipment shipment = Shipment(
          id: shipmentId, driverId: userId, locations: _shipmentLocations);
      DatabaseService.addShipment(shipment);
    });
  }
}
