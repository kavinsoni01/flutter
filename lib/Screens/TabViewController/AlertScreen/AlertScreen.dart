import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simposi/Screens/CreateEventScreens/MeetNowViewScreen.dart';
import 'package:simposi/Screens/ProfileScreen/ProfileScreen.dart';
import 'package:simposi/Screens/TabViewController/AlertScreen/AlertNewTimeSuggetion.dart';
import 'package:simposi/Screens/TabViewController/AlertScreen/AlertNotificationConnect.dart';
import 'package:simposi/Screens/TabViewController/AlertScreen/AlertSettingScreens.dart';
import 'package:simposi/Screens/TabViewController/AlertScreen/violet_button.dart';
import 'package:simposi/Screens/TabViewController/GroupFinderChat.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/Utility/Values/grey_button_full_width.dart';
import 'package:simposi/Utils/smartutils.dart';

class AlertScreen extends StatefulWidget {
  @override
  _AlertScreenState createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  NotificationListResponse _dashboardNotificationList;

  var selectedIndex = 0;

  void onMeetNowPressed(BuildContext context) {
    checkFreeEvent();
  }

  void onSettingsPressed(BuildContext context) {
    //_AlertSettingState
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AlertSetting()));
  }

  void onSnoozePressed(BuildContext context) {}

  void onCancelRSVPPressed(BuildContext context) {}

  void onCheckinButtonPressed(BuildContext context) {
    //GroupFinderChat

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => GroupFinderChat()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final birthday = DateTime(1967, 10, 12);
    final date2 = DateTime.now();
    final difference = date2.difference(birthday).inDays;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        // argin: EdgeInsets.only(top:MediaQuery.of(context).padding.top),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 padding: EdgeInsets.all(10),
        // height: 70,

        child: Column(
          //         // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 51,
              margin: EdgeInsets.only(left: 15, top: 46, right: 16),
              // margin: EdgeInsets.only(left: 15, top: 55, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "Alerts",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: "Muli",
                        fontWeight: FontWeight.w800,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AlertSetting())),
                          //
                        },
                        child: Image.asset(
                          "assets/settings.png",
                          height: 30,
                          width: 30,
                        ),
                      )),
                ],
              ),
            ),

            Container(
              height: 40,
              margin: EdgeInsets.only(top: 2),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 243, 243),
              ),
              child: Row(
                children: [
                  // Spacer(),

                  GestureDetector(
                    onTap: () => {
                      selectedIndex = 0,
                      setState(() {}),
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 18),
                      child: selectedIndex == 0
                          ? Text(
                              "All",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 48, 49, 50),
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            )
                          : Text(
                              "All",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 187, 187, 187),
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                    ),
                  ),

                  // Spacer(),
                  GestureDetector(
                    onTap: () => {
                      selectedIndex = 1,
                      setState(() {}),
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 30),
                      child: selectedIndex == 1
                          ? Text(
                              "Today",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 48, 49, 50),
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            )
                          : Text(
                              "Today",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 187, 187, 187),
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                    ),
                  ),
                  // Spacer(),

                  GestureDetector(
                    onTap: () => {
                      selectedIndex = 2,
                      setState(() {}),
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 30),
                      child: selectedIndex == 2
                          ? Text(
                              "This Week",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 48, 49, 50),
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            )
                          : Text(
                              "This Week",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 187, 187, 187),
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                    ),
                  ),
                  // Spacer(),

                  GestureDetector(
                    onTap: () => {
                      selectedIndex = 3,
                      setState(() {}),
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 45, left: 30),
                      child: selectedIndex == 3
                          ? Text(
                              "This Month",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 48, 49, 50),
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            )
                          : Text(
                              "This Month",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 187, 187, 187),
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ),

            setAlertData(), //setEmptyView(),//
          ],
        ),
      ),
    );
  }

  Widget setAlertData() {
    return Container(
      height: MediaQuery.of(context).size.height - 192 - 29,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Container(
              child: //this. expandableTheme()

                  FutureBuilder(
                      future: this.callAlertViewApi(),
                      builder: (context, data) {
                        switch (data.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.pink,
                              ),
                            );
                          case ConnectionState.done:
                            if (data.hasError) {
                              return Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.pink,
                                ),
                              );
                            } else {
                              _dashboardNotificationList = data.data;
                              if (data.hasData) {
                                return _dashboardNotificationList
                                        .status // ? setEmptyView()
                                    ? showNotificationView()
                                    : setEmptyView();
                              } else {
                                return setEmptyView();
                              }
                            }
                        }
                      }),
            ),
          ),
        ],
      ),
    );
  }

  callAlertViewApi() async {
    NotificationListRequest request = new NotificationListRequest();
    request.languageId = 1;
    request.duration = selectedIndex + 1;
/*
duration
1 -All
2 -last month
3 -lastweek
4 -today
*/
    if (selectedIndex == 0) {
      request.start_date = "";
      request.end_date = "";
    } else if (selectedIndex == 1) {
      // "2020-07-09 00:00:00",
      var now = new DateTime.now();
      var lastmonth = now.subtract(new Duration(days: 30));

      String startTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      String endTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(lastmonth);
      request.start_date = startTime;
      request.end_date = endTime;
    } else if (selectedIndex == 2) {
      // "2020-07-09 00:00:00",
      var now = new DateTime.now();
      var lastmonth = now.subtract(new Duration(days: 7));

      String startTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      String endTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(lastmonth);
      request.start_date = startTime;
      request.end_date = endTime;
    } else if (selectedIndex == 3) {
      // "2020-07-09 00:00:00",
      var now = new DateTime.now();
      var lastmonth = now.subtract(new Duration(days: 1));

      String startTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
      String endTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(lastmonth);
      request.start_date = startTime;
      request.end_date = endTime;
    }
    NotificationListResponse responseBusiness =
        await ApiProvider().callNotificationListApi(params: request);

    print(responseBusiness);
    if (responseBusiness.status == true) {}

    return responseBusiness;
  }

  callReadBadgeAPI() async {
    NotificationListRequest request = new NotificationListRequest();
    request.languageId = 1;
    NotificationListResponse responseBusiness =
        await ApiProvider().callNotificationListApi(params: request);

    print(responseBusiness);
    if (responseBusiness.status == true) {}

    return responseBusiness;
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
                      "Ditch Fashion Show",
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
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(left: 30, right: 30),
                                width: MediaQuery.of(context).size.width - 60,
                                child: VioletButtonButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () =>
                                      this.onCheckinButtonPressed(context),
                                  child: Text(
                                    "Press & Hold to Check In",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                  ),
                                ),
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

  Widget showNotificationView() {
    return new MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Container(
        margin: EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            178,
        // color: AppColors.lightGrayBackground,
        child: ListView.builder(
            itemCount: _dashboardNotificationList.notifications.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return new InkWell(
                  child: buildRow(index),
                  onTap: () async {
                    // selectedCard = index;
                    // isPush = true;

                    if (_dashboardNotificationList.notifications[index].type ==
                        "Event Details notification list") {
                    } else if (_dashboardNotificationList
                            .notifications[index].type ==
                        "New Time Proposed list") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlertNewTimeSuggetion(
                                    notification: _dashboardNotificationList
                                        .notifications[index],
                                  )));
                    } else if (_dashboardNotificationList
                            .notifications[index].type ==
                        "Event Cancellation list") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlertNewTimeSuggetion(
                                    notification: _dashboardNotificationList
                                        .notifications[index],
                                  )));
                    } else if (_dashboardNotificationList
                            .notifications[index].type ==
                        "Event Feedback list") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlertNewTimeSuggetion(
                                    notification: _dashboardNotificationList
                                        .notifications[index],
                                  )));
                    } else if (_dashboardNotificationList
                            .notifications[index].type ==
                        "Event Create Notification") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlertNewTimeSuggetion(
                                    notification: _dashboardNotificationList
                                        .notifications[index],
                                  )));
                    } else if (_dashboardNotificationList
                            .notifications[index].type ==
                        "Event Update Suggested Time") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlertNewTimeSuggetion(
                                    notification: _dashboardNotificationList
                                        .notifications[index],
                                  )));
                    } else if (_dashboardNotificationList
                            .notifications[index].type ==
                        "Reminder before event start") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlertNewTimeSuggetion(
                                    notification: _dashboardNotificationList
                                        .notifications[index],
                                  )));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AlertNotificationConnect(
                                    notification: _dashboardNotificationList
                                        .notifications[index],
                                  )));
                    }
                    /*   
      showModalBottomSheet(

      context: context,
      clipBehavior: Clip.hardEdge,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,

      builder: (BuildContext bc){
        return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(          
            color: Colors.transparent,
            child:
            
             new Wrap(
            children: <Widget>[
                         showCheckinView()
            ],
          ),
        ),
          );
      }//
    );*/
                  });
            }),
      ),
    );
  }

  Widget buildRow(
    int index,
  ) {
    return Container(
      height: 78,
      margin: EdgeInsets.only(left: 12, top: 10, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 19,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 6,
                    height: 6,
                    margin: EdgeInsets.only(top: 6),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 1, 126),
                      border: Border.all(
                        width: 1.5,
                        color: Color.fromARGB(255, 255, 1, 126),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                    child: Container(),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: 13),
                    child: Text(
                      _dashboardNotificationList.notifications[index].type,
                      // "Flora wants to Connect!",
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 1),
                    child: Text(
                      // "2h",
                      setDateDiffrence(_dashboardNotificationList
                          .notifications[index].created_at),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: AppColors.primaryText,
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
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 19, top: 2),
              child: Text(
                _dashboardNotificationList.notifications[index].title,
                // "Ditch Fashion Show",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Muli",
                  fontWeight: FontWeight.w800,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(left: 19, top: 3),
              child: Text(
                _dashboardNotificationList.notifications[index].description,
                // "Lorem ipsum dolor sit, consect eliy…",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.accentText,
                  fontFamily: "Muli",
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            height: 1,
            margin: EdgeInsets.only(left: 3, bottom: 1),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 187, 187, 187),
            ),
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget setEmptyView() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 248,
        height: 244,
        margin: EdgeInsets.only(top: 148),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 72,
                height: 82,
                child: Image.asset(
                  "assets/alerts-2.png",
                  fit: BoxFit.none,
                ),
              ),
            ),
            Container(
              height: 127,
              margin: EdgeInsets.only(top: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "No Notifications",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: "Muli",
                        fontWeight: FontWeight.w800,
                        fontSize: 19,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 1),
                    child: Text(
                      "Check back again or invite others to\nmeet instead",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.accentText,
                        fontFamily: "Muli",
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        height: 1.2,
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 130,
                      height: 40,
                      child: FlatButton(
                        onPressed: () => this.onMeetNowPressed(context),
                        color: Color.fromARGB(255, 255, 1, 126),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        textColor: Color.fromARGB(255, 255, 255, 255),
                        padding: EdgeInsets.all(0),
                        child: Text(
                          "Meet Now",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
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
    );
  }

  String setDateDiffrence(String date) {
    var newDateTimeObj2 = new DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(date);
    // var formatter = new DateFormat("MMM dd hh:mm a");
    // event_date = formatter.format(newDateTimeObj2);
    // final birthday = DateTime(1967, 10, 12);
    final date2 = DateTime.now();
    final difference = date2.difference(newDateTimeObj2).inDays;
    return difference.toString() + ' Days ago';
  }

  checkFreeEvent() async {
    //TODO : CALL Register Api Here

    FreeEventRequest request;
    request = FreeEventRequest();
    request.language_id = "1";

    FreeEventResponse responseBusiness =
        await ApiProvider().callFreeEventCheckApi(params: request);

    print(responseBusiness);
    if (responseBusiness.status == true) {
      if (responseBusiness.isAllow == 0) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MeetNowViewScreen()));
      } else {
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      }

      // if (mounted) {
      //   setState(() {});
      // }
      // DateTime.now();

    } else {
      SmartUtils.showErrorDialog(context, responseBusiness.message);
    }

    return responseBusiness;
  }
}

//   return Scaffold(
//     body: Container(
//       // constraints: BoxConstraints.expand(),
//       decoration: BoxDecoration(
//         color: Color.fromARGB(255, 255, 255, 255),
//       ),
//       child: Column(
//         // crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [

//  Container(
//             height: 38,
//             margin: EdgeInsets.only(left: 15, top: 46, right: 16),
//             // margin: EdgeInsets.only(left: 15, top: 55, right: 10),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                   Container(
//                         child: Text(
//                          "Alerts",
//                           textAlign: TextAlign.left,
//                           style: TextStyle(
//                             color: AppColors.primaryText,
//                             fontFamily: "Muli",
//                             fontWeight: FontWeight.w800,
//                             fontSize: 30,
//                           ),
//                         ),
//                       ),
//                 Spacer(),
//                 Container(
//                   width: 20,
//                   height: 20,
//                   margin: EdgeInsets.only(top: 13),
//                   child:
//                   GestureDetector(
//                     child:
//                         Image.asset("assets/settings.png",height: 20,width: 20,),
//                   )
//                 ),
//               ],
//             ),
//           ),

//           Container(
//             height: 40,
//             margin: EdgeInsets.only(top: 2),
//             decoration: BoxDecoration(
//               color: Color.fromARGB(255, 243, 243, 243),
//             ),
//             child: Row(
//               children: [
//                 // Spacer(),
//                 Container(
//                   margin: EdgeInsets.only(left: 18),
//                   child: Text(
//                     "All",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 48, 49, 50),
//                       fontFamily: "Muli",
//                       fontWeight: FontWeight.w800,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//                 // Spacer(),
//                 Container(
//                   margin: EdgeInsets.only(left: 30),
//                   child: Text(
//                     "Today",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 187, 187, 187),
//                       fontFamily: "Muli",
//                       fontWeight: FontWeight.w800,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//                 // Spacer(),
//                 Container(
//                   margin: EdgeInsets.only(left: 30),
//                   child: Text(
//                     "This Week",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 187, 187, 187),
//                       fontFamily: "Muli",
//                       fontWeight: FontWeight.w800,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//                 // Spacer(),
//                 Container(
//                   margin: EdgeInsets.only(right: 45, left: 30),
//                   child: Text(
//                     "This Month",
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       color: Color.fromARGB(255, 187, 187, 187),
//                       fontFamily: "Muli",
//                       fontWeight: FontWeight.w800,
//                       fontSize: 15,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.topCenter,
//             child: Container(
//               width: 248,
//               height: 244,
//               margin: EdgeInsets.only(top: 48),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Align(
//                     alignment: Alignment.topCenter,
//                     child: Container(
//                       width: 72,
//                       height: 82,
//                       child: Image.asset(
//                         "assets/alerts-2.png",
//                         fit: BoxFit.none,
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 127,
//                     margin: EdgeInsets.only(top: 35),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Align(
//                           alignment: Alignment.topCenter,
//                           child: Text(
//                           "No Notifications",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: AppColors.primaryText,
//                               fontFamily: "Muli",
//                               fontWeight: FontWeight.w800,
//                               fontSize: 19,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(top: 1),
//                           child: Text(
//                             "Check back again or invite others to\nmeet instead",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: AppColors.accentText,
//                               fontFamily: "Muli",
//                               fontWeight: FontWeight.w400,
//                               fontSize: 15,
//                               height: 1.2,
//                             ),
//                           ),
//                         ),
//                         Spacer(),
//                         Align(
//                           alignment: Alignment.topCenter,
//                           child: Container(
//                             width: 130,
//                             height: 40,
//                             child: FlatButton(
//                               onPressed: () => this.onMeetNowPressed(context),
//                               color: Color.fromARGB(255, 255, 1, 126),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.all(Radius.circular(20)),
//                               ),
//                               textColor: Color.fromARGB(255, 255, 255, 255),
//                               padding: EdgeInsets.all(0),
//                               child: Text(
//                                 "Meet Now",
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   color: AppColors.secondaryText,
//                                   fontFamily: "Muli",
//                                   fontWeight: FontWeight.w800,
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//         ],
//       ),
//     ),
//   );
// }
