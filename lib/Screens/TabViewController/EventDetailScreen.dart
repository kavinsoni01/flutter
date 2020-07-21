import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simposi/Screens/TabViewController/AlertScreen/violet_button.dart';
import 'package:simposi/Screens/TabViewController/GroupFinderChat.dart';
// import 'package:latlong/latlong.dart';
import 'package:simposi/Screens/TabViewController/InvitationDetailScreen/CancelRSVP.dart';
import 'package:simposi/Screens/TabViewController/mainTabView.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/Utility/Values/gradients.dart';
import 'package:simposi/Utils/Utility/Values/grey_button_full_width.dart';
import 'package:simposi/Utils/Utility/pink_button.dart';
import 'package:simposi/Utils/Utility/youre_going_badge.dart';
import 'package:simposi/Utils/smartutils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailScreens extends StatefulWidget {
  final EventList event;
  EventDetailScreens({
    @required this.event,
  });

  @override
  _EventDetailScreensState createState() =>
      _EventDetailScreensState(event: this.event);
}

class _EventDetailScreensState extends State<EventDetailScreens> {
  final Set<Marker> _markers = {};
  String _mapStyle;
  BitmapDescriptor bitmapImage;
  Completer<GoogleMapController> _controller = Completer();
  double lat = 00;
  double long = 00;
  Location location;
  var animationWidth = 0.0;

  SharedPreferences preferences;

// PersistentBottomSheetController
// var bottomsheet;
// final _scaffoldKey = GlobalKey<ScaffoldState>(); // <---- Another instance variable
  bool pressAttention = false;
  final EventList event;
  _EventDetailScreensState({
    @required this.event,
  });

  void onPxClosePressed(BuildContext context) {
    //  Navigator.of(context).pop();
    Navigator.pop(context, 'Back');
  }

  void onSharePressed(BuildContext context) {
    final RenderBox box = context.findRenderObject();
    Share.share(event.title,
        subject: event.description,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  void onMenuPressed(BuildContext context) {
    bottomActionSheet();
  }

  void onSnoozePressed(BuildContext context) {
    Navigator.of(context).pop();
  }

  void onCancelRSVPPressed(BuildContext context) {
    Navigator.of(context).pop();

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => CancelRSVP(event: this.event)));
  }

//   void onCheckinButtonPressed(BuildContext context) {
//   //GroupFinderChat
//     animationWidth = MediaQuery.of(context).size.width - 60;

//    setModalState(() {
//     animationWidth = MediaQuery.of(context).size.width - 60;;
// });

//        new Future.delayed(new Duration(seconds: 5), () {

//              Navigator.push(context, MaterialPageRoute(builder: (context) => GroupFinderChat()));
//        });
//   }

  Future<void> bottomActionSheet() async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          // title: Text('Action'),
          // message: Text('Select Action'),
          actions: <Widget>[
            // CupertinoActionSheetAction(
            //   child: Text('Propose New Time'),
            //   onPressed: () { /** */ },
            // ),
            // CupertinoActionSheetAction(
            //   child: Text('Invite a Friend'),
            //   onPressed: () { /** */ },
            // ),
            CupertinoActionSheetAction(
              child: Text(
                'Cancel RSVP',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                // Navigator.of(context).popAndPushNamed(MaterialPageRoute(builder: (context) => CancelRSVP()));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CancelRSVP(event: this.event)));
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Cancel Social',
                  style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CancelRSVP(event: this.event)));
                callCancelSocialApi();
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  callCancelSocialApi() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: _centerLoading(),
        );
      },
    );

    CancelSocialRequest request;
    request = CancelSocialRequest();
    request.eventId =
        event.event_id.toString(); //this.notification.user_id.toString();
    request.notificationId = '1';

    AttendNotificationResponse responseBusiness =
        await ApiProvider().callCancelSocial(params: request);

    Navigator.of(context).pop();

    new Future.delayed(new Duration(seconds: 1), () {
      print(responseBusiness);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => MainTabView()),
          (Route<dynamic> route) => false);

      // Navigator.of(context).pop();
      SmartUtils.showErrorDialog(context, responseBusiness.message);
    });

    return responseBusiness;
  }

  void onCheckInPressed(BuildContext context) {
    showModalBottomSheet(
        context: context,
        clipBehavior: Clip.hardEdge,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              color: Colors.transparent,
              child: new Wrap(
                children: <Widget>[showCheckinView()],
              ),
            ),
          );
        } //
        );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
    rootBundle.loadString('assets/json/map_style.json').then((string) {
      _mapStyle = string;
      print("Map style" + _mapStyle);
    });

    _getMarkerData();
  }

  void _init() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    lat = event.latitude;
    long = event.longitude;

    // final CameraPosition _kGooglePlex = CameraPosition(
    //   // target: LatLng(_locationData.latitude == null ? 21.23422:_locationData.latitude, _locationData.longitude == null ? -73.245245:_locationData.longitude),
    //   target: LatLng(double.parse(event.latitude) ?? 00,
    //       double.parse(event.longitude) ?? 00),

    //   zoom: 14.4746,
    // );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 52,
              margin: EdgeInsets.only(top: 52),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 30,
                      margin: EdgeInsets.only(
                          left: 15, top: 0), //symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            child: GestureDetector(
                              child: Image.asset(
                                'assets/64px-close-2.png',
                                height: 22,
                                width: 22,
                              ),
                              onTap: () => this.onPxClosePressed(context),
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 22,
                            height: 22,
                            child: GestureDetector(
                              child: Image.asset(
                                'assets/share@3x.png',
                                height: 22,
                                width: 22,
                              ),
                              onTap: () => this.onSharePressed(context),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                            width: 22,
                            height: 22,
                            child: GestureDetector(
                              child: Image.asset(
                                'assets/menu@3x.png',
                                height: 22,
                                width: 22,
                              ),
                              onTap: () => this.onMenuPressed(context),
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 19),
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Container(
                            // margin: EdgeInsets.only(top:10,right:10),
                            // left: 0,
                            // top: 0,
                            // right: 0,
                            child: event.imagesModel.length > 0
                                ? Image.network(
                                    event.imagesModel[0].image,
                                    fit: BoxFit.fill,
                                    height: 420,
                                  )
                                : Image.asset(
                                    "assets/rectangleEaseInOutLrgb15@3x.png",
                                    fit: BoxFit.cover,
                                  ),
                          ),
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
                              margin: EdgeInsets.only(top: 400, left: 15),
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          width: 100,
                                          height: 20,
                                          child: YoureGoingBadge(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: Text(
                                                    "You’re Going",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 255, 1, 126),
                                                      fontFamily: "Muli",
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 11,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )),
                                    SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            event
                                                .title, // "Ditch Fashion Show",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.w800,
                                              fontSize: 21,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                margin: EdgeInsets.only(top: 5),
                                                child: Image.asset(
                                                  "assets/time@3x.png",
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    80,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          event.eventDay +
                                                              ', ' +
                                                              event.eventMonth +
                                                              " " +
                                                              event
                                                                  .eventDate, //"Thursday, September 19",
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
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          event.eventTime,
                                                          // "6:00 PM ",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .accentText,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 11,
                                                          ),
                                                        ),
                                                      ),
                                                    ])),
                                          ],
                                        ),
                                        //100467541263
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                margin: EdgeInsets.only(top: 5),
                                                child: Image.asset(
                                                  "assets/location@3x.png",
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                                height: 55,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    80,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          event
                                                              .title, //event.location.isEmpty ? "N/A":event.location,
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
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          event.location.isEmpty
                                                              ? "N/A"
                                                              : event
                                                                  .location, //"11 Polson St, Toronto, ON M5A 1A4, Canada",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .accentText,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 11,
                                                          ),
                                                        ),
                                                      ),
                                                    ])),
                                          ],
                                        ),

                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                width: 20,
                                                height: 20,
                                                margin: EdgeInsets.only(top: 5),
                                                child: Image.asset(
                                                  "assets/profile@3x.png",
                                                  height: 20,
                                                  width: 20,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    80,
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          "Who’s Going?",
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
                                                      Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          event
                                                              .whoIsGointToString,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .accentText,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 11,
                                                          ),
                                                        ),
                                                      ),
                                                    ])),
                                          ],
                                        ),

                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                120,
                                            height: 50,
                                            margin: EdgeInsets.only(
                                                top: 30, right: 20),
                                            child: PinkButtonButton(
                                              padding: EdgeInsets.all(0),
                                              onPressed: () => this
                                                  .onCheckInPressed(context),
                                              child: Text(
                                                "CHECK IN",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Container(
                                          // margin: EdgeInsets.only(top:10),
                                          height: 1,
                                          margin: EdgeInsets.only(
                                              left: 1, right: 4, top: 20),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 187, 187, 187),
                                          ),
                                          child: Container(),
                                        ),

                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            margin: EdgeInsets.only(top: 14),
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
                                              EdgeInsets.only(left: 1, top: 15),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Container(
                                                width: 100,
                                                margin: EdgeInsets.only(
                                                    top: 3, bottom: 1),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Text(
                                                        event.user_name,
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
                                                      child: Text(
                                                        "Generated",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          color: AppColors
                                                              .accentText,
                                                          fontFamily: "Muli",
                                                          fontWeight:
                                                              FontWeight.w700,
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
                                                  width: 25,
                                                  height: 35,
                                                  margin: EdgeInsets.only(
                                                      right: 18),
                                                  child: Image.asset(
                                                    "assets/user@3x.png",
                                                    // fit: BoxFit.none,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Container(
                                          // margin: EdgeInsets.only(top:10),
                                          height: 1,
                                          margin: EdgeInsets.only(
                                              left: 1, right: 4, top: 20),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                255, 187, 187, 187),
                                          ),
                                          child: Container(),
                                        ),
                                        event.otherTime1.isEmpty == true
                                            ? Container()
                                            : Container(
                                                height: 125,
                                                margin: EdgeInsets.only(
                                                    left: 0,
                                                    top: 15,
                                                    right: 16),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: 1),
                                                        child: Text(
                                                          "Other Times",
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .primaryText,
                                                            fontFamily: "Muli",
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 21,
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    Container(
                                                      height: 30,
                                                      margin: EdgeInsets.only(
                                                          left: 5, top: 10),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                150,
                                                            height: 30,
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width: 6,
                                                                  height: 6,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColors
                                                                        .secondaryElement,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width:
                                                                          1.5,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          25,
                                                                          39,
                                                                          240),
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(3)),
                                                                  ),
                                                                  child:
                                                                      Container(),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                10),
                                                                    child: Text(
                                                                      event.otherTime1
                                                                              .isEmpty
                                                                          ? "N/A"
                                                                          : event
                                                                              .otherTime1,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppColors
                                                                            .primaryText,
                                                                        fontFamily:
                                                                            "Muli",
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                        fontSize:
                                                                            13,
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
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .secondaryElement,
                                                              border:
                                                                  Border.all(
                                                                width: 1.5,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        1,
                                                                        126),
                                                              ),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "VIEW",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            1,
                                                                            126),
                                                                    fontFamily:
                                                                        "Muli",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        11,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    Container(
                                                      height: 30,
                                                      margin: EdgeInsets.only(
                                                          left: 5, top: 0),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width -
                                                                150,
                                                            height: 30,
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width: 6,
                                                                  height: 6,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColors
                                                                        .secondaryElement,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      width:
                                                                          1.5,
                                                                      color: Color.fromARGB(
                                                                          255,
                                                                          25,
                                                                          39,
                                                                          240),
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(3)),
                                                                  ),
                                                                  child:
                                                                      Container(),
                                                                ),
                                                                Expanded(
                                                                  flex: 1,
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                10),
                                                                    child: Text(
                                                                      event.otherTime2
                                                                              .isEmpty
                                                                          ? "N/A"
                                                                          : event
                                                                              .otherTime2, // "Saturday, September 21, 8:00 PM",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppColors
                                                                            .primaryText,
                                                                        fontFamily:
                                                                            "Muli",
                                                                        fontWeight:
                                                                            FontWeight.w800,
                                                                        fontSize:
                                                                            13,
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
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .secondaryElement,
                                                              border:
                                                                  Border.all(
                                                                width: 1.5,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        255,
                                                                        1,
                                                                        126),
                                                              ),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                            ),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  "VIEW",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            255,
                                                                            1,
                                                                            126),
                                                                    fontFamily:
                                                                        "Muli",
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w800,
                                                                    fontSize:
                                                                        11,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                    // Spacer(),
                                                    // Container(
                                                    //   height: 100,
                                                    //   margin: EdgeInsets.only(right: 2, bottom: 1),
                                                    //   decoration: BoxDecoration(
                                                    //     color: Color.fromARGB(255, 187, 187, 187),
                                                    //   ),
                                                    //   child: Container(),
                                                    // ),
                                                  ],
                                                ),
                                              ),

                                        Container(
                                          // height: 400,
                                          margin: EdgeInsets.only(
                                              left: 0, top: 0, right: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Description",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryText,
                                                    fontFamily: "Muli",
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 21,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Container(
                                                  // width: 294,
                                                  height: 16,
                                                  margin: EdgeInsets.only(
                                                      left: 4, top: 5),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: 6,
                                                        height: 6,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: AppColors
                                                              .secondaryElement,
                                                          border: Border.all(
                                                            width: 1.5,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    25,
                                                                    39,
                                                                    240),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          3)),
                                                        ),
                                                        child: Container(),
                                                      ),
                                                      Expanded(
                                                        flex: 1,
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 13),
                                                          child: Text(
                                                            event.wantToMeetString +
                                                                ' ' +
                                                                event
                                                                    .generationIdentifyString, //"Men, Women, LGBTQ, iGen, Millennial, Gen X",
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
                                              Container(
                                                margin: EdgeInsets.only(
                                                    left: 2, top: 10),
                                                child: Text(
                                                  event.description,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryText,
                                                    fontFamily: "Muli",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11,
                                                    height: 1.27273,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // height: 200,
                                                child: new Wrap(
                                                  spacing: 10.0,
                                                  children: new List.generate(
                                                      this
                                                          .event
                                                          .interest
                                                          .length,
                                                      (index) => Container(
                                                            child:
                                                                GestureDetector(
                                                              child: Chip(
                                                                label: new Text(
                                                                  this
                                                                      .event
                                                                      .interest[
                                                                          index]
                                                                      .title,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontFamily:
                                                                          'Muli'),
                                                                ),
                                                                backgroundColor:
                                                                    SmartUtils
                                                                        .themeGrayColor,
                                                              ),
                                                            ),
                                                          )),
                                                ),
                                              ),

// Spacer(),)
                                              GestureDetector(
                                                onTap: () => {
                                                  this.openMap(event.latitude,
                                                      event.longitude)
                                                },
                                                child: Container(
                                                  height: 229,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  margin: EdgeInsets.only(
                                                      top: 17, right: 0),
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        child: GoogleMap(
                                                          mapType:
                                                              MapType.normal,
                                                          myLocationButtonEnabled:
                                                              false,
                                                          myLocationEnabled:
                                                              false,
                                                          initialCameraPosition:
                                                              CameraPosition(
                                                            target: LatLng(
                                                                lat ?? 0,
                                                                long ?? 0),
                                                            zoom: 14.4746,
                                                          ),
                                                          onMapCreated:
                                                              (GoogleMapController
                                                                  controller) {
                                                            controller
                                                                .setMapStyle(
                                                                    _mapStyle);
                                                            _controller
                                                                .complete(
                                                                    controller);
                                                          },
                                                          markers: _markers,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // Align(
                                              //   alignment: Alignment.topLeft,
                                              //   child: Container(
                                              //     width: 260,
                                              //     height: 30,
                                              //     margin: EdgeInsets.only(top: 16),
                                              //     child: Row(
                                              //       children: [
                                              //         Container(
                                              //           width: 111,
                                              //           height: 30,
                                              //           decoration: BoxDecoration(
                                              //             color: AppColors.primaryElement,
                                              //             borderRadius: BorderRadius.all(Radius.circular(15)),
                                              //           ),
                                              //           child: Column(
                                              //             mainAxisAlignment: MainAxisAlignment.center,
                                              //             crossAxisAlignment: CrossAxisAlignment.stretch,
                                              //             children: [
                                              //               Container(
                                              //                 margin: EdgeInsets.only(left: 10, right: 11),
                                              //                 child: Text(
                                              //                   "Entertainment",
                                              //                   textAlign: TextAlign.center,
                                              //                   style: TextStyle(
                                              //                     color: AppColors.primaryText,
                                              //                     fontFamily: "Muli",
                                              //                     fontWeight: FontWeight.w700,
                                              //                     fontSize: 13,
                                              //                   ),
                                              //                 ),
                                              //               ),
                                              //             ],
                                              //           ),
                                              //         ),
                                              //         Spacer(),
                                              //         Container(
                                              //           width: 75,
                                              //           height: 30,
                                              //           margin: EdgeInsets.only(right: 7),
                                              //           decoration: BoxDecoration(
                                              //             color: AppColors.primaryElement,
                                              //             borderRadius: BorderRadius.all(Radius.circular(15)),
                                              //           ),
                                              //           child: Column(
                                              //             mainAxisAlignment: MainAxisAlignment.center,
                                              //             crossAxisAlignment: CrossAxisAlignment.stretch,
                                              //             children: [
                                              //               Container(
                                              //                 margin: EdgeInsets.symmetric(horizontal: 13),
                                              //                 child: Text(
                                              //                   "Fashion",
                                              //                   textAlign: TextAlign.center,
                                              //                   style: TextStyle(
                                              //                     color: AppColors.primaryText,
                                              //                     fontFamily: "Muli",
                                              //                     fontWeight: FontWeight.w700,
                                              //                     fontSize: 13,
                                              //                   ),
                                              //                 ),
                                              //               ),
                                              //             ],
                                              //           ),
                                              //         ),
                                              //         Container(
                                              //           width: 60,
                                              //           height: 30,
                                              //           decoration: BoxDecoration(
                                              //             color: AppColors.primaryElement,
                                              //             borderRadius: BorderRadius.all(Radius.circular(15)),
                                              //           ),
                                              //           child: Column(
                                              //             mainAxisAlignment: MainAxisAlignment.center,
                                              //             crossAxisAlignment: CrossAxisAlignment.stretch,
                                              //             children: [
                                              //               Container(
                                              //                 margin: EdgeInsets.symmetric(horizontal: 16),
                                              //                 child: Text(
                                              //                   "Arts",
                                              //                   textAlign: TextAlign.center,
                                              //                   style: TextStyle(
                                              //                     color: AppColors.primaryText,
                                              //                     fontFamily: "Muli",
                                              //                     fontWeight: FontWeight.w700,
                                              //                     fontSize: 13,
                                              //                   ),
                                              //                 ),
                                              //               ),
                                              //             ],
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                              // Spacer(),
                                              // Container(
                                              //   height: 180,
                                              //   margin: EdgeInsets.only(left: 2),
                                              //   child: Image.asset(
                                              //     "assets/rectangle-5.png",
                                              //     fit: BoxFit.cover,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(height: 61)

                                        // Spacer(),
                                        // Align(
                                        //   alignment: Alignment.topCenter,
                                        //   child: Container(
                                        //     width: 134,
                                        //     height: 5,
                                        //     decoration: BoxDecoration(
                                        //       color: AppColors.accentElement,
                                        //       borderRadius: BorderRadius.all(Radius.circular(2.5)),
                                        //     ),
                                        //     child: Container(),
                                        //   ),
                                        // ),

                                        // Container(
                                        // height: 391,
                                        // margin: EdgeInsets.only(left: 0, top: 0, right: 15),
                                        // child: Column(
                                        //   crossAxisAlignment: CrossAxisAlignment.stretch,
                                        //   children: [
                                        //     Align(
                                        //       alignment: Alignment.topLeft,
                                        //       child: Text(
                                        //         "Description",
                                        //         textAlign: TextAlign.left,
                                        //         style: TextStyle(
                                        //           color: AppColors.primaryText,
                                        //           fontFamily: "Muli",
                                        //           fontWeight: FontWeight.w800,
                                        //           fontSize: 21,
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     Align(
                                        //       alignment: Alignment.topLeft,
                                        //       child: Container(
                                        //         width: 294,
                                        //         height: 16,
                                        //         margin: EdgeInsets.only(left: 4, top: 5),
                                        //         child: Row(
                                        //           children: [
                                        //             Container(
                                        //               width: 6,
                                        //               height: 6,
                                        //               decoration: BoxDecoration(
                                        //                 color: AppColors.secondaryElement,
                                        //                 border: Border.all(
                                        //                   width: 1.5,
                                        //                   color: Color.fromARGB(255, 25, 39, 240),
                                        //                 ),
                                        //                 borderRadius: BorderRadius.all(Radius.circular(3)),
                                        //               ),
                                        //               child: Container(),
                                        //             ),
                                        //             Expanded(
                                        //               flex: 1,
                                        //               child: Container(
                                        //                 margin: EdgeInsets.only(left: 13),
                                        //                 child: Text(
                                        //                   "Men, Women, LGBTQ, iGen, Millennial, Gen X",
                                        //                   textAlign: TextAlign.left,
                                        //                   style: TextStyle(
                                        //                     color: AppColors.primaryText,
                                        //                     fontFamily: "Muli",
                                        //                     fontWeight: FontWeight.w700,
                                        //                     fontSize: 13,
                                        //                   ),
                                        //                 ),
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     ),

                                        //     Container(
                                        //       margin: EdgeInsets.only(left: 2, top: 10),
                                        //       child: Text(
                                        //         "Artists, Designers, Companies from different countries will present their collections on the Social Impact concept in order to explain how the fashion industry could be a powerful engine for the current society along the exhibition spaces for the people who decide to advertise during the event, where, apart the visibility, the presence of Influencers, Journalists and Photographers will do effort to present Artists, Fashion designers and Brands. ",
                                        //         textAlign: TextAlign.left,
                                        //         style: TextStyle(
                                        //           color: AppColors.primaryText,
                                        //           fontFamily: "Muli",
                                        //           fontWeight: FontWeight.w400,
                                        //           fontSize: 11,
                                        //           height: 1.27273,
                                        //         ),
                                        //       ),
                                        //     ),

                                        //       Align(
                                        //         alignment: Alignment.topLeft,
                                        //         child: Container(
                                        //           width: 260,
                                        //           height: 30,
                                        //           margin: EdgeInsets.only(top: 16),
                                        //           child: Row(
                                        //             children: [
                                        //               Container(
                                        //                 width: 111,
                                        //                 height: 30,
                                        //                 decoration: BoxDecoration(
                                        //                   color: AppColors.primaryElement,
                                        //                   borderRadius: BorderRadius.all(Radius.circular(15)),
                                        //                 ),
                                        //                 child: Column(
                                        //                   mainAxisAlignment: MainAxisAlignment.center,
                                        //                   crossAxisAlignment: CrossAxisAlignment.stretch,
                                        //                   children: [
                                        //                     Container(
                                        //                       margin: EdgeInsets.only(left: 10, right: 11),
                                        //                       child: Text(
                                        //                         "Entertainment",
                                        //                         textAlign: TextAlign.center,
                                        //                         style: TextStyle(
                                        //                           color: AppColors.primaryText,
                                        //                           fontFamily: "Muli",
                                        //                           fontWeight: FontWeight.w700,
                                        //                           fontSize: 13,
                                        //                         ),
                                        //                       ),
                                        //                     ),
                                        //                   ],
                                        //                 ),
                                        //               ),
                                        //               Spacer(),
                                        //               Container(
                                        //                 width: 75,
                                        //                 height: 30,
                                        //                 margin: EdgeInsets.only(right: 7),
                                        //                 decoration: BoxDecoration(
                                        //                   color: AppColors.primaryElement,
                                        //                   borderRadius: BorderRadius.all(Radius.circular(15)),
                                        //                 ),
                                        //                 child: Column(
                                        //                   mainAxisAlignment: MainAxisAlignment.center,
                                        //                   crossAxisAlignment: CrossAxisAlignment.stretch,
                                        //                   children: [
                                        //                     Container(
                                        //                       margin: EdgeInsets.symmetric(horizontal: 13),
                                        //                       child: Text(
                                        //                         "Fashion",
                                        //                         textAlign: TextAlign.center,
                                        //                         style: TextStyle(
                                        //                           color: AppColors.primaryText,
                                        //                           fontFamily: "Muli",
                                        //                           fontWeight: FontWeight.w700,
                                        //                           fontSize: 13,
                                        //                         ),
                                        //                       ),
                                        //                     ),
                                        //                   ],
                                        //                 ),
                                        //               ),

                                        //  ],
                                        //  ),
                                        // ),
                                      ],
                                    ),
                                  ])),
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
    );
  }

  Widget showCheckinView() {
    return Container(
      height: 600,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 600,
            decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Container(),
          ),
          Container(
            // color: Colors.white,
            // top: 287,
            // bottom: 9,
            margin: EdgeInsets.only(top: 40, bottom: 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "Check-In",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.w700,
                      fontSize: 19,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 7),
                    child: Text(
                      event.title, //"Ditch Fashion Show",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: "Muli",
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    // width: 301,
                    margin: EdgeInsets.only(top: 7, left: 30, right: 30),
                    child: Text(
                      "Check-in to find your friends. You can leave at anytime, but at least come say Hi! \n\nAfterwards, decide who to meet again, and don’t worry you’ll never be matched with somone you didn’t like twice.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: "Muli",
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.2,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 42,
                    height: 61,
                    margin: EdgeInsets.only(top: 28),
                    child: Image.asset(
                      "assets/airbaloon.png",
                      fit: BoxFit.none,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    // width: 301,
                    width: MediaQuery.of(context).size.width - 20,
                    height: 170,
                    margin: EdgeInsets.only(top: 41, left: 10, right: 10),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width - 60,
                          // width: 301,
                          // left: 0,
                          // right: 0,
                          margin: EdgeInsets.only(left: 30, right: 30),
                          child: GreyButtonFullWidthButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () => this.onSnoozePressed(context),
                            child: Text(
                              "Snooze",
                              textAlign: TextAlign.center,
                              style: TextStyle(),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          right: 0,
                          bottom: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 50,
                                    margin: EdgeInsets.only(
                                        left: 30, right: 30, top: 0),
                                    child: AnimatedContainer(
                                      duration: Duration(seconds: 5),
                                      width: animationWidth,
                                      height: 50,
                                      color: SmartUtils
                                          .blueBackground, //Color(0xff14ff65),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    margin: EdgeInsets.only(
                                        left: 30, right: 30, top: 0),
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    child: VioletButtonButton(
                                      color: pressAttention
                                          ? SmartUtils.blueBackground
                                          : Color.fromARGB(53, 25, 39, 240),
                                      padding: EdgeInsets.all(0),
                                      onPressed: () => {
                                        // pressAttention = !pressAttention,

                                        this.callEventCheckinApi()

                                        //  new Future.delayed(new Duration(seconds: 1), () {
                                        //  }),
                                      }, //this.onCheckinButtonPressed(context),
                                      child: Text(
                                        "Press & Hold to Check In",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width - 60,
                                margin: EdgeInsets.only(left: 30, right: 30),
                                child: GreyButtonFullWidthButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () =>
                                      this.onCancelRSVPPressed(context),
                                  child: Text(
                                    "Cancel RSVP",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
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
                Spacer(),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 134,
                    height: 5,
                    decoration: BoxDecoration(
                      color: AppColors.accentElement,
                      borderRadius: BorderRadius.all(Radius.circular(2.5)),
                    ),
                    child: Container(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _centerLoading() {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          new Center(
            child: new CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
            ),
          )
        ],
      ),
    );
  }

  callEventCheckinApi() async {
    //TODO : CALL Register Api Here

    CheckInRequest request;
    request = CheckInRequest();
    request.eventId = this.event.event_id;

    CheckInEventListResponse responseBusiness =
        await ApiProvider().callCheckEventList(params: request);

    print(responseBusiness);
    if (responseBusiness.status == true) {
      String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
      preferences.setString("startTime", date);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GroupFinderChat(
                    event: this.event,
                  )));

      //  Navigator.of(context).pushAndRemoveUntil(
      //                         MaterialPageRoute(builder: (_) => MainTabView()),
      //                        (Route<dynamic> route) => false);
      // DateTime.now();

    } else {
      Navigator.of(context).pop();

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

  Future<void> changeLocationORShowLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat ?? 0, long ?? 0),
      zoom: 14.4746,
    )));
  }
}
