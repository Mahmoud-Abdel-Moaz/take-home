import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../view/login/login_view.dart';
import '../../view/shipment/shipment_details_view.dart';
import '../../model/shipment/shipment.dart';
import '../../services/authentication.dart';
import '../../widgets/components.dart';

import 'start_shipment_view.dart';

class ShipmentsScreen extends StatelessWidget {
   ShipmentsScreen({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> _shipmentStream = FirebaseFirestore.instance.collection('shipments').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Shipments',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading:IconButton(onPressed: ()=>navigateTo(context, const StartShipmentScreen()), icon: const Icon(Icons.add,color: Colors.white,size: 20,),),

        actions: [
          IconButton(onPressed: () {
            AuthenticationService.signOut();
            navigateToAndFinish(context, const LoginScreen());
          }, icon: const Icon(Icons.logout,color: Colors.white,size: 20,),),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: StreamBuilder<QuerySnapshot>(
          stream: _shipmentStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            }

            return ListView.separated(

              itemCount: snapshot.data!.docs.length,
              separatorBuilder: (BuildContext context, int index)  =>const SizedBox(height: 16,),

              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> data = snapshot.data!.docs[index].data()! as Map<String, dynamic>;
                Shipment shipment=Shipment.fromJson(data);
                return GestureDetector(
                  onTap: (){
                    navigateTo(context, ShipmentDetailsScreen(shipment));
                  },
                  child: ListTile(
                    title: Text(shipment.id!),
                    subtitle: Text(DateTime.parse(shipment.locations!.first.time!.toDate().toString()).toString()),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

}
