import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simposi/Screens/TabViewController/mainTabView.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';

class EnterDateAndTimeScreen extends StatefulWidget {
  @override
  _EnterDateAndTimeScreenState createState() => _EnterDateAndTimeScreenState();
}

class _EnterDateAndTimeScreenState extends State<EnterDateAndTimeScreen> {
  DateTime selectedDate;
  String selectedDateAndTime = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    this.selectedDate = new DateTime.now();

    //   var newDateTimeObj2 = new DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(dateformate);
    var formatter = new DateFormat("EEEE, MMM dd hh:mm a");
    this.selectedDateAndTime = formatter.format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    var now = DateTime.now();
    var today = new DateTime(now.year, now.month, now.day);

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 35,
                margin: EdgeInsets.only(top: 53),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      // left: 0,
                      // top: 0,
                      // right: 0,
                      // bottom: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
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
                                          color:
                                              Color.fromARGB(255, 25, 39, 240),
                                          fontFamily: "Muli",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 17,
                                        ),
                                      ),
                                      onTap: () => {
                                        popViewController(),

                                        //     Navigator.of(context).pushAndRemoveUntil(
                                        //   MaterialPageRoute(builder: (_) => MainTabView()),
                                        //  (Route<dynamic> route) => false)
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
                // top: 0,
                child: Text(
                  "Enter Date Time",
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
                height: 10,
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
                  width: 295,
                  margin: EdgeInsets.only(top: 14),
                  child: Text(
                    "Suggest a another time to meet. Keep in mind your proposed time may need to be approved \nby the organizer.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.accentText,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.14286,
                    ),
                  ),
                ),
              ),
              Container(
                height: 51,
                margin: EdgeInsets.only(left: 16, top: 14, right: 15),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      child: Text(
                        selectedDateAndTime ?? "Thursday, May 28, 9:17 AM", //
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 1, 126),
                          fontFamily: "Helvetica",
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      // left: -1,
                      // top: 0,
                      // right: -1,
                      // bottom: 0,
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
              Container(
                height: 300,
                margin: EdgeInsets.only(left: 16, top: 14, right: 15),
                child: CupertinoDatePicker(
                  minimumDate: today,
                  minuteInterval: 1,
                  mode: CupertinoDatePickerMode.dateAndTime,
                  onDateTimeChanged: (DateTime dateTime) {
                    print("dateTime: ${dateTime}");
                    this.selectedDate = dateTime;

                    //   var newDateTimeObj2 = new DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(dateformate);
                    var formatter = new DateFormat("EEEE, MMM dd hh:mm a");
                    this.selectedDateAndTime = formatter.format(selectedDate);
                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  popViewController() {
    var formatter = new DateFormat("yyyy-MM-dd hh:mm a");
    var passDate = formatter.format(selectedDate);
    Navigator.pop(context, passDate);
  }
}
