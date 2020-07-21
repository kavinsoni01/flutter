// import 'package:flutter/cupertino.dart';

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simposi/Screens/LoginScreen.dart';
import 'package:simposi/Screens/SignupScreens/SignupScreen2.dart';
import 'package:simposi/String/validation_message.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Models/SignupModel.dart';
import 'package:simposi/Utils/Utility/ApiClass.dart';
import 'package:simposi/Utils/Utility/ModelClass.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/colors.dart';
import 'package:simposi/Utils/smartutils.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SignupScreen1 extends StatefulWidget {
  @override
  _SignupScreen1State createState() => _SignupScreen1State();
}

class _SignupScreen1State extends State<SignupScreen1> {
  bool isObscureRepeat = true;
  bool isObscurePassword = true;
  LocationData _locationData; //= LocationData();

  double lat = 00;
  double long = 00;
  Location location;

//  AllDataModel alldata;

  SharedPreferences preferences;

  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtName = new TextEditingController();
  // TextEditingController txtCity = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  TextEditingController txtConfirmPassword = new TextEditingController();
  TextEditingController txtPostalCode = new TextEditingController();

  FocusNode emailFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  // FocusNode cityFocusNode = new FocusNode();
  FocusNode repeatPasswordFocusNode = new FocusNode();
  FocusNode yourNameFocusNode = new FocusNode();
  FocusNode postalCodeFocusNode = new FocusNode();

  String errorText = '';
  bool isNameValidation = false;
  bool isEmailValidation = false;
  bool isPostalCodeValidation = false;
  bool isPasswordValidation = false;
  bool isRepeatValidation = false;

  File selectImage;
  AppMultiPartFile uploadfile;

  Future getImage() async {
    var getImage = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    if (mounted) {
      setState(() {
        selectImage = getImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);

    return Scaffold(
        extendBodyBehindAppBar: true,
        body: GestureDetector(
          child: _MainBody(),
          onTap: () => {
            FocusScope.of(context).requestFocus(new FocusNode()),
          },
        ));
  }

  @override
  void initState() {
    //
    super.initState();
    init();

    yourNameFocusNode.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    repeatPasswordFocusNode.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    passwordFocusNode.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    emailFocusNode.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    postalCodeFocusNode.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    findCurrentLocation();
  }

  void init() async {
    preferences = await SharedPreferences.getInstance();

    //  this.();
  }

  Future<void> findCurrentLocation() async {
    location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
      _locationData = currentLocation;
      lat = _locationData.latitude;
      long = _locationData.longitude;
      if (mounted) {
        setState(() {});
      }
    });
  }

  Widget _MainBody() {
    // print(MediaQuery.of(context).size.height);
    return Container(
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.all(0),
            physics: BouncingScrollPhysics(), //
            scrollDirection: Axis.vertical,
            child: Container(
              color: Colors.white,
              height:
                  896, //+ MediaQuery.of(context).padding.top,//MediaQuery.of(context).size.height ,// + MediaQuery.of(context).padding.top,
              width: MediaQuery.of(context).size.width,
              // margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top ),

              child: Stack(
                children: <Widget>[
                  Container(
                    //  margin: EdgeInsets.only(top: 220),

                    child: Column(
                      children: <Widget>[
                        Container(
                          //  margin: EdgeInsets.only(top: 185),
                          margin: EdgeInsets.only(left: 80, right: 80, top: 72),
                          alignment: Alignment.center,
                          height: 50,
                          child: Text(
                            'Sign up and start \nmeeting new people',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey, //AppColors.primaryText,
                              fontFamily: "Helvetica",
                              fontWeight: FontWeight.w400,
                              fontSize: 19,
                              height: 1.26316,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),

                        profileImageWidget(),
                        //

                        SizedBox(height: 0),

                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        yourNameTextForm(),
                        emailTextForm(),
                        postalCodeTextForm(),
                        // cityTextForm(),
                        passWordTextForm(),
                        repeatPassWordTextForm(),

                        Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 0, left: 40, right: 40),
                          child: SubmitButton(),
                        ),

                        //  SizedBox(height:MediaQuery.of(context).size.height.toDouble() < 750 ? 100 : 0),
                        //   7405559681
                        // Spacer(),
                        SizedBox(
                          height: 120,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(bottom: 28),
                          child: GestureDetector(
                            child: Center(
                              child: Text('Log In',
                                  style: TextStyle(
                                    color: SmartUtils.blueBackground,
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  )),
                            ),
                            //
                            onTap: () => {
                              //open Privacy screen
                              // Navigator.pop(context), //pop dialog
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (_) => LoginScreen()),
                                  (Route<dynamic> route) => false),
                            },
                          ),
                        ),

                        Container(
                          // margin: MediaQuery.of(context).size.height - 150,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(bottom: 26),

                          child: GestureDetector(
                            child: Center(
                              child: Text('Privacy Terms Of Use',
                                  style: TextStyle(
                                    color: AppColors.accentText,
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                  )),
                            ),
                            onTap: () => {
                              //open Privacy screen
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  } //

  Widget profileImageWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120.0,
      color: Colors.white,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 00.0),
            child: new Stack(fit: StackFit.passthrough, children: <Widget>[
              new Container(
                  width: 100.0,
                  height: 100.0,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: ClipOval(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: new BoxDecoration(
                          // color: const Color(0xff7c94b6),
                          // border: Border.all(color: Colors.red, width: 5.0),
                          image: DecorationImage(
                            image: selectImage == null
                                ? new ExactAssetImage(
                                    "assets/combinedShape@3x.png")
                                : new ExactAssetImage(selectImage.path),
                            fit: BoxFit.cover,
                          ),
                          borderRadius:
                              new BorderRadius.all(const Radius.circular(80.0)),
                        ),
                        alignment: FractionalOffset.centerLeft,
                      ),

                      // FadeInImage.assetNetwork(
                      // fit: BoxFit.cover,
                      // placeholder: "assets/combinedShape@3x.png",
                      // image: selectImage//preferences.getString('imagePath')
                      // ),
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: 75, left: 75),
                child: GestureDetector(
                  child: new Image.asset(
                    "assets/add@3x.png",
                    fit: BoxFit.cover,
                    width: 20,
                    height: 20,
                  ),
                  onTap: () => {
                    // CupertinoThemeData(
                    //   textTheme:Colors.black,

                    // )
                    _pickImage(),
                  },
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Widget yourNameTextForm() {
    return Container(
      height: isNameValidation == true ? 80 : 60,
      margin: EdgeInsets.only(top: 10, bottom: 5, left: 40, right: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onTap: () {
          isNameValidation = false;
          if (mounted) {
            setState(() {});
          }
        },
        style: TextStyle(
            color: Colors.grey, //AppColors.primaryText,
            fontSize: 18),
        focusNode: yourNameFocusNode,
        controller: txtName,
        decoration: InputDecoration(
          contentPadding:
              new EdgeInsets.symmetric(vertical: 16.0, horizontal: 28.0),
          errorText: isNameValidation == true ? errorText : null,
          hintText: '',
          errorStyle: TextStyle(
            color: Color.fromARGB(255, 255, 1, 126),
            fontFamily: "Muli",
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 1, 126),
            ),
            // borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(30),
          ),
          labelText: 'Your Name',
          labelStyle: TextStyle(
            fontFamily: 'Muli',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: this.yourNameFocusNode.hasFocus == false
                ? Colors.grey
                : SmartUtils.blueBackground,
          ),
          // focusColor: SmartUtils.blueBackground,
          // hoverColor:SmartUtils.blueBackground,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          hintStyle: TextStyle(
            color: SmartUtils.lightGrayBackground,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: SmartUtils.blueBackground),

            // borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(25),
          ),
          // contentPadding: EdgeInsets.only(left:30,top: 15,right: 15,bottom: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget emailTextForm() {
    return Container(
      height: isEmailValidation == true ? 80 : 60,
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 40, right: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onTap: () {
          isEmailValidation = false;
          if (mounted) {
            setState(() {});
          }
        },
        style: TextStyle(
            color: Colors.grey, //AppColors.primaryText,
            fontSize: 18),
        focusNode: emailFocusNode,
        controller: txtEmail,
        decoration: InputDecoration(
          errorText: isEmailValidation == true ? errorText : null,
          hintText: '',
          errorStyle: TextStyle(
            color: Color.fromARGB(255, 255, 1, 126),
            fontFamily: "Muli",
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),

          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 1, 126),
            ),
            // borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(30),
          ),
          labelText: 'Email Address',
          labelStyle: TextStyle(
            fontFamily: 'Muli',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: this.emailFocusNode.hasFocus == false
                ? Colors.grey
                : SmartUtils.blueBackground,
          ),
          // focusColor: SmartUtils.blueBackground,
          // hoverColor:SmartUtils.blueBackground,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          hintStyle: TextStyle(
            color: SmartUtils.lightGrayBackground,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: SmartUtils.blueBackground),

            // borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding:
              new EdgeInsets.symmetric(vertical: 16.0, horizontal: 28.0),

          // contentPadding: EdgeInsets.only(left:30,top: 15,right: 15,bottom: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget postalCodeTextForm() {
    return Container(
      height: isPostalCodeValidation == true ? 80 : 60,
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 40, right: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onTap: () {
          isPostalCodeValidation = false;
          if (mounted) {
            setState(() {});
          }
        },
        style: TextStyle(
            color: Colors.grey, //AppColors.primaryText,
            fontSize: 18),
        focusNode: postalCodeFocusNode,
        keyboardType: TextInputType.text,
        controller: txtPostalCode,
        decoration: InputDecoration(
          errorText: isPostalCodeValidation == true ? errorText : null,
          hintText: '',
          errorStyle: TextStyle(
            color: Color.fromARGB(255, 255, 1, 126),
            fontFamily: "Muli",
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 1, 126),
            ),
            // borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(30),
          ),
          suffixIcon: IconButton(
              onPressed: () => {},
              icon: Image.asset(
                "assets/search@3x.png",
                height: 15,
                width: 15,
              )),
          labelText: 'Postal Code',
          labelStyle: TextStyle(
            fontFamily: 'Muli',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: this.postalCodeFocusNode.hasFocus == false
                ? Colors.grey
                : SmartUtils.blueBackground,
          ),
          // focusColor: SmartUtils.blueBackground,
          // hoverColor:SmartUtils.blueBackground,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          hintStyle: TextStyle(
            color: SmartUtils.lightGrayBackground,
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: SmartUtils.blueBackground),

            // borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(25),
          ),
          contentPadding:
              new EdgeInsets.symmetric(vertical: 16.0, horizontal: 28.0),

          // contentPadding: EdgeInsets.only(left:30,top: 15,right: 15,bottom: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget passWordTextForm() {
    return Container(
      height: isPasswordValidation == true ? 80 : 60,
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 40, right: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onTap: () {
          isPasswordValidation = false;
          if (mounted) {
            setState(() {});
          }
        },
        style: TextStyle(
            color: Colors.grey, //AppColors.primaryText,
            fontSize: 18),
        focusNode: passwordFocusNode,
        controller: txtPassword,
        obscureText: isObscurePassword,
        decoration: InputDecoration(
          errorText: isPasswordValidation == true ? errorText : null,
          hintText: '',
          errorStyle: TextStyle(
            color: Color.fromARGB(255, 255, 1, 126),
            fontFamily: "Muli",
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 1, 126),
            ),
            // borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(30),
          ),
          suffixIcon: IconButton(
              onPressed: () => {
                    if (mounted)
                      {
                        setState(() {
                          isObscurePassword = !isObscurePassword;
                        })
                      }
                  },
              icon: isObscurePassword == true
                  ? Image.asset(
                      "assets/hidden@3x.png",
                      height: 15,
                      width: 15,
                    )
                  : Image.asset(
                      "assets/eye@3x.png",
                      height: 15,
                      width: 15,
                    )),
          labelText: 'Password',
          labelStyle: TextStyle(
            fontFamily: 'Muli',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: this.passwordFocusNode.hasFocus == false
                ? Colors.grey
                : SmartUtils.blueBackground,
          ),
          // focusColor: SmartUtils.blueBackground,
          // hoverColor:SmartUtils.blueBackground,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          hintStyle: TextStyle(
            color: SmartUtils.lightGrayBackground,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: SmartUtils.blueBackground),

            // borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(25),
          ),
          // contentPadding: EdgeInsets.only(left:30,top: 15,right: 15,bottom: 15),
          contentPadding:
              new EdgeInsets.symmetric(vertical: 16.0, horizontal: 28.0),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  void _validateInputs() {
    if (txtName.text == '') {
      // SmartUtils.showErrorDialog(context, ValidationMessage.enter_name);
      isNameValidation = true;
      errorText = ValidationMessage.enter_name;
      yourNameFocusNode.unfocus();
      if (mounted) {
        setState(() {});
      }
    } else if (txtEmail.text == '') {
      isEmailValidation = true;
      errorText = ValidationMessage.enter_email;
      emailFocusNode.unfocus();
      if (mounted) {
        setState(() {});
      }
      // SmartUtils.showErrorDialog(context, ValidationMessage.enter_email);
    } else if (txtPostalCode.text == '') {
      // SmartUtils.showErrorDialog(context, ValidationMessage.enter_postalcode);

      isPostalCodeValidation = true;
      errorText = ValidationMessage.enter_postalcode;
      postalCodeFocusNode.unfocus();
      if (mounted) {
        setState(() {});
      }
    }
    //  else if  (txtCity.text == ''){
    //           SmartUtils.showErrorDialog(context, ValidationMessage.enter_city);
    //  }
    else if (txtPassword.text == '') {
      // SmartUtils.showErrorDialog(context, ValidationMessage.enter_password);
      isPasswordValidation = true;
      errorText = ValidationMessage.enter_password;
      passwordFocusNode.unfocus();
      if (mounted) {
        setState(() {});
      }
    } else if (txtPassword.text.length < 6) {
      isPasswordValidation = true;
      errorText = ValidationMessage.password_valid;
      passwordFocusNode.unfocus();
      if (mounted) {
        setState(() {});
      }
      // SmartUtils.showErrorDialog(context, ValidationMessage.password_valid);
    } else if (txtConfirmPassword.text == '') {
      isRepeatValidation = true;
      errorText = ValidationMessage.enter_repeat_password;
      repeatPasswordFocusNode.unfocus();
      if (mounted) {
        setState(() {});
      }
      // SmartUtils.showErrorDialog(context, ValidationMessage.enter_repeat_password);
    } else if (txtPassword.text != txtConfirmPassword.text) {
      isRepeatValidation = true;
      errorText = ValidationMessage.password_not_match;
      repeatPasswordFocusNode.unfocus();
      if (mounted) {
        setState(() {});
      }
      // SmartUtils.showErrorDialog(context, ValidationMessage.password_not_match);
    } else {
      Pattern emailpattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regexemail = new RegExp(emailpattern);

      // _formKey.currentState.save();

      if (regexemail.hasMatch(txtEmail.text)) {
        //  callLoginCheckApi();

        var signupModel = SignupModel();
        signupModel.email = txtEmail.text;
        signupModel.password = txtPassword.text;
        signupModel.name = txtName.text;
        signupModel.postalCode = txtPostalCode.text;
        signupModel.selectImage = this.selectImage;
        signupModel.latitude = this.lat.toString();
        signupModel.longitude = this.long.toString();
        signupModel.is_new = 1;
        callSignUpApiFromSignupGmail(signupModel);
      } else {
        // SmartUtils.showErrorDialog(context, ValidationMessage.email_valid);
        isEmailValidation = true;
        errorText = ValidationMessage.email_valid;
        emailFocusNode.unfocus();
        if (mounted) {
          setState(() {});
        }
      }
    }
  }

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

  void callSignUpApiFromSignupGmail(SignupModel signupModel) async {
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

    // signupModel.selectImage = testCompressFile(signupModel.selectImage) as File;

    AppMultiPartFile uploadfile =
        AppMultiPartFile(localFile: signupModel.selectImage, key: 'Image');

    //TODO : CALL signup Api Here
    var request = RegisterRequestNew();
    request.name = signupModel.name;
    request.email = signupModel.email;
    request.password = signupModel.password;
    request.postalCode = signupModel.postalCode;
    request.city = 'city'; //signupModel.city;
    request.latitude = signupModel.latitude;
    request.longititude = signupModel.longitude;
    request.deviceToken = 'device token';
    request.languageId = '1';
    request.is_new = 1;

    List<AppMultiPartFile> arrFile;
    if (uploadfile.localFile != null) {
      arrFile = [uploadfile];
    }

    RegisterResponse response =
        await ApiProvider().callSignupAPI(params: request, arrFile: arrFile);

    Navigator.pop(context); //pop dialog

    new Future.delayed(new Duration(seconds: 1), () {
      if (response.status == true) {
        // SmartUtils.showErrorDialog(context, response.message);
        new Future.delayed(new Duration(seconds: 2), () {
          this.setDataInToUserModel(response.userModel, preferences);

          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignupScreen2()));
        });
        //   this.setDataInToUserModel(response.user, preferences);
      } else if (response.message == 'This email has already account.') {
        isEmailValidation = true;
        errorText = response.message;
        emailFocusNode.unfocus();
        if (mounted) {
          setState(() {});
        }
      } else {
        SmartUtils.showErrorDialog(context, response.message);
      }
      // }
    });

    // }
    // return response;
  }

  // Navigator.pop(context); //pop dialog

  //   new Future.delayed(new Duration(seconds: 1), () {
  //     print(response);
  //     if (response.status == true) {
  //       this.setDataInToUserModel(response.userModel, preferences);
  //       if (response.userModel.is_registration_incompleted == 0) {
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => MainTabView()));
  //       } else {
  //         Navigator.push(context,
  //             MaterialPageRoute(builder: (context) => SignupScreen2()));
  //       }
  //     } else {
  //       //  SmartUtils.showErrorDialog(context, response.message);
  //       isEmailValidation = true;
  //       emailError = response.message;
  //       emailFocusNode.unfocus();

  //       setState(() {});
  //     }
  //   });
  // }

  void setDataInToUserModel(UserModel model, prefs) {
    prefs.setInt("status", model.status);
    prefs.setString("email", model.email);
    prefs.setString("apiAccessToken", model.apiAccessToken);
    prefs.setString("gender", model.gender);
    prefs.setString("phone", model.phone);
    prefs.setString("postalcode", model.postalcode);
    prefs.setString("profilePhoto", model.profilePhoto);
    prefs.setString("userName", model.userName);
  }

  Widget repeatPassWordTextForm() {
    return Container(
      height: isRepeatValidation == true ? 80 : 60,
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 40, right: 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        onTap: () {
          isRepeatValidation = false;
          if (mounted) {
            setState(() {});
          }
        },
        style: TextStyle(
            color: Colors.grey, //AppColors.primaryText,
            fontSize: 18),
        focusNode: repeatPasswordFocusNode,
        controller: txtConfirmPassword,
        obscureText: isObscureRepeat,
        decoration: InputDecoration(
          errorText: isRepeatValidation == true ? errorText : null,
          hintText: '',
          errorStyle: TextStyle(
            color: Color.fromARGB(255, 255, 1, 126),
            fontFamily: "Muli",
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 1, 126),
            ),
            // borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(30),
          ),
          suffixIcon: IconButton(
              onPressed: () => {
                    if (mounted)
                      {
                        setState(() {
                          isObscureRepeat = !isObscureRepeat;
                        })
                      }
                  },
              icon: isObscureRepeat == true
                  ? Image.asset(
                      "assets/hidden@3x.png",
                      height: 15,
                      width: 15,
                    )
                  : Image.asset(
                      "assets/eye@3x.png",
                      height: 15,
                      width: 15,
                    )),
          //  hintText: 'Repeat Password',
          labelText: 'Repeat Password',
          labelStyle: TextStyle(
            fontFamily: 'Muli',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: this.repeatPasswordFocusNode.hasFocus == false
                ? Colors.grey
                : SmartUtils.blueBackground,
          ),
          // focusColor: SmartUtils.blueBackground,
          // hoverColor:SmartUtils.blueBackground,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          hintStyle: TextStyle(
            color: SmartUtils.lightGrayBackground,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: SmartUtils.blueBackground),

            // borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            borderRadius: BorderRadius.circular(25),
          ),
          contentPadding:
              EdgeInsets.only(left: 30, top: 15, right: 15, bottom: 15),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
// InputDecoration inputDecoration5 =

  InputDecoration inputDecorationPass = InputDecoration(
    labelText: 'Password',
    labelStyle: TextStyle(color: SmartUtils.blueBackground),

    // focusColor: SmartUtils.blueBackground,
    // hoverColor:SmartUtils.blueBackground,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    hintStyle: TextStyle(
      color: Colors.grey, // AppColors.primaryText,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: SmartUtils.blueBackground),

      // borderSide: const BorderSide(color: Colors.grey, width: 0.0),
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: EdgeInsets.all(16),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: Colors.grey),
//lo
    ),
  );

//
  Widget SubmitButton() {
    return RaisedButton(
      color: SmartUtils.blueBackground,
      onPressed: () {
        // TODO: Api Call  Here
        _validateInputs();
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
              color: AppColors.secondaryText,
              fontFamily: "Muli",
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ),
      ),
    ); //signup screen 1
  }

  Widget imagePicker() {
    return new FloatingActionButton(
      onPressed: getImage,
      tooltip: 'Pick Image',
      child: Icon(Icons.add_a_photo),
    );
  }

  void _pickImage() async {
    final imageSource = await showCupertinoModalPopup<ImageSource>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        message: Text("Upload Image From "),
        actions: <Widget>[
          CupertinoActionSheetAction(
            child: const Text('Camera'),
            onPressed: () {
              Navigator.pop(context, ImageSource.camera);
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Gallery'),
            onPressed: () {
              Navigator.pop(context, ImageSource.gallery);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );

    if (imageSource != null) {
      final file =
          await ImagePicker.pickImage(source: imageSource, imageQuality: 50);
      if (file != null) {
        if (mounted) {
          setState(() => selectImage = file as File);
        }
      }
    }
  }
}
