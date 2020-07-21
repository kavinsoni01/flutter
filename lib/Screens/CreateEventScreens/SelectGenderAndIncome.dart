import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Models/CreateEventModel.dart';
import 'package:simposi/Utils/Utility/colors.dart';
import 'package:simposi/Utils/smartutils.dart';

class SelectGenderAndIncome extends StatefulWidget {
  final AllDataModel alldata;
  final CreateEventModel createEventModel;
  final AllDataModel originalData;
  final bool isFromMeetNow;

  SelectGenderAndIncome(
      {@required this.createEventModel,
      this.alldata,
      this.originalData,
      this.isFromMeetNow});

  @override
  _SelectGenderAndIncomeState createState() => _SelectGenderAndIncomeState(
      createEventModel: this.createEventModel,
      alldata: this.alldata,
      originalData: this.originalData,
      isFromMeetNow: this.isFromMeetNow);
}

class _SelectGenderAndIncomeState extends State<SelectGenderAndIncome> {
  final AllDataModel originalData;
  final bool isFromMeetNow;

  int selectedGender = -1;
  double sliderValue = 50;
  WantToMeet wantToMeet;
  bool oneSelected = false;
  final CreateEventModel createEventModel;
  final AllDataModel alldata;

  _SelectGenderAndIncomeState(
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
      ),
    );
  }

  Widget _MainBody() {
    return Container(
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          80,
      color: Colors.white,
      child: SingleChildScrollView(
        // color: Colors.white,

        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _getAppBarUI(),

              Container(
                //  margin: EdgeInsets.only(top: 185),
                margin: EdgeInsets.only(left: 50, right: 50, top: 10),
                alignment: Alignment.center,
                height: 30, //
                // child:Text('I want to meet...',textAlign: TextAlign.center
                child: this.isFromMeetNow == true
                    ? Text(
                        'Who do you want to invite?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Helvetica",
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 19,
                        ),
                      )
                    : Text(
                        'I want to meet...',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Helvetica",
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 19,
                        ),
                      ),
              ),
              //  SizedBox(height:5),
              MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: Container(
                    height: (this.alldata.wantToMeet.length.toDouble() * 60),
                    child: new ListView.builder(
                        itemCount: alldata.wantToMeet.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Container(
                              margin: EdgeInsets.only(
                                  top: 0, bottom: 0, right: 20, left: 20),
                              height: 60,
                              child: buildRowWantToMeet(index));
                        })),
              ),

              SizedBox(height: 25),

              Container(
                  margin: EdgeInsets.only(left: 40, right: 40),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            'Who earn',
                            style: TextStyle(
                              color: AppColors.accentText,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Muli",
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )),

              SizedBox(height: 20),

              Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                height: 170,
                child: new MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: new Container(
                    child: GridView.count(
                      childAspectRatio: 3.5,
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 2,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(
                        this.alldata.whoEarn.length,
                        (index) {
                          return buildRow(index);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // ],
        ),
      ),
    );
  } //

  Widget buildRowWantToMeet(int index) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 0, right: 0, left: 0),
      margin: EdgeInsets.only(top: 0, bottom: 0, right: 20, left: 20),
      height: 50,
      child: RaisedButton(
        color: this.alldata.wantToMeet[index].isSelected == true
            ? SmartUtils.blueBackground
            : SmartUtils.themeGrayColor,
        onPressed: () {
          selectedGender = index;

          this.alldata.wantToMeet[index].isSelected =
              !this.alldata.wantToMeet[index].isSelected;
          oneSelected = false;

          this.alldata.wantToMeet.forEach((element) {
            if (element.isSelected == true) {
              oneSelected = true;
            }
          });
          if (mounted) {
            setState(() {});
          }
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
          ),
          child: this.alldata.wantToMeet[index].isSelected == true
              ? Container(
                  constraints:
                      const BoxConstraints(minWidth: 100.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    this
                        .alldata
                        .wantToMeet[index]
                        .title, // 'Silent (1928 - 1945)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              : Container(
                  constraints:
                      const BoxConstraints(minWidth: 100.0, minHeight: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    this
                        .alldata
                        .wantToMeet[index]
                        .title, // 'Silent (1928 - 1945)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontFamily: "Muli",
                    ),
                  ),
                ),
        ),
      ),
    );
  }

//
  Widget continueButton() {
    return RaisedButton(
      color: SmartUtils.blueBackground,
      onPressed: () {
        // TODO: Api Call  Here

        var selectArr = List<WhoEarn>();
        this.alldata.whoEarn.forEach((element) {
          if (element.isSelected == true) {
            selectArr.add(element);
          }
        });

        var selectGenderArr = List<WantToMeet>();
        this.alldata.wantToMeet.forEach((element) {
          if (element.isSelected == true) {
            selectGenderArr.add(element);
          }
        });

        if (selectArr.length > 0) {
          //     var professionString = '';
          //     selectArr.forEach((element) {
          //       if (element.isSelected == true ){

          //         if (professionString != ''){
          //                  professionString  = professionString + ',' + element.whoEarnsId.toString();
          //         }else{
          //               professionString = element.whoEarnsId.toString();
          //         }
          //       }
          //     });
          //     this.createEventModel.earningId = professionString;

          if (selectGenderArr.length > 0) {
            //     var wantToMeetString = '';
            //     selectGenderArr.forEach((element) {
            //       if (element.isSelected == true ){

            //         if ( wantToMeetString != ''){
            //               wantToMeetString  = wantToMeetString + ',' + element.iWantToMeetId.toString();
            //         }else{
            //               wantToMeetString = element.iWantToMeetId.toString();
            //         }
            //       }
            //      });
            //          this.createEventModel.gendersId = wantToMeetString;
            Navigator.pop(context, this.alldata);
          } else {
            SmartUtils.showErrorDialog(
                context, 'Please select at least one Gender');
          }
        } else {
          SmartUtils.showErrorDialog(
              context, 'Please select at least one Earning');
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
          child: const Text(
            'Continue',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                fontFamily: 'Muli',
                color: Colors.white),
          ),
        ),
      ),
    ); //signuo screen 1
  }

  Widget _getAppBarUI() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      padding: EdgeInsets.only(top: 10, right: 0),
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

  Widget buildRow(int index) {
    return Container(
      height: 40,
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: RaisedButton(
        color: this.alldata.whoEarn[index].isSelected == true
            ? SmartUtils.blueBackground
            : SmartUtils.themeGrayColor,
        onPressed: () {
          this.alldata.whoEarn[index].isSelected =
              !this.alldata.whoEarn[index].isSelected;
          if (mounted) {
            setState(() {});
          }
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
        padding: const EdgeInsets.all(0.0),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          child: this.alldata.whoEarn[index].isSelected == true
              ? Container(
                  constraints:
                      const BoxConstraints(minWidth: 100.0, maxHeight: 30.0),
                  alignment: Alignment.center,
                  child: Text(
                    this.alldata.whoEarn[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: "Muli",
                    ),
                  ),
                )
              : Container(
                  constraints:
                      const BoxConstraints(minWidth: 100.0, maxHeight: 30.0),
                  alignment: Alignment.center,
                  child: Text(
                    this.alldata.whoEarn[index].title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontFamily: "Muli",
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
