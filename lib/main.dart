import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:simposi/Screens/SplashScreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  StreamSubscription subscription;
  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  // void initState() {
  //   // super.initState();
  //   firebaseCloudMessaging_Listeners();
  // }

  void _checkConnectivity(ConnectivityResult result) async {
    if (result == ConnectivityResult.wifi) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.wifi) {
        // I am connected to a wifi network.
        print("Connected to Wifi");
      } else {
        print("Not Connected to Wifi");
      }
      subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      _checkConnectivity(result);
    });

    //  InAppPurchaseConnection.enablePendingPurchases();

    return MaterialApp(
      title: 'Simposi',
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: SplashWidget(),
      builder: (context, child) {
        return MediaQuery(
          child: child,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
    );
  }
}
