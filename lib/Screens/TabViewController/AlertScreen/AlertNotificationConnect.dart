import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simposi/Screens/TabViewController/MeetAgainScreens/MeetAgainScreen.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/Utility/Values/dark_grey_button.dart';

class AlertNotificationConnect extends StatefulWidget {
  final NotificationList notification;
  AlertNotificationConnect({
    @required this.notification,
  });

  @override
  _AlertNotificationConnectState createState() =>
      _AlertNotificationConnectState(notification: this.notification);
}

class _AlertNotificationConnectState extends State<AlertNotificationConnect> {
  // final EventList event;
  // _AlertNotificationConnectState({
  //   @required this.event,
  // });

  final NotificationList notification;
  _AlertNotificationConnectState({
    @required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height, //+ 100 ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 78,
                margin: EdgeInsets.only(top: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 43),
                      // left: 0,
                      // top: 43,
                      // right: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () => {
                              Navigator.of(context).pop(),
                            },
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                width: 67,
                                height: 21,
                                margin: EdgeInsets.only(left: 18),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        width: 9,
                                        height: 17,
                                        margin: EdgeInsets.only(top: 3),
                                        child: Image.asset(
                                          "assets/left-arrow.png",
                                          fit: BoxFit.none,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 11),
                                        child: Text(
                                          "Alerts",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 25, 39, 240),
                                            fontFamily: "Muli",
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 1,
                            decoration: BoxDecoration(
                              color: AppColors.primaryElement,
                            ),
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                    // Positioned(
                    //   left: 10,
                    //   top: 0,
                    //   child: Image.asset(
                    //     "",
                    //     fit: BoxFit.none,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                height: 41,
                margin: EdgeInsets.only(left: 15, top: 17, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 1),
                        child: Text(
                          notification.user_name + " wants to connect!",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      height: 16,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              notification.title, // "Ditch Fashion Show",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Spacer(),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "May 16 1:55 PM",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: Color.fromARGB(255, 216, 216, 216),
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
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
                  height: 326,
                  margin: EdgeInsets.only(top: 15),
                  child: Image.network(
                    notification.profile_photo,
                    // "assets/rectangle-6.png",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )
                  // child: Image.asset(
                  //   "assets/rectangle-6.png",
                  //   fit: BoxFit.cover,
                  // ),
                  ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 287,
                  height: 48,
                  margin: EdgeInsets.only(top: 9),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "You ❤️ each other",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.w800,
                            fontSize: 19,
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Flora shared her contact details with you!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 173,
                  height: 41,
                  margin: EdgeInsets.only(top: 27),
                  child: Image.asset(
                    "assets/social-media-icons.png",
                    fit: BoxFit.none,
                  ),
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(bottom: 22),
                  child: Text(
                    "Do you want to share contact details \nwith this person?",
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
                  width: 300,
                  height: 50,
                  margin: EdgeInsets.only(bottom: 49),
                  child: DarkGreyButtonButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () => this.onMyDetailsPressed(context),
                    child: Text(
                      "Share My Details ",
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  void onMyDetailsPressed(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MeetAgainScreen(
                  notification: notification,
                )));

    //MeetAgainScreen
  }
}
