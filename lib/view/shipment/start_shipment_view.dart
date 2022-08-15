import 'package:flutter/material.dart';
import '../../services/location_service.dart';
import '../../widgets/components.dart';

class StartShipmentScreen extends StatefulWidget {
  const StartShipmentScreen({Key? key}) : super(key: key);

  @override
  State<StartShipmentScreen> createState() => _StartShipmentScreenState();
}

class _StartShipmentScreenState extends State<StartShipmentScreen> {
  final _shipmentIdController = TextEditingController();
  final _shipmentIdFocusNode = FocusNode();
  bool _isTracking = false;

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
            if(_isTracking)
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(),
                    Text("Tracking ..."),
                  ],
                ),
              ),
            defaultButton(
              text: 'Add shipment',
              onTap: addShipment,
              context: context,),
          ],
        ),
      ),
    );
  }

  void addShipment() async {
    if (_shipmentIdController.text.isNotEmpty) {
      bool locationServicesEnabled = await LocationService
          .checkLocationServicesInDevice();
      if (locationServicesEnabled) {
        bool locationPermissionEnabled = await LocationService
            .checkLocationPermission();
        if (locationPermissionEnabled) {
          if (_isTracking) {
            setState(() {
              _isTracking = false;
            });
          }
          setState(() {
            _isTracking = true;
          });
          LocationService.getCurrentLocation(_shipmentIdController.text);
        } else {
          showToast(
              msg: 'Can not Start Tracking without location permission ',
              state: ToastStates.ERROR);
        }
      } else {
        showToast(
            msg: 'Can not Start Tracking without enable location services',
            state: ToastStates.ERROR);
      }
    }else {
      showToast(msg: 'Enter Shipment Id', state: ToastStates.ERROR);
    }
  }

}
