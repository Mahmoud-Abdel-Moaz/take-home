import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import '../../model/shipment/locations.dart';
import '../../model/shipment/shipment.dart';
import '../../services/database.dart';
import '../../services/location_service.dart';
import '../../shared/components/constants.dart';
import '../../widgets/components.dart';
import 'shipment_tracking_view.dart';

class StartShipmentScreen extends StatefulWidget {
  const StartShipmentScreen({Key? key}) : super(key: key);

  @override
  State<StartShipmentScreen> createState() => _StartShipmentScreenState();
}

class _StartShipmentScreenState extends State<StartShipmentScreen> {
  final _shipmentIdController = TextEditingController();
  final _shipmentIdFocusNode = FocusNode(); //TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Add New shipment',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_ios_rounded,
                color: Colors.white, size: 20)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customTextField(
                controller: _shipmentIdController,
                context: context,
                hint: 'Shipment Id',
                focusNode: _shipmentIdFocusNode,
                onSubmit: addShipment),
            defaultButton(
                text: 'Add shipment',
                onTap: addShipment,
                context: context,
                isLoading: _isLoading),
          ],
        ),
      ),
    );
  }

  void addShipment() async {
    if (_shipmentIdController.text.isNotEmpty) {
      LocationService.checkLocationServicesInDevice(_shipmentIdController.text);
     /* LocationData? locationData =
          await LocationService.checkLocationServicesInDevice();
      if (locationData != null) {
        if (kDebugMode) {
          print('${locationData!.longitude} ${locationData!.latitude}');
          setState(() {
            _isLoading=!_isLoading;
          });
          Shipment shipment=Shipment(
              id: _shipmentIdController.text,
              driverId: userId,
              locations: [
                ShipmentLocation(
                    latitude: locationData.latitude,
                    longitude: locationData.longitude,
                    time: Timestamp.fromDate(DateTime.now()))
              ]);
          DatabaseService.addShipment(shipment).then((value){
            setState(() {
              _isLoading=!_isLoading;
            });
            navigateTo(context, ShipmentTrackingScreen(shipment));
          });
        }*/
     /* } else {
        showToast(
            msg: 'must Start Shipment with current location',
            state: ToastStates.ERROR);
      }*/
    } else {
      showToast(msg: 'Enter Shipment Id', state: ToastStates.ERROR);
    }
  }
}
