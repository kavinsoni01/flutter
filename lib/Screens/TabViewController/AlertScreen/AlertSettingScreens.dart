import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/smartutils.dart';

class AlertSetting extends StatefulWidget {
  @override
  _AlertSettingState createState() => _AlertSettingState();
}

class _AlertSettingState extends State<AlertSetting> {
  bool isUserGeneratedEvent = true;
  bool chatNotification = true;
  bool isMachineGeneratedEvent = true;
  bool isRSVP = true;
  bool checkInNotification = true;
  bool newProposedTime = true;
  SharedPreferences preferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  void _init() async {
    preferences = await SharedPreferences.getInstance();

    var userInt = preferences.getInt('chats_notifications');
    isUserGeneratedEvent = userInt == 0 ? false : true;

    var chatInt = preferences.getInt('chats_notifications');
    chatNotification = chatInt == 0 ? false : true;

    var machine = preferences.getInt('machine_generate_event');
    isMachineGeneratedEvent = machine == 0 ? false : true;

    var rsvpInt = preferences.getInt('RSVP');
    isRSVP = rsvpInt == 0 ? false : true;

    var checkInt = preferences.getInt('check_in_notifications');
    checkInNotification = checkInt == 0 ? false : true;

    var timeInt = preferences.getInt('new_time_proposed');
    newProposedTime = timeInt == 0 ? false : true;

    if (mounted) {
      setState(() {});
    }
  }

  void onSwitchesValueChanged(BuildContext context) {
    isUserGeneratedEvent = !isUserGeneratedEvent;
  }

  void onSwitchesTwoValueChanged(BuildContext context) {
    isMachineGeneratedEvent = !isMachineGeneratedEvent;
  }

  void onSwitchesThreeValueChanged(BuildContext context) {
    isRSVP = !isRSVP;
  }

  void onSwitchesFourValueChanged(BuildContext context) {
    checkInNotification = !checkInNotification;
  }

  void onSwitchesFiveValueChanged(BuildContext context) {
    chatNotification = !chatNotification;
  }

  void onSwitchesSixValueChanged(BuildContext context) {
    newProposedTime = !newProposedTime;
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
            Align(
              alignment: Alignment.topRight,
              child: Container(
                // width: 232,
                height: 21,
                margin: EdgeInsets.only(top: 53, right: 13),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //  Expanded(
                    //    flex: 8,
                    //    child:

                    //  ),
                    // Spacer(),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () => {
                          callAlertSettingsAPI()
                          //  Navigator.pop(context, 'Back');
                        },
                        child: Text(
                          "Done",
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
            Text(
              "Alert Settings",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primaryText,
                fontFamily: "Muli",
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: 13),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 725,
                        decoration: BoxDecoration(
                          color: AppColors.ternaryBackground,
                        ),
                        child: Container(),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 28,
                      right: 0,
                      bottom: 9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 352,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 16),
                                    child: Text(
                                      "NOTIFICATIONS",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 187, 187, 187),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 332,
                                  margin: EdgeInsets.only(top: 4),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          height: 331,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryBackground,
                                          ),
                                          child: Container(),
                                        ),
                                      ),
                                      Positioned(
                                        left: 16,
                                        top: 12,
                                        right: 15,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Container(
                                              height: 44,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Container(
                                                    height: 31,
                                                    margin: EdgeInsets.only(
                                                        right: 1),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 8),
                                                            child: Text(
                                                              "User generated events",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .primaryText,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                            width: 51,
                                                            height: 31,
                                                            child:
                                                                Switch.adaptive(
                                                              value:
                                                                  isUserGeneratedEvent,
                                                              inactiveTrackColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          60,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              onChanged:
                                                                  (value) {
                                                                isUserGeneratedEvent =
                                                                    !isUserGeneratedEvent;
                                                                setState(() {});
                                                              },
                                                              activeColor: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      37,
                                                                      70,
                                                                      240),
                                                              activeTrackColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          243,
                                                                          243),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    height: 3,
                                                    child: Image.asset(
                                                      "assets/line-6.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 44,
                                              margin: EdgeInsets.only(top: 11),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Container(
                                                    height: 31,
                                                    margin: EdgeInsets.only(
                                                        right: 1),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 8),
                                                            child: Text(
                                                              "Machine generated events",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .primaryText,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                            width: 51,
                                                            height: 31,
                                                            child:

                                                                //     :CustomSwitchButton(
                                                                //     backgroundColor: Colors.blueGrey,
                                                                //     unCheckedColor: Colors.white,
                                                                //     animationDuration: Duration(milliseconds: 400),
                                                                //     checkedColor: Colors.lightGreen,
                                                                //          checked: isChecked,
                                                                //    ),
                                                                // ),
                                                                Switch.adaptive(
                                                              value:
                                                                  isMachineGeneratedEvent,
                                                              inactiveTrackColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          60,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              onChanged:
                                                                  (value) {
                                                                isMachineGeneratedEvent =
                                                                    !isMachineGeneratedEvent;
                                                                setState(() {});
                                                              },
                                                              activeColor: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      37,
                                                                      70,
                                                                      240),
                                                              activeTrackColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          243,
                                                                          243),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    height: 3,
                                                    child: Image.asset(
                                                      "assets/line-6.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 44,
                                              margin: EdgeInsets.only(top: 11),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Container(
                                                    height: 31,
                                                    margin: EdgeInsets.only(
                                                        right: 1),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 8),
                                                            child: Text(
                                                              "RSVPs",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .primaryText,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                            width: 51,
                                                            height: 31,
                                                            child:
                                                                Switch.adaptive(
                                                              value: isRSVP,
                                                              inactiveTrackColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          60,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              onChanged:
                                                                  (value) {
                                                                isRSVP =
                                                                    !isRSVP;
                                                                setState(() {});
                                                              },
                                                              activeColor: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      37,
                                                                      70,
                                                                      240),
                                                              activeTrackColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          243,
                                                                          243),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    height: 3,
                                                    child: Image.asset(
                                                      "assets/line-2.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 44,
                                              margin: EdgeInsets.only(top: 11),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Container(
                                                    height: 31,
                                                    margin: EdgeInsets.only(
                                                        right: 1),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 9),
                                                            child: Text(
                                                              "Check-in notifications",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .primaryText,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                            width: 51,
                                                            height: 31,
                                                            child:
                                                                Switch.adaptive(
                                                              value:
                                                                  checkInNotification,
                                                              inactiveTrackColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          60,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              onChanged:
                                                                  (value) {
                                                                checkInNotification =
                                                                    !checkInNotification;
                                                                setState(() {});
                                                              },
                                                              activeColor: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      37,
                                                                      70,
                                                                      240),
                                                              activeTrackColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          243,
                                                                          243),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    height: 3,
                                                    child: Image.asset(
                                                      "assets/line-2.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 45,
                                              margin: EdgeInsets.only(top: 11),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Container(
                                                    height: 31,
                                                    margin: EdgeInsets.only(
                                                        right: 1),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10),
                                                            child: Text(
                                                              "Chat notifications",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .primaryText,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                            width: 51,
                                                            height: 31,
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                width: 1.5,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        229,
                                                                        229,
                                                                        234),
                                                              ),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15.5)),
                                                            ),
                                                            child:
                                                                Switch.adaptive(
                                                              value:
                                                                  chatNotification,
                                                              inactiveTrackColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          60,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              onChanged:
                                                                  (value) {
                                                                chatNotification =
                                                                    !chatNotification;
                                                                setState(() {});
                                                              },
                                                              activeColor: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      37,
                                                                      70,
                                                                      240),
                                                              activeTrackColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          243,
                                                                          243),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    height: 3,
                                                    child: Image.asset(
                                                      "assets/line-5.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 44,
                                              margin: EdgeInsets.only(top: 11),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  Container(
                                                    height: 31,
                                                    margin: EdgeInsets.only(
                                                        right: 1),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 10),
                                                            child: Text(
                                                              "New time proposed",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              style: TextStyle(
                                                                color: AppColors
                                                                    .primaryText,
                                                                fontFamily:
                                                                    "Muli",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 15,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Container(
                                                            width: 51,
                                                            height: 31,
                                                            decoration:
                                                                BoxDecoration(
                                                              border:
                                                                  Border.all(
                                                                width: 1.5,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        229,
                                                                        229,
                                                                        234),
                                                              ),
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15.5)),
                                                            ),
                                                            child:
                                                                Switch.adaptive(
                                                              value:
                                                                  newProposedTime,
                                                              inactiveTrackColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          60,
                                                                          0,
                                                                          0,
                                                                          0),
                                                              onChanged:
                                                                  (value) {
                                                                newProposedTime =
                                                                    !newProposedTime;
                                                                setState(() {});
                                                              },
                                                              activeColor: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      37,
                                                                      70,
                                                                      240),
                                                              activeTrackColor:
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          243,
                                                                          243,
                                                                          243),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Container(
                                                    height: 3,
                                                    child: Image.asset(
                                                      "assets/line-6.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
    );
  }

  //Call Api for alert Settings

  callAlertSettingsAPI() async {
    //TODO : CALL Register Api Here

    AlertSettingsRequest request;
    request = AlertSettingsRequest();
    request.user_generate_event = isUserGeneratedEvent == true ? 1 : 0;
    request.chats_notifications = chatNotification == true ? 1 : 0;
    request.machine_generate_event = isMachineGeneratedEvent == true ? 1 : 0;
    request.isRSVPs = isRSVP == true ? 1 : 0;
    request.check_in_notifications = checkInNotification == true ? 1 : 0;
    request.new_time_proposed = newProposedTime == true ? 1 : 0;
    request.event_feedback = 1;
    request.isRSVPs = 1;
    request.event_change_notifications = 1;
    request.language_id = 1;

    NotificationSettingResponse responseBusiness =
        await ApiProvider().callNotificationSettings(params: request);

    print(responseBusiness);
    if (responseBusiness.status == true) {
      preferences.setInt("chatNotification", chatNotification == true ? 1 : 0);
      preferences.setInt(
          "user_generate_event", isUserGeneratedEvent == true ? 1 : 0);
      preferences.setInt(
          "chats_notifications", chatNotification == true ? 1 : 0);
      preferences.setInt(
          "machine_generate_event", isMachineGeneratedEvent == true ? 1 : 0);
      preferences.setInt("RSVP", isRSVP == true ? 1 : 0);
      preferences.setInt(
          "check_in_notifications", checkInNotification == true ? 1 : 0);
      preferences.setInt("new_time_proposed", newProposedTime == true ? 1 : 0);

      new Future.delayed(new Duration(seconds: 1), () {
        Navigator.of(context).pop();
      });
    } else {
      Navigator.of(context).pop();

      SmartUtils.showErrorDialog(context, responseBusiness.message);
    }

    return responseBusiness;
  }
}
