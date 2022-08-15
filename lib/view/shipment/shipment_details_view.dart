import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../model/shipment/locations.dart';

import '../../model/shipment/shipment.dart';

class ShipmentDetailsScreen extends StatefulWidget {
   final Shipment shipment;
  const ShipmentDetailsScreen(this.shipment,{Key? key}) : super(key: key);

  @override
  State<ShipmentDetailsScreen> createState() => _ShipmentDetailsScreenState();
}

class _ShipmentDetailsScreenState extends State<ShipmentDetailsScreen> {
  static CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 15,
  );
  GoogleMapController? _googleMapController;
  List<Marker> markers = [];

  Map<PolylineId, Polyline> polylines = {};
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    setState(() {
      _initialCameraPosition = CameraPosition(
        target: LatLng(widget.shipment!.locations!.last.latitude!,
            widget.shipment!.locations!.last.longitude!),
        zoom: 10,
      );
    });
    updateMarkers(widget.shipment!.locations!.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setPolyLines();

    return Scaffold(
      appBar: AppBar(),
      body:  GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: markers.toSet(),
        polylines: _polylines,
      ),
    );
  }

  void updateMarkers(ShipmentLocation shipmentLocation) async {
    setState(() {
      markers = [
        Marker(
          markerId: MarkerId(DateTime.parse(shipmentLocation.time!.toDate().toString()).toString()),
          infoWindow: InfoWindow(
            title: DateTime.parse(shipmentLocation.time!.toDate().toString()).toString(),
          ),
          position: LatLng(shipmentLocation.latitude!, shipmentLocation.longitude!),
        ),
      ];
    });
  }

  void setPolyLines() async {
    widget.shipment.locations?.forEach((point) {
      polylineCoordinates.add(LatLng(point.latitude!, point.longitude!));
    });
    setState(() {
      _polylines.add(Polyline(
          width: 5,
          polylineId:const PolylineId('polyLine'),
          color: Theme.of(context).primaryColor,
          points: polylineCoordinates));
    });

  }
}
