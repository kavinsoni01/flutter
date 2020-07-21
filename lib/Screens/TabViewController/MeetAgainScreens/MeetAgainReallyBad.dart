import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simposi/Screens/TabViewController/mainTabView.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/smartutils.dart';

class MeetAgainReallyBad extends StatefulWidget {
  final NotificationList notification;

  MeetAgainReallyBad({
    @required this.notification,
  });

  @override
  _MeetAgainReallyBadState createState() =>
      _MeetAgainReallyBadState(notification: this.notification);
}

class _MeetAgainReallyBadState extends State<MeetAgainReallyBad> {
  TextEditingController txtDisctiption = new TextEditingController();
  final NotificationList notification;

  _MeetAgainReallyBadState({
    @required this.notification,
  });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // txtDisctiption.text = stringDesc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 125,
        padding: EdgeInsets.only(top: 25, bottom: 50, left: 40, right: 40),
        child: continueButton(),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _getAppBarUI(),
              // Container(
              //   height: 21,
              //   margin: EdgeInsets.only(left: 11, top: 53, right: 13),
              //   child: Stack(
              //     alignment: Alignment.center,
              //     children: [

              //       Container(

              //         // left: 0,
              //         // right: 0,
              //         child: Row(
              //           crossAxisAlignment: CrossAxisAlignment.stretch,
              //           children: [
              //   Align(
              //   alignment: Alignment.topLeft,
              //   child:
              //   GestureDetector(
              //       child:  Container(
              //     width: 20,
              //     height: 16,
              //   //  margin: EdgeInsets.only(left: 16, top: 14),
              //     child: Image.asset(
              //       "assets/backArrow@3x.png",
              //     ),
              //   ),
              //   onTap:() => {
              //              Navigator.pop(context, ''),
              //   }
              //   ),
              // ),
              //             // GestureDetector(
              //             //   onTap: ()=>{
              //             //                   Navigator.pop(context, ''),
              //             //   },
              //             // child:Align(
              //             //   alignment: Alignment.centerLeft,
              //             //   child: Text(
              //             //     "Cancel",
              //             //     textAlign: TextAlign.right,
              //             //     style: TextStyle(
              //             //       color: Color.fromARGB(255, 25, 39, 240),
              //             //       fontFamily: "Muli",
              //             //       fontWeight: FontWeight.w400,
              //             //       fontSize: 17,
              //             //     ),
              //             //   ),
              //             // ),
              //             // ),
              //             Spacer(),

              //            GestureDetector(
              //             onTap: () => {
              //                   Navigator.pop(context, txtDescription.text),
              //             },
              //             child:
              //             Align(
              //               alignment: Alignment.centerLeft,
              //               child: Text(
              //                 "Submit",
              //                 textAlign: TextAlign.right,
              //                 style: TextStyle(
              //                   color: Color.fromARGB(255, 25, 39, 240),
              //                   fontFamily: "Muli",
              //                   fontWeight: FontWeight.w400,
              //                   fontSize: 17,
              //                 ),
              //               ),
              //             ),
              //            ),
              //           ],
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(height: 10),
              Positioned(
                child: Text(
                  "User Report",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 17, top: 11, right: 16),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 187, 187, 187),
                ),
                child: Container(),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 295,
                  margin: EdgeInsets.only(top: 16),
                  child: Text(
                    "Tell us what happened. If you just didn’t like this user and don’t want to see them again, go back and use the other unhappy face. This one is for reporting serious stuff only.",
                    textAlign: TextAlign.center,
                    maxLines: 5,
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

              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 342,
                  height: MediaQuery.of(context).size.height - 328,
                  margin: EdgeInsets.only(left: 17, top: 18),
                  child: TextField(
                    controller: txtDisctiption,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () {
                      print("edit");
                      // _focusNode.unfocus();
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      hintText: "Type here…",
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 181, 179, 179),
                      ),
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    autocorrect: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget continueButton() {
    return RaisedButton(
      color: SmartUtils.blueBackground,
      onPressed: () {
        // Navigator.pop(context, txtDisctiption.text);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => MainTabView()),
            (Route<dynamic> route) => false);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child: Container(
          constraints: const BoxConstraints(minWidth: 100.0, minHeight: 50.0),
          alignment: Alignment.center,
          child: const Text(
            'Submit',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                fontFamily: 'Muli',
                color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _getAppBarUI() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      padding: EdgeInsets.only(top: 10, bottom: 0),
      height: 44,
      width: MediaQuery.of(context).size.width,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 4,
            decoration: BoxDecoration(
              color: Color.fromARGB(50, 25, 39, 240),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 25, 39, 240),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(0),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    child: Container(
                      width: 20,
                      height: 16,
                      margin: EdgeInsets.only(left: 16, top: 14),
                      child: Image.asset(
                        "assets/backArrow@3x.png",
                      ),
                    ),
                    onTap: () => {
                          Navigator.pop(context, ""),
                        }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
