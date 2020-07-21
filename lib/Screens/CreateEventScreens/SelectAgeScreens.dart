import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:simposi/Screens/SignupScreens/SignupScreen4.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Models/CreateEventModel.dart';
import 'package:simposi/Utils/Models/SignupModel.dart';
import 'package:simposi/Utils/Utility/colors.dart';
import 'package:simposi/Utils/smartutils.dart';

class SelectAgeScreens extends StatefulWidget {
  final AllDataModel alldata;
  final CreateEventModel createEventModel;
  final AllDataModel originalData;
  final bool isFromMeetNow;

  SelectAgeScreens(
      {@required this.createEventModel,
      this.alldata,
      this.originalData,
      this.isFromMeetNow});

  @override
  _SelectAgeScreensState createState() => _SelectAgeScreensState(
      createEventModel: this.createEventModel,
      alldata: this.alldata,
      originalData: this.originalData,
      isFromMeetNow: this.isFromMeetNow);
}

class _SelectAgeScreensState extends State<SelectAgeScreens> {
  // int selectedGender = -1;
  // GenerationIdentify generationIdentify ;
//  List<GenerationIdentify> generationIdentify;
  final bool isFromMeetNow;

  final CreateEventModel createEventModel;
  final AllDataModel alldata;
  final AllDataModel originalData;

  bool oneSelected = false;
  _SelectAgeScreensState(
      {@required this.createEventModel,
      this.alldata,
      this.originalData,
      this.isFromMeetNow});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);

    return Scaffold(
      extendBodyBehindAppBar: true,
      // backgroundColor: SmartUtils.blueBackground,//Colors.white,//
      body: _MainBody(),
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 125,
        padding: EdgeInsets.only(top: 25, bottom: 50, left: 40, right: 40),
        child: continueButton(),
//color blak
      ),
    );
  }

  Widget _MainBody() {
    return Container(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _getAppBarUI(),
            Container(
              //  margin: EdgeInsets.only(top: 185),
              margin: EdgeInsets.only(left: 20, right: 20, top: 10),
              alignment: Alignment.center,
              height: 30,
              child: isFromMeetNow == true
                  ? Text(
                      'Who do you want to invite?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: "Helvetica",
                        fontWeight: FontWeight.w400,
                        fontSize: 19,
                      ),
                    )
                  : Text(
                      'Generations I identity with..',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: "Helvetica",
                        fontWeight: FontWeight.w400,
                        fontSize: 19,
                      ),
                    ),
            ),
            SizedBox(height: 0),
            new MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: new Container(
                child: Container(
                    // height:  - 393 - MediaQuery.of(context).padding.top,
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        270, //MediaQuery.of(context).size.height-270 - 119, alldata.generationIdentify.length.toDouble() * 62
                    child: new ListView.builder(
                        itemCount: alldata.generationIdentify.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Container(
                              margin: EdgeInsets.only(
                                  top: 0, bottom: 0, right: 20, left: 20),
                              height: 62,
                              child: buildRow(index));
                        })),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  } //

//

  Widget _getAppBarUI() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      padding: EdgeInsets.only(left: 0, top: 10, bottom: 10, right: 0),
      height: 72,
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
                      Navigator.pop(context, this.originalData),
                    }),
          ),
        ],
      ),
    );
  }

  Widget continueButton() {
    this.alldata.generationIdentify.forEach((element) {
      if (element.isSelected == true) {
        this.oneSelected = true;
      }
    });

    return RaisedButton(
      color: oneSelected == true
          ? SmartUtils.blueBackground
          : SmartUtils.themeGrayColor,
      onPressed: () {
        // TODO: Api Call  Here
        var selectArr = List<GenerationIdentify>();
        // signupModel.selectedGeneration = this.generationIdentify;
        this.alldata.generationIdentify.forEach((element) {
          if (element.isSelected == true) {
            selectArr.add(element);
          }
        });
        if (selectArr.length > 0) {
          Navigator.pop(context, this.alldata);
        } else {
          SmartUtils.showErrorDialog(
              context, 'Please select at least one Generation Identity');
        }
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
          child: this.oneSelected == true
              ? Text(
                  'Continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Muli",
                      color: Colors.white),
                )
              : Text(
                  'Continue',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Muli",
                      color: Colors.black),
                ),
        ),
      ),
    );
  }

  Widget buildRow(
    int index,
  ) {
    return Container(
      //  padding:EdgeInsets.only(top:12,bottom:0,right:0,left:0) ,
      margin: EdgeInsets.only(top: 12, bottom: 0, right: 20, left: 20),
      height: 62,
      child: RaisedButton(
        color: this.alldata.generationIdentify[index].isSelected == true
            ? SmartUtils.blueBackground
            : SmartUtils.themeGrayColor,
        onPressed: () {
          this.alldata.generationIdentify[index].isSelected =
              !this.alldata.generationIdentify[index].isSelected;
          oneSelected = false;

          this.alldata.generationIdentify.forEach((element) {
            if (element.isSelected == true) {
              oneSelected = true;
            }
          });
          setState(() {});
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          child: this.alldata.generationIdentify[index].isSelected == true
              ? Container(
                  constraints:
                      const BoxConstraints(minWidth: 100.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    this
                        .alldata
                        .generationIdentify[index]
                        .title, // 'Silent (1928 - 1945)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Muli",
                        color: Colors.white),
                  ),
                )
              : Container(
                  constraints:
                      const BoxConstraints(minWidth: 100.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    this
                        .alldata
                        .generationIdentify[index]
                        .title, // 'Silent (1928 - 1945)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Muli",
                        color: Colors.black),
                  ),
                ),
        ),
      ),
    );
  }
}
