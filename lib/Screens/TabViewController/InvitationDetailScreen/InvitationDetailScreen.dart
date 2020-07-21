import 'dart:async';
import 'dart:ffi';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simposi/Screens/TabViewController/InvitationDetailScreen/PurposeNewTime.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/Utility/Values/gradients.dart';
import 'package:simposi/Utils/Utility/Values/radii.dart';
import 'package:simposi/Utils/smartutils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

const iOSLocalizedLabels = false;

class InvitationDetailScreen extends StatefulWidget {
  final EventList event;
  InvitationDetailScreen({
    @required this.event,
  });

  @override
  _InvitationDetailScreenState createState() =>
      _InvitationDetailScreenState(event: event);
}

class _InvitationDetailScreenState extends State<InvitationDetailScreen> {
  Contact _contact;
  final Set<Marker> _markers = {};
  String _mapStyle;
  BitmapDescriptor bitmapImage;
  final EventList event;
  _InvitationDetailScreenState({
    @required this.event,
  });

  void onCloseButtonPressed(BuildContext context) {
    //Navigator.of(context).pop();
    Navigator.pop(context, 'Back');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    rootBundle.loadString('assets/json/map_style.json').then((string) {
      _mapStyle = string;
      print("Map style" + _mapStyle);
    });

    _getMarkerData();
  }

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    final CameraPosition _kGooglePlex = CameraPosition(
      // target: LatLng(_locationData.latitude == null ? 21.23422:_locationData.latitude, _locationData.longitude == null ? -73.245245:_locationData.longitude),
      target: LatLng(event.latitude, event.longitude),

      zoom: 14.4746,
    );

    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
      body: Container(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(top: 0),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height, //- 75,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(top: 23),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 29,
                              height: 29,
                              margin: EdgeInsets.only(right: 20, top: 34),
                              child: FlatButton(
                                onPressed: () =>
                                    this.onCloseButtonPressed(context),
                                color: Color.fromARGB(0, 0, 0, 0),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(0)),
                                ),
                                textColor: Color.fromARGB(255, 0, 0, 0),
                                padding: EdgeInsets.all(0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/group-3-2.png",
                                        height: 29, width: 29),
                                    SizedBox(
                                      width: 0,
                                    ),
                                    Text(
                                      "",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            // left: 0,
                            // top: 0,
                            child: Opacity(
                              opacity: 0.14723,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    height: 212,
                                    margin: EdgeInsets.only(top: 21, right: 25),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            width: 132,
                                            height: 141,
                                            margin: EdgeInsets.only(top: 20),
                                            child: Image.asset(
                                              "assets/pink-man.png",
                                              fit: BoxFit.none,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            width: 151,
                                            height: 212,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    width: 132,
                                                    height: 141,
                                                    margin: EdgeInsets.only(
                                                        top: 42, right: 18),
                                                    child: Image.asset(
                                                      "assets/yellow-man.png",
                                                      fit: BoxFit.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      width: 148,
                                      height: 157,
                                      margin: EdgeInsets.only(left: 58),
                                      child: Image.asset(
                                        "assets/blue-man.png",
                                        fit: BoxFit.none,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 16, right: 43, bottom: 59),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Container(
                                              width: 132,
                                              height: 141,
                                              margin:
                                                  EdgeInsets.only(bottom: 78),
                                              child: Image.asset(
                                                "assets/pink-man.png",
                                                fit: BoxFit.none,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          Container(
                                            width: 132,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    width: 132,
                                                    height: 141,
                                                    child: Image.asset(
                                                      "assets/yellow-man.png",
                                                      fit: BoxFit.none,
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    width: 132,
                                                    height: 157,
                                                    child: Image.asset(
                                                      "assets/blue-man-2.png",
                                                      fit: BoxFit.none,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 238, bottom: 35),
                            // top: 238,
                            // bottom: 35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, //ji
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 93,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          // margin: EdgeInsets.symmetric(horizontal: 19),
                                          child: Text(
                                            "You’ve been invited to meet new people at",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 7),
                                          child: Text(
                                            "Ditch Fashion Show",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.w800,
                                              fontSize: 30,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            // "123 Main Street, Vancouver",
                                            event.location.isEmpty == true
                                                ? event.location
                                                : "N/A",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.w800,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    // width: 301,
                                    height: 111,
                                    margin: EdgeInsets.only(
                                        top: 57, left: 37, right: 37),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 255, 1, 126),
                                            borderRadius: Radii.k25pxRadius,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: GestureDetector(
                                                  child: Text(
                                                    "RSVP " +
                                                        event
                                                            .event_date, //SEPT 19, 6:00 PM",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .secondaryText,
                                                      fontFamily: "Muli",
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  onTap: () => {
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            CupertinoAlertDialog(
                                                              title: new Text(
                                                                  "You're Going"),
                                                              content: new Text(
                                                                  event.title +
                                                                      "On " +
                                                                      event
                                                                          .event_date),
                                                              actions: <Widget>[
                                                                CupertinoDialogAction(
                                                                  onPressed:
                                                                      () => {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(),
                                                                    callCheckInEventData(),
                                                                  },
                                                                  child: Text(
                                                                    "Done",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          0,
                                                                          122,
                                                                          255),
                                                                      fontFamily:
                                                                          "Helvetica",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          17,
                                                                      letterSpacing:
                                                                          -0.408,
                                                                      height:
                                                                          1.29412,
                                                                    ),
                                                                  ),
                                                                ),
                                                                CupertinoDialogAction(
                                                                  onPressed:
                                                                      () => {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(),
                                                                  },
                                                                  child: Text(
                                                                    "Cancel",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          0,
                                                                          122,
                                                                          255),
                                                                      fontFamily:
                                                                          "Helvetica",
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          17,
                                                                      letterSpacing:
                                                                          -0.408,
                                                                      height:
                                                                          1.29412,
                                                                    ),
                                                                  ),
                                                                ),
                                                                // event_check_in
                                                              ],
                                                            )),
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Spacer(),
                                        Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color:
                                                Color.fromARGB(255, 45, 46, 48),
                                            borderRadius: Radii.k25pxRadius,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: GestureDetector(
                                                  onTap: () => {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                PurposeNewTimeScreen(
                                                                    event: this
                                                                        .event))),
                                                  },
                                                  child: Text(
                                                    "Propose New Time",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: AppColors
                                                          .secondaryText,
                                                      fontFamily: "Muli",
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    //call cancel event api
                                  },
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 21),
                                      child: Text(
                                        "Decline",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.accentText,
                                          fontFamily: "Muli",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    width: 200,
                                    height: 54,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          "Scroll down to view more",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 207, 207, 207),
                                            fontFamily: "Muli",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Spacer(),
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            child: Stack(
                                              alignment: Alignment.bottomCenter,
                                              children: [
                                                Container(
                                                  //bottom: 0,
                                                  child: Opacity(
                                                    opacity: 0.20382,
                                                    child: Image.asset(
                                                      "assets/path-3.png",
                                                      fit: BoxFit.none,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  // bottom: 8,
                                                  margin: EdgeInsets.only(
                                                      bottom: 8),
                                                  child: Image.asset(
                                                    "assets/ic-arrow-downward-48px.png",
                                                    fit: BoxFit.none,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //   ),
                    // ),

                    Container(
                      height: 586,
                      margin: EdgeInsets.only(bottom: 12),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                              child: Image.network(
                            event.imagesModel[0].image,
                            fit: BoxFit.fitHeight,
                            height: 420,
                          )),
                          // Positioned(
                          // margin: EdgeInsets.only(bottom:108, left: 0,right: 0),
                          // left: 0,
                          // right: 0,
                          // bottom: 108,
                          // child:
                          // Image.network(
                          //  event.imagesModel[0].image,),
                          //  height: 173,width:MediaQuery.of(context).size.width-32 ,fit: BoxFit.fill,

                          // Image.asset(
                          // "assets/rectangle-ease-in-outlrgb15-2.png",
                          // fit: BoxFit.cover,
                          // ),
                          // ),
                          Container(
                            // color: Colors.red,
                            margin: EdgeInsets.only(
                              top: 220,
                            ),
                            height: 200,
                            decoration: BoxDecoration(
                              gradient: Gradients.imageGradient,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              left: 16,
                              top: 402,
                            ), //438
                            // left: 16,
                            // bottom: 0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    // "Ditch Fashion Show",
                                    event.title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppColors.primaryText,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 21,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 50,
                                    height: 31,
                                    margin: EdgeInsets.only(left: 2, top: 15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            width: 19,
                                            height: 19,
                                            margin: EdgeInsets.only(top: 3),
                                            child: Image.asset(
                                              "assets/time.png",
                                              fit: BoxFit.none,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    event.eventDay +
                                                        ', ' +
                                                        event.eventMonth +
                                                        " " +
                                                        event
                                                            .eventDate, //"Thursday, September 19"
                                                    // "Thursday, September 19",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.primaryText,
                                                      fontFamily: "Muli",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    event.eventTime,
                                                    // "6:00 PM ",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.accentText,
                                                      fontFamily: "Muli",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 31,
                                  margin: EdgeInsets.only(left: 3, top: 12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          width: 17,
                                          height: 21,
                                          child: Image.asset(
                                            "assets/location.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 11),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                height: 16,
                                                margin:
                                                    EdgeInsets.only(right: 110),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        event
                                                            .title, //event.location.isEmpty ? "N/A":event.location,
                                                        // event.social_name,
                                                        //"Cobana Pool Bar",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .primaryText,
                                                          fontFamily: "Muli",
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Container(
                                                        width: 4,
                                                        height: 7,
                                                        margin: EdgeInsets.only(
                                                            top: 5),
                                                        child: Image.asset(
                                                          "assets/forward-2.png",
                                                          fit: BoxFit.none,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Spacer(),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  event.location.isEmpty
                                                      ? "N/A"
                                                      : event
                                                          .location, //"11 Polson St, Toronto, ON M5A 1A4, Canada",
                                                  // "11 Polson St, Toronto, ON M5A 1A4, Canada",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: AppColors.accentText,
                                                    fontFamily: "Muli",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 222,
                                    height: 49,
                                    margin: EdgeInsets.only(left: 2),
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        Container(
                                          // left: 28,
                                          margin: EdgeInsets.only(left: 28),
                                          child: Text(
                                            event.whoIsGointToString,
                                            // "2 Men, 1 Women, 1 LGBTQ",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.accentText,
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // left: 0,
                                          // top: 0,
                                          // right: 0,
                                          // bottom: 0,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  width: 114,
                                                  height: 20,
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Container(
                                                          width: 19,
                                                          height: 18,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 2),
                                                          child: Image.asset(
                                                            "assets/profile-3.png",
                                                            fit: BoxFit.none,
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 9),
                                                          child: Text(
                                                            "Who’s Going?",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              color: AppColors
                                                                  .primaryText,
                                                              fontFamily:
                                                                  "Muli",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 13,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                              // Align(
                                              //   alignment: Alignment.topRight,
                                              //   child: Text(
                                              //     "1 Doctor, 1 Lawyer, 1 Interior Designer",
                                              //     textAlign: TextAlign.left,
                                              //     style: TextStyle(
                                              //       color: AppColors.accentText,
                                              //       fontFamily: "Muli",
                                              //       fontWeight: FontWeight.w400,
                                              //       fontSize: 11,
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 108,
                      margin: EdgeInsets.only(left: 16, right: 14, bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 1,
                            margin: EdgeInsets.only(left: 3),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 187, 187, 187),
                            ),
                            child: Container(),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 2, top: 14),
                              child: Text(
                                "Organized by",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: AppColors.primaryText,
                                  fontFamily: "Muli",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 21,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 35,
                            margin:
                                EdgeInsets.only(left: 2, top: 15, right: 18),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  width: 55,
                                  margin: EdgeInsets.only(top: 3, bottom: 1),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          event.user_name,
                                          // "User",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColors.primaryText,
                                            fontFamily: "Muli",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Generated",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: AppColors.accentText,
                                            fontFamily: "Muli",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    width: 22,
                                    height: 35,
                                    margin: EdgeInsets.only(right: 2),
                                    child: Image.asset(
                                      "assets/100x100sugar-50.png",
                                      fit: BoxFit.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 1,
                            margin: EdgeInsets.only(right: 3),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 187, 187, 187),
                            ),
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                    event.otherTime1.isEmpty == true
                        ? Container()
                        : Container(
                            height: 103,
                            margin: EdgeInsets.only(
                                left: 16, right: 15, bottom: 19),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 1),
                                    child: Text(
                                      "Other Times",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w800,
                                        fontSize: 21,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  margin: EdgeInsets.only(left: 2, top: 9),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 210,
                                        height: 16,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 6,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColors.secondaryElement,
                                                border: Border.all(
                                                  width: 1.5,
                                                  color: Color.fromARGB(
                                                      255, 25, 39, 240),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3)),
                                              ),
                                              child: Container(),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 12),
                                                child: Text(
                                                  event.otherTime1.isEmpty
                                                      ? "N/A"
                                                      : event.otherTime1,
                                                  // "Friday, September 20, 6:00 PM",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryText,
                                                    fontFamily: "Muli",
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 80,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryElement,
                                          border: Border.all(
                                            width: 1.5,
                                            color: Color.fromARGB(
                                                255, 255, 1, 126),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                "VIEW",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 1, 126),
                                                  fontFamily: "Muli",
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  margin: EdgeInsets.only(left: 2, top: 7),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 230,
                                        height: 16,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 6,
                                              height: 6,
                                              decoration: BoxDecoration(
                                                color:
                                                    AppColors.secondaryElement,
                                                border: Border.all(
                                                  width: 1.5,
                                                  color: Color.fromARGB(
                                                      255, 25, 39, 240),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(3)),
                                              ),
                                              child: Container(),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 13),
                                                child: Text(
                                                  event.otherTime2.isEmpty
                                                      ? "N/A"
                                                      : event
                                                          .otherTime2, // "Saturday, September 21, 8:00 PM",
                                                  // "Saturday, September 21, 8:00 PM",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryText,
                                                    fontFamily: "Muli",
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        width: 80,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: AppColors.secondaryElement,
                                          border: Border.all(
                                            width: 1.5,
                                            color: Color.fromARGB(
                                                255, 255, 1, 126),
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                "VIEW",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 255, 1, 126),
                                                  fontFamily: "Muli",
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 1,
                                  margin: EdgeInsets.only(right: 2, bottom: 1),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 187, 187, 187),
                                  ),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),

                    Container(
                      height: 379,
                      margin: EdgeInsets.only(left: 17, right: 14, bottom: 19),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Description",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w800,
                                fontSize: 21,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              //  width: 294,
                              height: 16,
                              margin: EdgeInsets.only(left: 1, top: 4),
                              child: Row(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryElement,
                                      border: Border.all(
                                        width: 1.5,
                                        color: Color.fromARGB(255, 25, 39, 240),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(3)),
                                    ),
                                    child: Container(),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 13),
                                      child: Text(
                                        event.wantToMeetString +
                                            ' ' +
                                            event
                                                .generationIdentifyString, //"Men, Women, LGBTQ, iGen, Millennial, Gen X",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: AppColors.primaryText,
                                          fontFamily: "Muli",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 11, right: 2),
                            child: Text(
                              event.description,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w400,
                                fontSize: 11,
                                height: 1.27273,
                              ),
                            ),
                          ),

                          new Wrap(
                            spacing: 10.0,
                            children: new List.generate(
                                this.event.interest.length,
                                (index) => Container(
                                      child: GestureDetector(
                                        child: Chip(
                                          label: new Text(
                                            this.event.interest[index].title,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Muli'),
                                          ),
                                          backgroundColor:
                                              SmartUtils.themeGrayColor,
                                        ),
                                      ),
                                    )),
                          ),

// Spacer(),

                          Container(
                            height: 229,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 17, right: 0),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => {
                                    this.openMap(
                                        event.latitude, event.longitude)
                                  },
                                  child: Container(
                                    child: GoogleMap(
                                      mapType: MapType.normal,
                                      myLocationButtonEnabled: false,
                                      myLocationEnabled: false,
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                            event.latitude, event.longitude),
                                        zoom: 14.4746,
                                      ),
                                      onMapCreated:
                                          (GoogleMapController controller) {
                                        controller.setMapStyle(_mapStyle);
                                        _controller.complete(controller);
                                      },
                                      markers: _markers,
                                    ),
                                  ),
                                ),
                                // Positioned(

                                //   left: -1,
                                //   right: -1,
                                //   child: Image.asset(
                                //     "assets/maps---4600-cambie-st-vancouver-bc-v5z-2z1-canada---zoom-15.png",
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                                // Positioned(
                                //   top: 32,
                                //   right: 135,
                                //   child: Image.asset(
                                //     "assets/pin.png",
                                //     fit: BoxFit.none,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        //  ),
      ),
    );
  }

  Future<void> _askPermissions() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus != PermissionStatus.granted) {
      _handleInvalidPermissions(permissionStatus);
    } else {
      _pickContact();
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.contacts);
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.disabled) {
      Map<PermissionGroup, PermissionStatus> permissionStatus =
          await PermissionHandler()
              .requestPermissions([PermissionGroup.contacts]);
      return permissionStatus[PermissionGroup.contacts] ??
          PermissionStatus.unknown;
    } else {
      return permission;
    }
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      throw PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to location data denied",
          details: null);
    } else if (permissionStatus == PermissionStatus.disabled) {
      throw PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }

  Future<void> _pickContact() async {
    try {
      final Contact contact = await ContactsService.openDeviceContactPicker(
          iOSLocalizedLabels: iOSLocalizedLabels);
      if (mounted) {
        setState(() {
          _contact = contact;
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //Check In Api Called

  callCheckInEventData() async {
    //TODO : CALL Register Api Here

    CheckInRequest request;
    request = CheckInRequest();
    request.eventId = event.event_id;

    CheckInEventListResponse responseBusiness =
        await ApiProvider().callCheckEventList(params: request);

    print(responseBusiness);
    if (responseBusiness.status == true) {
    } else {
      SmartUtils.showErrorDialog(context, responseBusiness.message);
    }

    return responseBusiness;
  }

  Set<Marker> _getMarkerData() {
    Marker marker;
    //double lat, long;
    _createMarkerImageFromAsset();
    for (int i = 1; i <= 1; i++) {
      // setState(() {
      marker = new Marker(
          markerId: MarkerId(i.toString()),
          position: new LatLng(event.latitude, event.longitude),
          // infoWindow: InfoWindow(title: "Dance Class", onTap: () {}),
          icon: bitmapImage);

      _markers.add(marker);
      // });
    }

    return _markers;
  }

  Future<BitmapDescriptor> _createMarkerImageFromAsset() async {
    ImageConfiguration configuration = ImageConfiguration();
    bitmapImage =
        await BitmapDescriptor.fromAssetImage(configuration, 'assets/pin.png');
    return bitmapImage;
  }

  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
