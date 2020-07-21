import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simposi/Screens/LoginScreen.dart';
import 'package:simposi/Screens/TabViewController/mainTabView.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Models/SignupModel.dart';
import 'package:simposi/Utils/Utility/ApiClass.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/colors.dart';
import 'package:simposi/Utils/smartutils.dart';
import 'dart:io';

class SignupScreen6 extends StatefulWidget {
  final AllDataModel alldata;
  final SignupModel signupModel;

  SignupScreen6({@required this.signupModel, this.alldata});

  @override
  _SignupScreen6State createState() =>
      _SignupScreen6State(signupModel: this.signupModel, alldata: this.alldata);
}

class _SignupScreen6State extends State<SignupScreen6> {
//
  int selectedGender = -1;
  TextEditingController txtSearch;
  List<Interest> professionSearch;

  String searchkeyword = '';

  final SignupModel signupModel;
  final AllDataModel alldata;

  _SignupScreen6State({@required this.signupModel, this.alldata});

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
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _getAppBarUI(),
              Container(
                //  margin: EdgeInsets.only(top: 185),
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                alignment: Alignment.center,
                height: 30,
                child: Text(
                  'Almost done,tell us what you like',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Container(
                alignment: Alignment.center,
                height: 20,
                child: Text(
                  'Choose as many interests as you like',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.accentText,
                    fontFamily: "Helvetica",
                    fontWeight: FontWeight.w400,
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
                            style: TextStyle(
                                fontFamily: 'Muli',
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryText,
                                fontSize: 16),
                            decoration: InputDecoration(
                              hintText: 'Search',
                              border: InputBorder.none,
                              // focusColor: SmartUtils.blueBackground,
                              // hoverColor:SmartUtils.blueBackground,

                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            onChanged: (String value) {
                              // searchShouldCall = true;
                              searchkeyword = value.trim();

                              professionSearch = [];

                              this.alldata.interest.forEach((element) {
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
                            }),
                      ),
                    ],
                  )),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Wrap(
                      spacing: 10.0,
//searchkeyword == '' ? this.alldata.profession.length : this.alldata.profession
                      children: new List.generate(
                          searchkeyword == ''
                              ? this.alldata.interest.length
                              : professionSearch.length,
                          (index) => searchkeyword == ''
                              ? Container(
                                  child: GestureDetector(
                                    child: Chip(
                                        label: new Text(
                                          alldata.interest[index].title,
                                          style: TextStyle(
                                              color: alldata.interest[index]
                                                      .isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'Muli'),
                                        ),
                                        backgroundColor:
                                            alldata.interest[index].isSelected
                                                ? SmartUtils.blueBackground
                                                : SmartUtils.themeGrayColor),
                                    onTap: () => {
                                      alldata.interest[index].isSelected =
                                          !alldata.interest[index].isSelected,
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

                      // new Wrap(
                      //   spacing: 10.0,
                      //   children: new List.generate(
                      //     this.alldata.interest.length,
                      //     (index) => Container(
                      //       child: GestureDetector(
                      //         child: Chip(
                      //             label: new Text(
                      //               alldata.interest[index].title,
                      //               style: TextStyle(
                      //                   color: alldata.interest[index].isSelected
                      //                       ? Colors.white
                      //                       : Colors.black,
                      //                   fontSize: 14,
                      //                   fontFamily: 'Muli',
                      //                   fontWeight: FontWeight.w700),
                      //             ),
                      //             backgroundColor:
                      //                 alldata.interest[index].isSelected
                      //                     ? SmartUtils.blueBackground
                      //                     : SmartUtils.themeGrayColor),
                      //         onTap: () => {
                      //           alldata.interest[index].isSelected =
                      //               !alldata.interest[index].isSelected,
                      //           setState(() {}),
                      //         },
                      //       ),
                      //     ),
                      // ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  } //

//APi call for register

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

//
  void callSignUpApiFromSignupGmail(
      SignupModel signupModel, AllDataModel allDataModel) async {
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

// selectImage

    // File isSelectImage;

    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    String name = preferences.getString('userName');
    String email = preferences.getString('email');
    String postalcode = preferences.getString('postalcode');
    String profileImage = preferences.getString('profilePhoto');

    // AppMultiPartFile uploadfile = AppMultiPartFile(localFile: signupModel.selectImage, key: 'Image');
    // AppMultiPartFile uploadfile = NetworkToFileImage(
    //         url: profileImage,
    //         file: myFile);

    //TODO : CALL signup Api Here
    var request = NewUpdateProfileRequest();
    request.name = name;
    request.meet = signupModel.meet; //'Female';
    request.email = email;
    request.gender = signupModel.gender == 0 ? 'Male' : 'Female'; //'Male';
    request.postalCode = postalcode;
    request.city = 'city'; //signupModel.city;
    request.distance = signupModel.distance.toString();
    request.languageId = '1';
    request.is_new = 1;
    // request.facebookLink = '';
    // request.instagramLink = '';
    // request.linkedinLink = '';
    var whatYouLikeString = '';
    allDataModel.interest.forEach((element) {
      if (element.isSelected == true) {
        if (whatYouLikeString != '') {
          whatYouLikeString =
              whatYouLikeString + ',' + element.whatYouLikeId.toString();
        } else {
          whatYouLikeString = element.whatYouLikeId.toString();
        }
      }
    });
    request.likes = '[' + whatYouLikeString + ']';

    var generationIdentifyString = '';
    allDataModel.generationIdentify.forEach((element) {
      if (element.isSelected == true) {
        if (generationIdentifyString != '') {
          generationIdentifyString = generationIdentifyString +
              ',' +
              element.generationsIdentifyId.toString();
        } else {
          generationIdentifyString = element.generationsIdentifyId.toString();
        }
      }
    });

    request.generation = '[' + generationIdentifyString + ']';

    var whoEarnString = '';
    allDataModel.whoEarn.forEach((element) {
      if (element.isSelected == true) {
        if (whoEarnString != '') {
          whoEarnString = whoEarnString + ',' + element.whoEarnsId.toString();
        } else {
          whoEarnString = element.whoEarnsId.toString();
        }
      }
    });

    request.earning = '[' + whoEarnString + ']';

    var professionString = '';
    allDataModel.profession.forEach((element) {
      if (element.isSelected == true) {
        if (professionString != '') {
          professionString =
              professionString + ',' + element.professionId.toString();
        } else {
          professionString = element.professionId.toString();
        }
      }
    });

    request.profession = '[' + professionString + ']'; //'[2,3]';
    // request.latitude = '17.3423'; //signupModel.latitude
    // request.longititude = '92.28782'; //signupModel.longititude
    request.deviceToken = 'abcsddsdsdfsdf'; //signupModel.deviceToken

    List<AppMultiPartFile> arrFile;
    // if (uploadfile.localFile != null) {
    //   arrFile = [uploadfile];
    // }

    UpdateProfileResponse response = await ApiProvider()
        .callUpdateProfileAfterSignUp(params: request, arrFile: arrFile);

    Navigator.pop(context); //pop dialog

    new Future.delayed(new Duration(seconds: 1), () {
      if (response.status == true) {
        SmartUtils.showErrorDialog(context, response.message);

        new Future.delayed(new Duration(seconds: 2), () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => LoginScreen()),
              (Route<dynamic> route) => false);

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => MainTabView()));

          // Navigator.of(context).pushAndRemoveUntil(
          //       MaterialPageRoute(builder: (_) => LoginScreen()),
          //       (Route<dynamic> route) => false);
        });
        //   this.setDataInToUserModel(response.user, preferences);
      } else {
        SmartUtils.showErrorDialog(context, response.message);
      }
    });

    // }
    // return response;
  }

  Widget _getAppBarUI() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      padding: EdgeInsets.only(top: 10, bottom: 10),
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
        var selectArr = List<Interest>();
        // signupModel.selectedGeneration = this.generationIdentify;
        this.alldata.interest.forEach((element) {
          if (element.isSelected == true) {
            selectArr.add(element);
          }
        });
        if (selectArr.length > 0) {
          this.callSignUpApiFromSignupGmail(this.signupModel, this.alldata);
        } else {
          SmartUtils.showErrorDialog(
              context, 'Please select at least one interest');
        }

        // Navigator.push(context, MaterialPageRoute(builder: (context) => MainTabView()));
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
