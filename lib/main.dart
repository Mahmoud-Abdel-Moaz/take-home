import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'shared/components/constants.dart';
import 'shared/network/local/cache_helper.dart';
import 'view/login/login_view.dart';
import 'view/shipment/shipments_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  userId = CacheHelper.getData(key: "userId");
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Take Home',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:userId!=null? ShipmentsScreen(): const LoginScreen(),
    );
  }
}

