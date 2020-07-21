import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simposi/Screens/LoginScreen.dart';
import 'package:simposi/Screens/SignupScreens/SignupScreen1.dart';
import 'package:simposi/Screens/TabViewController/mainTabView.dart';
import 'package:simposi/Utils/Utility/Values/radii.dart';
import 'package:simposi/Utils/Utility/colors.dart';
import 'package:simposi/Utils/smartutils.dart';
import 'package:flutter/services.dart';

class GetStarted extends StatefulWidget {
  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(SmartUtils.blueBackground);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
      // primary: false,
      // appBar: new AppBar(),

      // extendBodyBehindAppBar: true,
      backgroundColor: SmartUtils.blueBackground, //Colors.white,//
      body: _MainBody(),
    );
  }

  Widget _MainBody() {
    return Container(
      child: Stack(
        children: <Widget>[
          // SingleChildScrollView(
          // padding: EdgeInsets.all(0),
          // physics: BouncingScrollPhysics(),//
          // scrollDirection: Axis.vertical,
          // child:
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 00),
            child: Stack(
              children: <Widget>[
                Container(
                  // constraints: BoxConstraints.expand(),
                  child: Container(
                    child: Image.asset(
                      'assets/background@3x.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 229, left: 37, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 100,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.bottomLeft,
                                  height: 80,
                                  child: Text(
                                    'simposi',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppColors.secondaryText,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
//sizebox 
                                SizedBox(width: 10),
                                Container(
                                  // left: 188,
                                  // top: 160,
                                  child: Image.asset(
                                    "assets/group-7.png",
                                    width: 70,
                                    height: 74,
                                    // fit: BoxFit.none,
                                  ),
                                ),

                                // Image.asset(
                                //     'assets/logo.png',
                                //      height: 100,
                                //      width: 80,//-MediaQuery.of(context).size.width/2,
                                //      fit: BoxFit.fitWidth,
                                //       ),
                              ],
                            ),
                          ),
                        ],
                        // alignment:Alignment.bottomLeft,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 0),
                        child: Text(
                          "A new way to match and meet people \nwith the same interests.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            height: 1.2,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          width: 160,
                          height: 50,
                          margin: EdgeInsets.only(left: 1, top: 15),
                          // margin: EdgeInsets.only(left: 1, top: 60),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryElement,
                            borderRadius: Radii.k25pxRadius,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: GestureDetector(
                                  child: Text(
                                    "Get Started",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 48, 49, 50),
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 17,
                                    ),
                                  ),
                                  onTap: () => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignupScreen1()))
                                  },
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
                  margin: EdgeInsets.only(top: 317, left: 0, bottom: 10),
                  child: Column(
                    children: [
                      Spacer(),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 125,
                          height: 15,
                          margin: EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: [
                              Text(
                                "Privacy",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: AppColors.secondaryText,
                                  fontFamily: "Muli",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
                                ),
                              ),
                              Opacity(
                                opacity: 1.0,
                                child: Container(
                                  width: 4,
                                  height: 4,
                                  margin: EdgeInsets.only(left: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryElement,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(1.5)),
                                  ),
                                  child: Container(),
                                ),
                              ),
                              Spacer(),
                              Text(
                                "Terms Of Use",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: AppColors.secondaryText,
                                  fontFamily: "Muli",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11,
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
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 5),
                  child: GestureDetector(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('Log In',
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            )),
                        SizedBox(
                          width: 5,
                        ),
                        new Image.asset(
                          "assets/nextArrow@3x.png",
                          fit: BoxFit.cover,
                          width: 14,
                          height: 14,
                        ),
                        SizedBox(
                          width: 25,
                        ),
                      ],
                    ),

//
                    onTap: () => {
                      //open login screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()))
                    },
                  ),
                ),

                //    Container(

                //  // margin: MediaQuery.of(context).size.height - 150,
                //   width:  MediaQuery.of(context).size.width/4 + 40,
                //   margin: EdgeInsets.only(top:MediaQuery.of(context).size.height/2+150 , left: 40),

                //   child:GestureDetector(

                //       child: Image.asset('assets/getStarted@3x.png',height: 60,width:MediaQuery.of(context).size.width/4 ,),

                //           onTap: () => {
                //               Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen1()))
                //           },
                //         ),
                // ),

//                 Container(
//                // margin: MediaQuery.of(context).size.height - 150,
//                 width:  MediaQuery.of(context).size.width,
//                 margin: EdgeInsets.only(top:MediaQuery.of(context).size.height-120),

//                 child:GestureDetector(

//                     child: Center(
//                       child:Text('Privacy - terms of use',style: TextStyle(  color: AppColors.secondaryText,
//                                     fontFamily: "Muli",
//                                     fontWeight: FontWeight.w700,
//                                     fontSize: 12,)),
//                     ) ,

// //
//                         onTap: () => {
//                             //open Privacy screen
//                         },
//                       ),
//               ),
              ],
            ),
          ),
          // )
        ],
      ),
    );
  } //

  Widget _getAppBarUI() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      padding: EdgeInsets.all(10),
      height: 60,
      width: MediaQuery.of(context).size.width,
      child: new Row(
        children: <Widget>[
          IconButton(
              icon: new Icon(
                Icons.arrow_back_ios,
                color: SmartUtils.blueBackground,
              ),
              onPressed: () => Navigator.of(context).pop()),
          Expanded(
            child: Align(
              child: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  'Account Info',
                  style: TextStyle(
                    fontFamily: 'Brown',
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
class GetStartedWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
  


    return Scaffold(
      body: Container(
                    height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,

        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 25, 39, 240),
        ),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              // margin: EdgeInsets.only(left:0,top:0,right:0,bottom:0),
              // left: 0,
              // top: 0,
              // right: 61,
              // bottom: -1,
              child: Stack(
                alignment: Alignment.center,
                children: [

                    Container(
                    
                    child: Image.asset(
                        'assets/background@3x.png',
                      fit: BoxFit.cover,
                    ),
                  ),
             
                  Container(
                    margin: EdgeInsets.only(left:37,top:317,bottom:10),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 277,
                            height: 90,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "simposi",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppColors.secondaryText,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 40,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  margin: EdgeInsets.only(left: 1),
                                  child: Text(
                                    "A new way to match and meet people \nwith the same interests.",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppColors.secondaryText,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 160,
                            height: 50,
                            margin: EdgeInsets.only(left: 1, top: 60),
                            decoration: BoxDecoration(
                              color: AppColors.secondaryElement,
                              borderRadius: Radii.k25pxRadius,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Get Started",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 48, 49, 50),
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 17,
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
                            width: 122,
                            height: 14,
                            margin: EdgeInsets.only(bottom: 48),
                            child: Row(
                              children: [
                                Text(
                                  "Privacy",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                                Opacity(
                                  opacity: 0.59824,
                                  child: Container(
                                    width: 3,
                                    height: 3,
                                    margin: EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                      color: AppColors.secondaryElement,
                                      borderRadius: BorderRadius.all(Radius.circular(1.5)),
                                    ),
                                    child: Container(),
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  "Terms Of Use",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 134,
                            height: 5,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryElement,
                              borderRadius: BorderRadius.all(Radius.circular(2.5)),
                            ),
                            child: Container(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // top: 288,
                    // right: 56,
                    margin: EdgeInsets.only(right:56 ,top:288),
                    child: Image.asset(
                      'assets/logo.png',
                      fit: BoxFit.none,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // top: 60,
              // right: 36,
              margin: EdgeInsets.only(top:60,right:36),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        "Log In",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 6,
                    height: 9,
                    child: Image.asset(
                             "assets/nextArrow@3x.png",
                      fit: BoxFit.none,
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
}*/
