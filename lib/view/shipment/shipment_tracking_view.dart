import 'package:flutter/material.dart';

import '../../model/shipment/shipment.dart';


class ShipmentTrackingScreen extends StatefulWidget {
  final Shipment shipment;
  const ShipmentTrackingScreen(this.shipment,{Key? key}) : super(key: key);

  @override
  State<ShipmentTrackingScreen> createState() => _ShipmentTrackingScreenState();
}

class _ShipmentTrackingScreenState extends State<ShipmentTrackingScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 8,),
          Text('Tracking',style: TextStyle(fontSize: 18,color:Colors.black.withOpacity(.8),fontWeight: FontWeight.w600),),
        ],
      )
    );
  }


}
