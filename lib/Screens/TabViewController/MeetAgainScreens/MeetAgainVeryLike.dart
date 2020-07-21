import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simposi/Screens/TabViewController/mainTabView.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/smartutils.dart';

class MeetAgainVeryLike extends StatefulWidget {
  final NotificationList notification;
  MeetAgainVeryLike({
    @required this.notification,
  });

  @override
  _MeetAgainVeryLikeState createState() =>
      _MeetAgainVeryLikeState(notification: this.notification);
}

class _MeetAgainVeryLikeState extends State<MeetAgainVeryLike> {
  final NotificationList notification;

  _MeetAgainVeryLikeState({
    @required this.notification,
  });
  TextEditingController txtDescription = new TextEditingController();

  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    //
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
              height: 30,
              margin: EdgeInsets.only(top: 53),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          //
                          height: 21,
                          margin: EdgeInsets.only(left: 11, right: 13),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: GestureDetector(
                                  onTap: () => {
                                    Navigator.of(context).pop(),
                                  },
                                  child: Text(
                                    "Cancel",
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
                              Spacer(),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: GestureDetector(
                                    child: Text(
                                      "Submit",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 25, 39, 240),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                      ),
                                    ),
                                    onTap: () => {
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (_) => MainTabView()),
                                          (Route<dynamic> route) => false),
                                      // if (selectedIndex == -1)
                                      //   {
                                      //     SmartUtils.showErrorDialog(
                                      //         context, 'Please select reason.')
                                      //   }
                                      // else
                                      //   {
                                      // callCancelEvent(),
                                      // }
                                    },
                                  )),
                            ],
                          ),
                        ),
                        // Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              // top: 0,
              child: Text(
                "Connect",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Muli",
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 1,
              decoration: BoxDecoration(
                color: AppColors.primaryElement,
              ),
              child: Container(),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 29),
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
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: Text(
                  "Do you want to share contact details \nwith this person?",
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
            Container(
              height: 200,
              margin: EdgeInsets.only(left: 16, top: 53, right: 15),
              child: Column(
                // alignment: Alignment.center,
                children: [
                  Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 0),
                    // left: -1,
                    // right: -1,
                    child: GestureDetector(
                      onTap: () => {
                        selectedIndex = 0,
                        setState(() {}),
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 3,
                            child: Image.asset(
                              "assets/line.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 200,
                              height: 19,
                              margin: EdgeInsets.only(left: 1, top: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  selectedIndex == 0
                                      ? Container(
                                          width: 14,
                                          height: 14,
                                          margin: EdgeInsets.only(bottom: 6),
                                          child: Image.asset(
                                            "assets/radio-selected.png",
                                            fit: BoxFit.none,
                                          ),
                                        )
                                      : Container(
                                          width: 14,
                                          height: 14,
                                          margin: EdgeInsets.only(top: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.secondaryElement,
                                            border: Border.all(
                                              width: 1.5,
                                              color: Color.fromARGB(
                                                  255, 187, 187, 187),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7)),
                                          ),
                                          child: Container(),
                                        ),
                                  Container(
                                    margin: EdgeInsets.only(left: 28),
                                    child: Text(
                                      "Facebook",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: selectedIndex == 0
                                            ? Color.fromARGB(255, 25, 39, 240)
                                            : AppColors.primaryText,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
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
                    height: 50,

                    // left: -1,
                    // right: -1,
                    child: GestureDetector(
                      onTap: () => {
                        selectedIndex = 1,
                        setState(() {}),
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 3,
                            child: Image.asset(
                              "assets/line.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 200,
                              height: 19,
                              margin: EdgeInsets.only(left: 1, top: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  selectedIndex == 1
                                      ? Container(
                                          width: 14,
                                          height: 14,
                                          margin: EdgeInsets.only(bottom: 6),
                                          child: Image.asset(
                                            "assets/radio-selected.png",
                                            fit: BoxFit.none,
                                          ),
                                        )
                                      : Container(
                                          width: 14,
                                          height: 14,
                                          margin: EdgeInsets.only(top: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.secondaryElement,
                                            border: Border.all(
                                              width: 1.5,
                                              color: Color.fromARGB(
                                                  255, 187, 187, 187),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7)),
                                          ),
                                          child: Container(),
                                        ),
                                  Container(
                                    margin: EdgeInsets.only(left: 28),
                                    child: Text(
                                      "Instagram",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: selectedIndex == 1
                                            ? Color.fromARGB(255, 25, 39, 240)
                                            : AppColors.primaryText,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
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
                    height: 50,
                    // left: -1,
                    // right: -1,
                    child: GestureDetector(
                      onTap: () => {
                        selectedIndex = 2,
                        setState(() {}),
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 3,
                            child: Image.asset(
                              "assets/line.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 200,
                              height: 19,
                              margin: EdgeInsets.only(left: 1, top: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  selectedIndex == 2
                                      ? Container(
                                          width: 14,
                                          height: 14,
                                          margin: EdgeInsets.only(bottom: 6),
                                          child: Image.asset(
                                            "assets/radio-selected.png",
                                            fit: BoxFit.none,
                                          ),
                                        )
                                      : Container(
                                          width: 14,
                                          height: 14,
                                          margin: EdgeInsets.only(top: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.secondaryElement,
                                            border: Border.all(
                                              width: 1.5,
                                              color: Color.fromARGB(
                                                  255, 187, 187, 187),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7)),
                                          ),
                                          child: Container(),
                                        ),
                                  Container(
                                    margin: EdgeInsets.only(left: 28),
                                    child: Text(
                                      "Linkedin",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: selectedIndex == 2
                                            ? Color.fromARGB(255, 25, 39, 240)
                                            : AppColors.primaryText,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
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
                    height: 50,
                    child: GestureDetector(
                      onTap: () => {
                        selectedIndex = 3,
                        setState(() {}),
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            height: 3,
                            child: Image.asset(
                              "assets/line.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 200,
                              height: 19,
                              margin: EdgeInsets.only(left: 1, top: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  selectedIndex == 3
                                      ? Container(
                                          width: 14,
                                          height: 14,
                                          margin: EdgeInsets.only(bottom: 6),
                                          child: Image.asset(
                                            "assets/radio-selected.png",
                                            fit: BoxFit.none,
                                          ),
                                        )
                                      : Container(
                                          width: 14,
                                          height: 14,
                                          margin: EdgeInsets.only(top: 2),
                                          decoration: BoxDecoration(
                                            color: AppColors.secondaryElement,
                                            border: Border.all(
                                              width: 1.5,
                                              color: Color.fromARGB(
                                                  255, 187, 187, 187),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7)),
                                          ),
                                          child: Container(),
                                        ),
                                  Container(
                                    margin: EdgeInsets.only(left: 28),
                                    child: Text(
                                      "Email",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: selectedIndex == 3
                                            ? Color.fromARGB(255, 25, 39, 240)
                                            : AppColors.primaryText,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
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
                  /* // Positioned(
                    left: -1,
                    top: 0,
                    right: -1,
                    bottom: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 39,
                          margin: EdgeInsets.only(left: 1),
                          child: GestureDetector(
                            onTap: () => {
                              selectedIndex = 0,
                              setState(() {}),
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: 3,
                                  margin: EdgeInsets.only(left: 1),
                                  child: Image.asset(
                                    "assets/line-4.png",
                                    //  selectedIndex == 2 ? "assets/line-4.png":"assets/radio-selected.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 200,
                                    height: 19,
                                    margin: EdgeInsets.only(top: 17),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        selectedIndex == 0
                                            ? Container(
                                                width: 14,
                                                height: 14,
                                                margin:
                                                    EdgeInsets.only(bottom: 6),
                                                child: Image.asset(
                                                  "assets/radio-selected.png",
                                                  fit: BoxFit.none,
                                                ),
                                              )
                                            : Container(
                                                width: 14,
                                                height: 14,
                                                margin: EdgeInsets.only(top: 2),
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .secondaryElement,
                                                  border: Border.all(
                                                    width: 1.5,
                                                    color: Color.fromARGB(
                                                        255, 187, 187, 187),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(7)),
                                                ),
                                                child: Container(),
                                              ),
                                        Container(
                                          margin: EdgeInsets.only(left: 28),
                                          child: Text(
                                            "Instagram",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: selectedIndex == 0
                                                  ? Color.fromARGB(
                                                      255, 25, 39, 240)
                                                  : AppColors.primaryText,
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
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
                        Spacer(),
                        Container(
                          height: 38,
                          child: GestureDetector(
                            onTap: () => {
                              selectedIndex = 2,
                              setState(() {}),
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: 3,
                                  child: Image.asset(
                                    "assets/line.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 200,
                                    height: 20,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        selectedIndex == 2
                                            ? Container(
                                                width: 14,
                                                height: 14,
                                                margin:
                                                    EdgeInsets.only(bottom: 6),
                                                child: Image.asset(
                                                  "assets/radio-selected.png",
                                                  fit: BoxFit.none,
                                                ),
                                              )
                                            : Container(
                                                width: 14,
                                                height: 14,
                                                margin: EdgeInsets.only(top: 2),
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .secondaryElement,
                                                  border: Border.all(
                                                    width: 1.5,
                                                    color: Color.fromARGB(
                                                        255, 187, 187, 187),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(7)),
                                                ),
                                                child: Container(),
                                              ),
                                        Container(
                                          margin: EdgeInsets.only(left: 26),
                                          child: Text(
                                            "Linkedin",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: selectedIndex == 2
                                                  ? Color.fromARGB(
                                                      255, 25, 39, 240)
                                                  : AppColors.primaryText,
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 200,
                                    height: 20,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        selectedIndex == 3
                                            ? Container(
                                                width: 14,
                                                height: 14,
                                                margin:
                                                    EdgeInsets.only(bottom: 6),
                                                child: Image.asset(
                                                  "assets/radio-selected.png",
                                                  fit: BoxFit.none,
                                                ),
                                              )
                                            : Container(
                                                width: 14,
                                                height: 14,
                                                margin: EdgeInsets.only(top: 2),
                                                decoration: BoxDecoration(
                                                  color: AppColors
                                                      .secondaryElement,
                                                  border: Border.all(
                                                    width: 1.5,
                                                    color: Color.fromARGB(
                                                        255, 187, 187, 187),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(7)),
                                                ),
                                                child: Container(),
                                              ),
                                        Container(
                                          margin: EdgeInsets.only(left: 26),
                                          child: Text(
                                            "Email",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: selectedIndex == 3
                                                  ? Color.fromARGB(
                                                      255, 25, 39, 240)
                                                  : AppColors.primaryText,
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
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
                      ],
                    ),
                  // ),*/
                ],
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 243, 243),
                border: Border.all(
                  width: 1,
                  color: Color.fromARGB(255, 227, 227, 227),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 18),
                    child: Text(
                      "More details (Optional)",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColors.accentText,
                        fontFamily: "Muli",
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin:
                    EdgeInsets.only(left: 17, top: 29, right: 15, bottom: 17),
                child: TextField(
                  controller: txtDescription,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "Type here…",
                    contentPadding: EdgeInsets.all(0),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Color.fromARGB(255, 187, 187, 187),
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  autocorrect: false,
                ),
              ),
            ),
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

  callNotificationConnectAPI() async {
    //TODO : CALL Register Api Here

    // var cancelReason = '';
    // if (selectedIndex == 0) {
    //   cancelReason = "Let others know why you couldn’t make it";
    // } else if (selectedIndex == 1) {
    //   cancelReason = "Wasn’t feeling it";
    // } else if (selectedIndex == 2) {
    //   cancelReason = "Something came up";
    // }
    // CancelEventRequest request;
    // request = CancelEventRequest();
    // request.eventId = event.event_id;
    // request.cancelReason = cancelReason; //txtDescription.text;
    // request.language_id = 1;

    // CancelEventResponse responseBusiness =
    //     await ApiProvider().callCancelEventApi(params: request);

    // print(responseBusiness);
    // if (responseBusiness.status == true) {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (_) => MainTabView()),
    //       (Route<dynamic> route) => false);
    // } else {
    //   SmartUtils.showErrorDialog(context, responseBusiness.message);
    // }

    // return responseBusiness;
  }
}

/*
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
              height: 272,
              margin: EdgeInsets.only(top: 53),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0,
                    top: 34,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: AppColors.primaryElement,
                          ),
                          child: Container(),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 99,
                            height: 22,
                            margin: EdgeInsets.only(left: 17),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color:
                                            Color.fromARGB(255, 229, 229, 234),
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(11)),
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(left: 17, bottom: 1),
                                    child: Text(
                                      "Linkedin",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 25, 39, 240),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
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
                  Positioned(
                    left: 0,
                    top: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 35,
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Positioned(
                                top: 0,
                                child: Text(
                                  "Connect",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.primaryText,
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                right: 0,
                                bottom: 0,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      height: 21,
                                      margin:
                                          EdgeInsets.only(left: 11, right: 13),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Cancel",
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
                                          Spacer(),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Share",
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
                                        ],
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
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 259,
                            height: 66,
                            margin: EdgeInsets.only(top: 17),
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
                                Text(
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
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 33,
                          margin: EdgeInsets.only(left: 16, top: 34),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 108,
                                  height: 22,
                                  margin: EdgeInsets.only(left: 1),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          width: 22,
                                          height: 22,
                                          child: Image.asset(
                                            "assets/checkmark.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          margin: EdgeInsets.only(left: 17),
                                          child: Text(
                                            "Facebook",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 1,
                                margin: EdgeInsets.only(bottom: 1),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryElement,
                                ),
                                child: Container(),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 35,
                          margin: EdgeInsets.only(left: 16, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  width: 113,
                                  height: 22,
                                  margin: EdgeInsets.only(left: 1),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: Color.fromARGB(
                                                  255, 229, 229, 234),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(11)),
                                          ),
                                          child: Container(),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          margin:
                                              EdgeInsets.only(left: 17, top: 2),
                                          child: Text(
                                            "Instagram",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 1,
                                margin: EdgeInsets.only(bottom: 1),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryElement,
                                ),
                                child: Container(),
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
            Container(
              height: 39,
              margin: EdgeInsets.only(left: 16, top: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      color: AppColors.primaryElement,
                    ),
                    child: Container(),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 79,
                      height: 22,
                      margin: EdgeInsets.only(left: 1, top: 16),
                      child: Row(
                        children: [
                          Container(
                            width: 22,
                            height: 22,
                            child: Image.asset(
                              "assets/checkmark.png",
                              fit: BoxFit.none,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Email",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(top: 13),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 243, 243, 243),
                border: Border.all(
                  width: 1,
                  color: Color.fromARGB(255, 227, 227, 227),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16, top: 18),
                    child: Text(
                      "Message (Optional)",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColors.accentText,
                        fontFamily: "Muli",
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 337,
                height: 324,
                margin: EdgeInsets.only(left: 17, top: 15),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Type here…",
                    contentPadding: EdgeInsets.all(0),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(
                    color: Color.fromARGB(255, 187, 187, 187),
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                  maxLines: 1,
                  autocorrect: false,
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
}
*/
