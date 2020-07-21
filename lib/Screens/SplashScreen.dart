/*
*  splash_widget.dart
*  Simposi App Designs V3.0
*
*  Created by .
*  Copyright © 2018 . All rights reserved.
    */

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simposi/Screens/GetStartedScreen.dart';
import 'package:simposi/Screens/TabViewController/GroupFinderChat.dart';
import 'package:simposi/Screens/TabViewController/mainTabView.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/smartutils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashWidget extends StatefulWidget {
  @override
  _SplashWidgetState createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget> {
  SharedPreferences preferences;
  // final FirebaseMessaging _fcm = FirebaseMessaging();
  // StreamSubscription iosSubscription;

  @override
  Future<void> initState() {
    // TODO: implement initState
    super.initState();
    _init();
    // _fcm.requestNotificationPermissions(IosNotificationSettings());
    firebaseCloudMessaging_Listeners();
    // _register();
    // if (Platform.isIOS) {
    //   iosSubscription = _fcm.onIosSettingsRegistered.listen((data) {
    //     // save the token  OR subscribe to a topic here
    //   });

    // }
  }

  String _message = '';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  // _register() {
  //   _firebaseMessaging.getToken().then((token) => {
  //     print(token)
  //   });
  // }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print('Push notification token');
      print(token);
      preferences.setString("deviceToken", token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  // void getMessage() {
  //   _firebaseMessaging.configure(
  //       onMessage: (Map<String, dynamic> message) async {
  //     print('on message $message');
  //     setState(() => _message = message["notification"]["title"]);
  //   }, onResume: (Map<String, dynamic> message) async {
  //     print('on resume $message');
  //     setState(() => _message = message["notification"]["title"]);
  //   }, onLaunch: (Map<String, dynamic> message) async {
  //     print('on launch $message');
  //     setState(() => _message = message["notification"]["title"]);
  //   });
  // }

  void _init() async {
    preferences = await SharedPreferences.getInstance();
    int userId = preferences.getInt('userId');
    int isEventGoing = preferences.getInt('isEventGoing');

    if (userId != null) {
      if (isEventGoing != null) {
        if (isEventGoing == 1) {
          String startTime = preferences.getString('startTime');

          if (startTime != null) {
            DateTime tempDate =
                new DateFormat("yyyy-MM-dd hh:mm:ss").parse(startTime);

            final date2 = DateTime.now();
            final difference = date2.difference(tempDate).inMinutes;
            if (difference < 60) {
              //  Navigator.push(
              // context, MaterialPageRoute(builder: (context) => MainTabView()));
              callEventDetailApi();
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainTabView()));
            }
          }
          //
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainTabView()));
        }
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainTabView()));
      }
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => GetStarted()));
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
      backgroundColor: SmartUtils.blueBackground, //Colors.white,//
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 25, 39, 240),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 110,
              height: 115,
              child: Image.asset(
                "assets/group-7.png",
                fit: BoxFit.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  callEventDetailApi() async {
    //eventDetail

    EventDetailRequest request;
    request = EventDetailRequest();
    int eventId = preferences.getInt('event_id');
    if (eventId != null) {
      request.event_id = eventId.toString();
    }

    request.languageId = 1;

    EvenDetailResponse responseBusiness =
        await ApiProvider().callEvenntDetailsApi(params: request);

    print(responseBusiness);
    if (responseBusiness.status == true) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GroupFinderChat(
                    event: responseBusiness.event,
                  )));
      // request
    } else {
      // SmartUtils.showErrorDialog(context, responseBusiness.message);
    }

    return responseBusiness;
  }
}
