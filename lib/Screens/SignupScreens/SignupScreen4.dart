import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:simposi/Screens/SignupScreens/SignupScreen5.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Models/SignupModel.dart';
import 'package:simposi/Utils/Utility/colors.dart';
import 'package:simposi/Utils/smartutils.dart';

class Signupscreen4 extends StatefulWidget {
  final AllDataModel alldata;
  final SignupModel signupModel;

  Signupscreen4({@required this.signupModel, this.alldata});

  @override
  _Signupscreen4State createState() =>
      _Signupscreen4State(signupModel: this.signupModel, alldata: this.alldata);
}

class _Signupscreen4State extends State<Signupscreen4> {
  List<Profession> professionSearch;

  // int selectedGender = -1;
  TextEditingController txtSearch;

  String searchkeyword = '';
  // bool searchShouldCall = true;

  final SignupModel signupModel;
  final AllDataModel alldata;

  _Signupscreen4State({@required this.signupModel, this.alldata});

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
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            _getAppBarUI(),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              alignment: Alignment.center,
              height: 30,
              child: Text(
                'What\'s your profession..',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.w400,
                  fontSize: 19,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 20,
              child: Text(
                'Choose one or more professions to set up your feed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.accentText,
                  fontFamily: "Muli",
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(31, 142, 142, 147),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                height: 40,
                margin: EdgeInsets.only(left: 20, right: 20),
                // color: SmartUtils.lightGrayBackground,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 15),
                    Image.asset(
                      "assets/Search2@3x.png",
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(width: 15),
                    Container(
                      height: 40,
                      width: 200,
                      child: TextFormField(
                        controller: txtSearch,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        style: TextStyle(
                            color: SmartUtils.blueBackground, fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        validator: (String email) {
                          return null;
                        },
                        onEditingComplete: () {
                          professionSearch = [];

                          this.alldata.profession.forEach((element) {
                            if (element.title
                                .toLowerCase()
                                .contains(searchkeyword.toLowerCase())) {
                              professionSearch.add(element);
                            }
                          });
                          //   if (searchShouldCall == true){
                          if (mounted) {
                            setState(() {
                              //       // searchShouldCall = false;
                            });
                          }
                          // }
                        },
                        onChanged: (String value) {
                          // searchShouldCall = true;
                          searchkeyword = value.trim();

                          professionSearch = [];

                          this.alldata.profession.forEach((element) {
                            if (element.title
                                .toLowerCase()
                                .contains(searchkeyword.toLowerCase())) {
                              professionSearch.add(element);
                            }
                          });
                          //   if (searchShouldCall == true){
                          if (mounted) {
                            setState(() {
                              //       // searchShouldCall = false;
                            });
                          }
                        },
                        onSaved: (String val) {
                          searchkeyword = val.trim();
                        },
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 00),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new SizedBox(
                    height: 10.0,
                  ),
                  new Wrap(
                    spacing: 10.0,
//searchkeyword == '' ? this.alldata.profession.length : this.alldata.profession
                    children: new List.generate(
                        searchkeyword == ''
                            ? this.alldata.profession.length
                            : professionSearch.length,
                        (index) => searchkeyword == ''
                            ? Container(
                                child: GestureDetector(
                                  child: Chip(
                                      label: new Text(
                                        alldata.profession[index].title,
                                        style: TextStyle(
                                            color: alldata.profession[index]
                                                    .isSelected
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Muli'),
                                      ),
                                      backgroundColor:
                                          alldata.profession[index].isSelected
                                              ? SmartUtils.blueBackground
                                              : SmartUtils.themeGrayColor),
                                  onTap: () => {
                                    alldata.profession[index].isSelected =
                                        !alldata.profession[index].isSelected,
                                    setState(() {}),
                                  },
                                ),
                              )
                            : Container(
                                child: GestureDetector(
                                  child: Chip(
                                      label: new Text(
                                        professionSearch[index].title,
                                        style: TextStyle(
                                            color: professionSearch[index]
                                                    .isSelected
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Muli'),
                                      ),
                                      backgroundColor:
                                          professionSearch[index].isSelected
                                              ? SmartUtils.blueBackground
                                              : SmartUtils.themeGrayColor),
                                  onTap: () => {
                                    professionSearch[index].isSelected =
                                        !professionSearch[index].isSelected,
                                    setState(() {}),
                                  },
                                ),
                              )),
                  ),
                  new SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } //

  Widget buildRow(int index) {
    return Chip(
        label: new Text(
          alldata.profession[index].title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: SmartUtils.blueBackground);
  }

  Widget _getAppBarUI() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      padding: EdgeInsets.only(top: 10, right: 10),
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
                  width: 225,
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
                onTap: () => Navigator.of(context).pop()),
          ),
          // Row(
          //   children: <Widget>[
          //     Container(
          //       width:(MediaQuery.of(context).size.width * 0.75 ),
          //       height: 2,
          //       color: SmartUtils.blueBackground,
          //     ),
          //     Container(
          //       width:MediaQuery.of(context).size.width/4-20,
          //       height: 2,
          //       color: SmartUtils.progressLighBlueColor,
          //     )

          //   ],
          //   ),
          // IconButton(
          //     icon: new Icon(
          //       Icons.arrow_back_ios,
          //       color: Colors.grey,
          //     ),
          // onPressed: () => Navigator.of(context).pop()),
        ],
      ),
    );
  }

  Widget continueButton() {
    return RaisedButton(
      color: SmartUtils.blueBackground,
      onPressed: () {
        // TODO: Api Call  Here

        var selectArr = List<Profession>();
        // signupModel.selectedGeneration = this.generationIdentify;
        this.alldata.profession.forEach((element) {
          if (element.isSelected == true) {
            selectArr.add(element);
          }
        });
        if (selectArr.length > 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SignupScreen5(
                      signupModel: this.signupModel, alldata: this.alldata)));
        } else {
          SmartUtils.showErrorDialog(
              context, 'Please select at least one Profession');
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
    );
  }
}
