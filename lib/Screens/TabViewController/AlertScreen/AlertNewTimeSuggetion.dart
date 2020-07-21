import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simposi/Screens/CreateEventScreens/EnterDateAndTime.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/Utility/Values/dark_grey_button.dart';
import 'package:simposi/Utils/Utility/Values/pink_button.dart';
import 'package:simposi/Utils/smartutils.dart';

class AlertNewTimeSuggetion extends StatefulWidget {
  final NotificationList notification;
  AlertNewTimeSuggetion({
    @required this.notification,
  });

  @override
  _AlertNewTimeSuggetionState createState() =>
      _AlertNewTimeSuggetionState(notification: this.notification);
}

class _AlertNewTimeSuggetionState extends State<AlertNewTimeSuggetion> {
  var selectedTime = 'Tuesday, Aug 13, 10:17 AM';

  final NotificationList notification;
  _AlertNewTimeSuggetionState({
    @required this.notification,
  });

  void onUpdateSocialPressed(BuildContext context) {
    callUpdateSuggestedTime();
  }

  void onApprovePressed(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: new Text("Create Activity"),
              content: new Text("Will you attend this social too?"),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () => {
                    Navigator.of(context).pop(),
                    callCreateAndAttendAPI(),
                    // _askPermissions()
                  },
                  isDefaultAction: true,
                  child: Text(
                    "Create & Attend",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 122, 255),
                      fontFamily: "Helvetica",
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      letterSpacing: -0.408,
                      height: 1.29412,
                    ),
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () => {
                    // Navigator.of(context).pop(),
                    //  callCheckInEventData(),
                    Navigator.of(context).pop(),
                    callDeclineEvent(),
                  },
                  child: Text(
                    "Not Going",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 122, 255),
                      fontFamily: "Helvetica",
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      letterSpacing: -0.408,
                      height: 1.29412,
                    ),
                  ),
                ),
                CupertinoDialogAction(
                  onPressed: () => {
                    Navigator.of(context).pop(),
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 122, 255),
                      fontFamily: "Helvetica",
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      letterSpacing: -0.408,
                      height: 1.29412,
                    ),
                  ),
                ),
                // event_check_in
              ],
            ));
  }

  void onDeclinePressed(BuildContext context) {
    callDeclineEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 35,
              margin: EdgeInsets.only(top: 53),
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                    color: Color.fromARGB(255, 25, 39, 240),
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
            Container(
              height: 99,
              margin: EdgeInsets.only(left: 15, top: 17, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 1),
                      child: Text(
                        "New Time Suggested",
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
                  Container(
                    height: 16,
                    margin: EdgeInsets.only(top: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            notification.title,
                            //"Ladies Brunch @ The Ritz",
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
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 1),
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
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 1),
                      child: Text(
                        "Approving this request will create another social at the \ntime suggested below. You may also cancel your original \nsocial and proceed with the suggested time instead.",
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
                ],
              ),
            ),
            Container(
              height: 51,
              margin: EdgeInsets.only(left: 15, top: 21, right: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: () => {pushSetDateAndTime()},
                    child: Positioned(
                      child: Text(
                        selectedTime, //"Tuesday, Aug 13, 10:17 AM",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 25, 39, 240),
                          fontFamily: "Helvetica",
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -1,
                    top: 0,
                    right: -1,
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 1,
                          margin: EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: AppColors.primaryElement,
                          ),
                          child: Container(),
                        ),
                        Spacer(),
                        Container(
                          height: 3,
                          child: Image.asset(
                            "assets/line-3.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 301,
                height: 165,
                margin: EdgeInsets.only(top: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(right: 1),
                      child: PinkButtonButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () => this.onApprovePressed(context),
                        child: Text(
                          "Approve & Create",
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        ),
                      ),
                    ),
                    // GestureDetector(
                    //   onTap: () => {
                    //     callUpdateSuggestedTime(),
                    //   },
                    //   child:
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 7, right: 1),
                      child: PinkButtonButton(
                        onPressed: () => this.onUpdateSocialPressed(context),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Update Social",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.secondaryText,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w800,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // ),
                    // GestureDetector(
                    //   onTap: () => {this.callDeclineEvent()
                    //   },
                    // child:
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(top: 8, right: 1),
                      child: DarkGreyButtonButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () => this.onDeclinePressed(context),
                        child: Text(
                          "Decline Proposed Time",
                          textAlign: TextAlign.center,
                          style: TextStyle(),
                        ),
                      ),
                    ),
                    // ),
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
                margin: EdgeInsets.only(bottom: 9),
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
    );
  }

  callUpdateSuggestedTime() async {
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

    UpdateSuggestionRequest request;
    request = UpdateSuggestionRequest();
    request.eventId = "68"; //this.notification.user_id.toString();

    var newDateTimeObj2 =
        new DateFormat("EEEE, MMM dd hh:mm a").parse(selectedTime);
    var formatter = new DateFormat("yyyy-MM-dd hh:mm a");
    var newTime = formatter.format(newDateTimeObj2);

    request.suggestedTime = newTime;

    AttendNotificationResponse responseBusiness =
        await ApiProvider().callUpdateSuggesionTime(params: request);

    Navigator.of(context).pop();

    new Future.delayed(new Duration(seconds: 1), () {
      print(responseBusiness);

      Navigator.of(context).pop();
      SmartUtils.showErrorDialog(context, responseBusiness.message);
    });
    return responseBusiness;
  }

  callCreateAndAttendAPI() async {
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

    CreateEventTimeRequest request;
    request = CreateEventTimeRequest();
    request.eventId = "68"; //this.notification.user_id.toString();
    request.notificationId = '1';

    AttendNotificationResponse responseBusiness =
        await ApiProvider().callInviteduserAprove(params: request);
    Navigator.of(context).pop();

    new Future.delayed(new Duration(seconds: 1), () {
      print(responseBusiness);

      Navigator.of(context).pop();
      SmartUtils.showErrorDialog(context, responseBusiness.message);
    });
    return responseBusiness;
  }

  callDeclineEvent() async {
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

    CreateEventTimeRequest request;
    request = CreateEventTimeRequest();
    request.eventId = "68"; //this.notification.user_id.toString();
    request.notificationId = '1';

    AttendNotificationResponse responseBusiness =
        await ApiProvider().callDeclineEventNotification(params: request);

    Navigator.of(context).pop();

    new Future.delayed(new Duration(seconds: 1), () {
      print(responseBusiness);

      Navigator.of(context).pop();
      SmartUtils.showErrorDialog(context, responseBusiness.message);
    });

    return responseBusiness;
  }

  Future<void> pushSetDateAndTime() async {
    FocusScope.of(context).unfocus();

    var strData = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EnterDateAndTimeScreen()));
    if (strData != null) {
      var newStr = strData;
      // this.selectedDateAndTime = formatter.format(selectedDate);
      // var formatter = new DateFormat("yyyy-MM-dd hh:mm a");
      var newDateTimeObj2 = new DateFormat("yyyy-MM-dd hh:mm a").parse(newStr);
      var formatter = new DateFormat("EEEE, MMM dd hh:mm a");
      this.selectedTime = formatter.format(newDateTimeObj2);

      // selectedTime = newStr;

      if (mounted) {
        setState(() {});
      }
    }
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
}
