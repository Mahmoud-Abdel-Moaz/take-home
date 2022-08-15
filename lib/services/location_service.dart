
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

import '../model/shipment/locations.dart';
import '../model/shipment/shipment.dart';
import '../shared/components/constants.dart';
import 'database.dart';

class LocationService{

  static bool _serviceEnabled=false;
  static PermissionStatus? _permissionGranted;
  static Location location = Location();
static List<ShipmentLocation> _shipmentLocations=[];

  static Future<LocationData?> checkLocationServicesInDevice(String shipmentId) async {
    //make sure that the GPS is enabeld
    _shipmentLocations=[];
    _serviceEnabled = await location.serviceEnabled();

    if (_serviceEnabled) {
      // print('gps enabled');
     return _checkLocationPermission(shipmentId);
    } else {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) {
        //   print('start tracking');
        return _checkLocationPermission(shipmentId);
      } else {
        return null;
        // SystemNavigator.pop();
      }
    }
  }

  static Future<LocationData?> _checkLocationPermission(String shipmentId) async {
    //make  sure that the user give me the permission to get location
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.granted) {
      if (kDebugMode) {
        print('start tracking');
      }
      _getCurrentLocation(shipmentId);
     // return _getLocation();
    } else {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        if (kDebugMode) {
          print('start tracking');
        }
        _getCurrentLocation(shipmentId);
     //  return _getLocation();
      } else {
        return null;
      }
    }
  }


  static Future<LocationData> _getLocation() async {

    LocationData _locationData = await location.getLocation();
    return location.getLocation();

  }


  static Future<void> _getCurrentLocation(String shipmentId) async {
    if (Platform.isAndroid) {{
     bool isBackgroundModeEnabled= await location.isBackgroundModeEnabled();
     if(!isBackgroundModeEnabled) {
          location.enableBackgroundMode(enable: true);
        }
      }}
  //  LocationData _locationData = await location.getLocation();
   /* location.changeSettings(accuracy: LocationAccuracy.high,
    interval: 10000,
        distanceFilter: 1
    );*/
    location.onLocationChanged.listen((LocationData currentLocation) {
      if (kDebugMode) {
        print('currentLocation: ${currentLocation.latitude} ${currentLocation.longitude} ');
      }
      _shipmentLocations.add(ShipmentLocation(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude,
          time: Timestamp.fromDate(DateTime.now())));
      Shipment shipment=Shipment(
          id: shipmentId,
          driverId: userId,
          locations:_shipmentLocations);
      DatabaseService.addShipment(shipment);
    });

  }
}