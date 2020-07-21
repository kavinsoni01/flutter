import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:progress_dialog/progress_dialog.dart';
 import 'package:shared_preferences/shared_preferences.dart';
import 'package:simposi/Utils/Utility/DesignAppTheme.dart';

class SmartUtils {

  static  ProgressDialog pr;

  static void showErrorDialog(BuildContext context, String error) {

    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: new  Text(
                        'Simposi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          // color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: "Helvetica",
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          letterSpacing: -0.408,
                          height: 1.29412,
                        ),
                      ),
                                      
        content: new Text(error,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            letterSpacing: -0.078,
                            height: 1.23077,
                        ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
          onPressed: ()=>{
                print('Okay'),
               Navigator.pop(context),
            },
            isDefaultAction: true,
            child: Text("Okay",),
          ),
        ],
      )
    );


    // flutter defined function
    // showDialog(context: context, builder: (BuildContext context) {
    //     // return object of type Dialog
    //     return AlertDialog(
    //       backgroundColor: DesignAppTheme.white,
    //       title: new Text("Simposi"),
    //       titleTextStyle: TextStyle(color: DesignAppTheme.text_primary , fontSize: 18),
    //       contentTextStyle: TextStyle(color: DesignAppTheme.grey, fontSize: 16),
    //       content: new Text(error),
    //       actions: <Widget>[
    //         // usually buttons at the bottom of the dialog
    //         new FlatButton(
    //           child: new Text("Ok"),
    //           textColor: DesignAppTheme.primary_Dark,
    //           onPressed: () {
    //            Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }



  static void showAlertViewIosStyle(BuildContext context, String title , String details) {
    // flutter defined function
showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: new  Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          // color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: "Helvetica",
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                          letterSpacing: -0.408,
                          height: 1.29412,
                        ),
                      ),
                                      
        content: new Text(details,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // color: Color.fromARGB(255, 0, 0, 0),
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            letterSpacing: -0.078,
                            height: 1.23077,
                        ),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
          onPressed: ()=>{
                print('Okay'),
               Navigator.pop(context),
            },
            isDefaultAction: true,
            child: Text("Okay",),
          ),
        ],
      )
    );
  }


  static bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }


  static  Widget centerLoading() {
    return Container(
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



  static ShowProgressDialog(BuildContext context){
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Waiting...',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    pr.show();
  }

  static  HideProgressDialog(){
    pr.hide();
  }

static const BusineesCardColor =  Color(0xFFECF0F3);
static const lightGrayBackground =  Color(0xFFF5F6F8);
static const blueBackground = Color.fromARGB(255, 25, 39, 240);
//Color(0xFF1C34E6);
static const themeGrayColor =  Color(0xFFE3E3E3);
static const progressLighBlueColor =  Color(0xFFD6D6F2);
static const darkGrayBackground =  Color(0xFFF5F6F8);
static const homeBackgroundGray = Color(0xFFF4F4F4);

static const darkGrayColorText = Color.fromARGB(255, 48, 49, 50);
static const lighGrayColorText =   Color.fromARGB(255, 187, 187, 187) ;                               
}



