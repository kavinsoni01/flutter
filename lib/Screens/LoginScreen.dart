import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simposi/Screens/SignupScreens/SignupScreen2.dart';
import 'package:simposi/Screens/TabViewController/HomeEventScreen.dart';
import 'package:simposi/Screens/TabViewController/mainTabView.dart';
import 'package:simposi/String/validation_message.dart';
import 'package:simposi/Utils/Utility/ModelClass.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/colors.dart';
import 'package:simposi/Utils/smartutils.dart';
import 'SignupScreens/SignupScreen1.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  SharedPreferences preferences;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode emailFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  FocusNode forgotEmailFocusNode = new FocusNode();

  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtPassword = new TextEditingController();
  TextEditingController txtForgotEmail = new TextEditingController();
  String emailError = 'Please enter email address';
  bool isObscure = true;

  bool isEmailValidation = false;
  bool isPasswordValidation = false;

  void _init() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);

    return Scaffold(
        extendBodyBehindAppBar: true,
        // backgroundColor: SmartUtils.blueBackground,//Colors.white,//
        body: GestureDetector(
          child: _MainBody(),
          onTap: () => {
            FocusScope.of(context).requestFocus(new FocusNode()),
          },
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();

    passwordFocusNode.addListener(() {
      setState(() {});
    });

    emailFocusNode.addListener(() {
      setState(() {});
    });

    forgotEmailFocusNode.addListener(() {
      setState(() {});
    });
  }

  void _validateInputs() {
    if (txtEmail.text == '') {
      // SmartUtils.showErrorDialog(context, ValidationMessage.enter_email);
      isEmailValidation = true;
      emailError = ValidationMessage.enter_email;
      emailFocusNode.unfocus();

      setState(() {});
    } else if (txtPassword.text == '') {
      isPasswordValidation = true;
      passwordFocusNode.unfocus();
      setState(() {});

      // SmartUtils.showErrorDialog(context, ValidationMessage.enter_password);
    } else {
      Pattern emailpattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regexemail = new RegExp(emailpattern);

      // _formKey.currentState.save();

      if (regexemail.hasMatch(txtEmail.text)) {
        callLoginCheckApi();
      } else {
        isEmailValidation = true;
        emailError = ValidationMessage.email_valid;
        emailFocusNode.unfocus();

        setState(() {});

        // SmartUtils.showErrorDialog(context, ValidationMessage.email_valid);
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

  void callLoginCheckApi() async {
    //TODO : call login Api Here

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

    LoginCheckRequest request = LoginCheckRequest();
    request.email = this.txtEmail.text;
    request.password = this.txtPassword.text;
    String deviceToken = preferences.getString('deviceToken');
    if (deviceToken != null) {
      request.device_token = deviceToken;
    } else {
      request.device_token = "abcdegd";
    }

    LoginCheckResponse response =
        await ApiProvider().callLogin(params: request);

    Navigator.pop(context); //pop dialog

    new Future.delayed(new Duration(seconds: 1), () {
      print(response);
      if (response.status == true) {
        this.setDataInToUserModel(response.userModel, preferences);
        if (response.userModel.is_registration_incompleted == 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainTabView()));
        } else {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignupScreen2()));
        }
      } else {
        //  SmartUtils.showErrorDialog(context, response.message);
        isEmailValidation = true;
        emailError = response.message;
        emailFocusNode.unfocus();

        setState(() {});
      }
    });
  }

  void setDataInToUserModel(UserModel model, prefs) {
    prefs.setInt("status", model.status);
    prefs.setString("email", model.email);
    prefs.setString("apiAccessToken", model.apiAccessToken);
    prefs.setString("gender", model.gender);
    prefs.setInt("distance", model.distance);
    prefs.setString("meet", model.meet);
    prefs.setString("phone", model.phone);
    prefs.setString("postalcode", model.postalcode);
    prefs.setString("profilePhoto", model.profilePhoto);
    prefs.setInt("deviceType", model.deviceType);
    prefs.setString("location", model.location);
    prefs.setString("facebook_url", model.facebookUrl);
    prefs.setString("instagram__url", model.instagramUrl);
    prefs.setString("linkedln__url", model.linkedinUrl);

    if (model.profession.length > 0) {
      // prefs.setStringList("profession", json.encode(model.profession));
      prefs.setStringList("profession", model.profession);
      prefs.setStringList("professionTitle", model.professionTitle);
    }
    if (model.generationIdentify.length > 0) {
      prefs.setStringList("generationIdentify", model.generationIdentify);
      prefs.setStringList(
          "generationIdentifyTitle", model.generationIdentifyTitle);
    }
    if (model.wantToMeet.length > 0) {
      prefs.setStringList("wantToMeet", model.wantToMeet);
      prefs.setStringList("wantToMeetTitle", model.wantToMeetTitle);
    }

    if (model.interest.length > 0) {
      prefs.setStringList("interest", model.interest);
      prefs.setStringList("interestTitle", model.interestTitle);
    }

    if (model.whoEarn.length > 0) {
      prefs.setStringList("whoEarn", model.whoEarn);
      prefs.setStringList("whoEarnTitle", model.whoEarnTitle);
    }
    prefs.setInt("userId", model.userId);
    prefs.setString("userName", model.userName);
  }

//  Widget _centerLoading() {
//     return Container(
//       color: Colors.transparent,
//       child: Stack(
//         children: <Widget>[
//           new Center(
//             child: new CircularProgressIndicator(
//               valueColor:
//                   new AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
//             ),
//           )
//         ],
//       ),
//     );
//   }

  //Forgot password APi Call

  void _validateInputsForgotPassword() {
    if (txtForgotEmail.text == '') {
      SmartUtils.showErrorDialog(context, ValidationMessage.enter_email);
    } else {
      Pattern emailpattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regexemail = new RegExp(emailpattern);

      // _formKey.currentState.save();

      if (regexemail.hasMatch(txtForgotEmail.text)) {
        callForgotPasswordApi();
      } else {
        SmartUtils.showErrorDialog(context, ValidationMessage.email_valid);
      }
    }
  }

  void callForgotPasswordApi() async {
    //TODO : call forgot password Api Here

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

    ForgotPasswordRequest request = ForgotPasswordRequest();
    request.email = this.txtForgotEmail.text;
    request.languageId = "1";
    ForgotPasswordResponse response =
        await ApiProvider().callForgotPassword(params: request);

    Navigator.pop(context); //pop dialog
    new Future.delayed(new Duration(seconds: 1), () {
      print(response);
      if (response.status == true) {
        Navigator.pop(context);
        if (response.message != null) {
          SmartUtils.showErrorDialog(context, response.message);
        } else {
          SmartUtils.showErrorDialog(context,
              'Reset password link sent to your registered email address.');
        }
        // Navigator.pop(context); //pop dialog
      } else {
        SmartUtils.showErrorDialog(context, response.message);
      }
    });
  }

  Widget _MainBody() {
    return Container(
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.all(0),
            physics: BouncingScrollPhysics(), //
            scrollDirection: Axis.vertical,
            child: Container(
              height: MediaQuery.of(context).size.height,
              // constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 111,
                      height: 123,
                      margin: EdgeInsets.only(top: 80),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              width: 70,
                              height: 74,
                              margin: EdgeInsets.only(right: 20),
                              child: Image.asset(
                                'assets/group-7.png',
                                // fit: BoxFit.none,
                              ),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "simposi",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 25, 39, 240),
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 38, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: isEmailValidation == true ? 80 : 60,
                          margin: EdgeInsets.only(
                              top: 0, bottom: 0, left: 40, right: 40),
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(10),
                              ),
                          child: TextFormField(
                            onTap: () {
                              isEmailValidation = false;
                              setState(() {});
                            },
                            style: TextStyle(
                                // fontFamily: 'Muli',

                                color: Colors.grey, //AppColors.primaryText,
                                fontSize: 18),
                            focusNode: emailFocusNode,
                            controller: txtEmail,
                            decoration: InputDecoration(
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 28.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              errorText:
                                  isEmailValidation == true ? emailError : null,
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
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: this.emailFocusNode.hasFocus == false
                                    ? Colors.grey
                                    : SmartUtils
                                        .blueBackground, //this.emailFocusNode.hasFocus?SmartUtils.blueBackground:Colors.grey
                              ),
                              // focusColor: SmartUtils.blueBackground,
                              // hoverColor:SmartUtils.blueBackground,

                              hintStyle: TextStyle(
                                // fontFamily: 'Muli',
                                color: SmartUtils.lightGrayBackground,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: SmartUtils.blueBackground),
                                // borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              // contentPadding: EdgeInsets.only(left:30,top: 0,right: 15,bottom: 0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ), //

                        Container(
                          height: isPasswordValidation == true ? 80 : 60,
                          margin: EdgeInsets.only(
                              top: 10, bottom: 14, left: 40, right: 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            onTap: () {
                              isPasswordValidation = false;
                              setState(() {});
                            },
                            style: TextStyle(
                                color: Colors.grey, //AppColors.primaryText,
                                fontSize: 18),
                            focusNode: passwordFocusNode,
                            controller: txtPassword,
                            obscureText: isObscure,
                            decoration: InputDecoration(
                              errorText: isPasswordValidation == true
                                  ? 'Please enter password'
                                  : null,
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
                              contentPadding: new EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 28.0),

                              // decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () => {
                                        setState(() {
                                          isObscure = !isObscure;
                                        })
                                      },
                                  icon: isObscure == true
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
                                color: this.passwordFocusNode.hasFocus == false
                                    ? Colors.grey
                                    : SmartUtils.blueBackground,
                                fontFamily: 'Muli',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),

                              // focusColor: SmartUtils.blueBackground,
                              // hoverColor:SmartUtils.blueBackground,
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.red,
                                ),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              hintStyle: TextStyle(
                                // fontFamily: 'Muli',
                                color: SmartUtils.lightGrayBackground,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: SmartUtils.blueBackground),
                                borderRadius: BorderRadius.circular(25),
                              ),
                              // contentPadding: EdgeInsets.only(left:30,top: 0,right: 15,bottom: 0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(
                              top: 0, bottom: 19, left: 40, right: 40),
                          child: LoginButton(),
                        ),
                        SizedBox(height: 0),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: GestureDetector(
                            child: Center(
                              child: Text('Forgot Password',
                                  style: TextStyle(
                                    color: SmartUtils.blueBackground,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Muli',
                                  )),
                            ), //center point

                            onTap: () => {
                              showModalBottomSheet(
                                  context: context,
                                  clipBehavior: Clip.hardEdge,
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  builder: (BuildContext bc) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Container(
                                        color: Colors.transparent,
                                        child: new Wrap(
                                          children: <Widget>[
                                            forgotPasswordView()
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 100),
                  Spacer(),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 28),
                      child: GestureDetector(
                        //
                        child: Center(
                          child: Text('Register',
                              style: TextStyle(
                                color: Color.fromARGB(255, 25, 39, 240),
                                fontSize: 15,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w800,
                              )),
                        ),
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen1())),
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 26),
                      child: Text(
                        "© 2018-2020 Cascading Enterprises",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.accentText,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
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
    );
  } //

  Widget forgotPasswordView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent, //.withOpacity(0.1),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            // left: 0,
            // top: 0,
            // right: 0,
            // margin: EdgeInsets.only(top:10),
            child: Container(
              height: 570,
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Container(),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 10),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  // width: 24,
                  // height: 24,
                  child: FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Image.asset(
                      'assets/closeButton@3x.png',
                      height: 24,
                      width: 24,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                child: Text('Recover Password',
                    style: TextStyle(
                      color: SmartUtils.blueBackground,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                    )),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(left: 60, right: 60),
                child: Text(
                  'Please enter your email to restore the password ',
                  style: TextStyle(
                    color: Colors.grey, //AppColors.primaryText,,
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 50),
              Container(
                padding: EdgeInsets.only(left: 40, right: 40),
                // child:
                //      Padding(
                //       padding: EdgeInsets.only(
                //           bottom: MediaQuery.of(context).viewInsets.bottom),
                child: TextFormField(
                  validator: (String value) {
                    // if (value.isEmpty) {
                    //   return 'Please enter email.';
                    //    }
                  },
                  style: TextStyle(
                      color: Colors.grey, //AppColors.primaryText,
                      fontSize: 18),
                  focusNode: forgotEmailFocusNode,
                  controller: txtForgotEmail,
                  autofocus: true,
                  decoration: InputDecoration(
                    // errorText: "Please enter email.",
                    hintText: '',
                    labelText: 'Email Address',
                    labelStyle: TextStyle(
                        fontFamily: 'Muli',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: this.forgotEmailFocusNode.hasFocus == false
                            ? Colors.grey
                            : SmartUtils.blueBackground),

                    focusColor: SmartUtils.blueBackground,
                    hoverColor: SmartUtils.blueBackground,

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

//
                    ),
                    contentPadding: EdgeInsets.only(
                        left: 30, top: 15, right: 15, bottom: 15),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                // ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 25, bottom: 25, left: 40, right: 40),
                child: restoreButton(),
              ),
              SizedBox(height: 150),
            ],
          ),
        ],
      ),
    );
  }

  Widget LoginButton() {
    return RaisedButton(
      color: SmartUtils.blueBackground, //
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
          child: const Text('Log In',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ),
      ),
    );
  }

  Widget restoreButton() {
    return RaisedButton(
      color: SmartUtils.blueBackground,
      onPressed: () {
        // TODO: Api Call  Here
        _validateInputsForgotPassword();
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
            'Restore',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              fontFamily: 'Muli',
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

/*

class LoginTwoWidget extends StatelessWidget {
  
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
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 70,
                height: 74,
                margin: EdgeInsets.only(top: 72),
                child: Image.asset(
                  "assets/images/group-5.png",
                  fit: BoxFit.none,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 11),
                child: Text(
                  "simposi",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 25, 39, 240),
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 302,
                height: 59,
                margin: EdgeInsets.only(left: 38, top: 103),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 8,
                      child: Image.asset(
                        "assets/images/path-4.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 23,
                      top: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: EdgeInsets.only(left: 13),
                              child: Text(
                                "Email address",
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
                          Align(
                            alignment: Alignment.topLeft,
                            child: Opacity(
                              opacity: 0.70059,
                              child: Container(
                                width: 1,
                                height: 16,
                                margin: EdgeInsets.only(top: 7),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 25, 39, 240),
                                ),
                                child: Container(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 50,
              margin: EdgeInsets.only(left: 38, top: 12, right: 36),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 0,
                    child: Container(
                      width: 301,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryElement,
                        border: Border.all(
                          width: 1,
                          color: Color.fromARGB(255, 227, 227, 227),
                        ),
                        borderRadius: Radii.k25pxRadius,
                      ),
                      child: Container(),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    top: 18,
                    right: 18,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Password",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 187, 187, 187),
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 13,
                            height: 9,
                            margin: EdgeInsets.only(top: 3),
                            child: Image.asset(
                              "assets/images/hidden.png",
                              fit: BoxFit.none,
                            ),
                          ),
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
                width: 301,
                height: 50,
                margin: EdgeInsets.only(top: 12),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        width: 301,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 25, 39, 240),
                          borderRadius: Radii.k25pxRadius,
                        ),
                        child: Container(),
                      ),
                    ),
                    Positioned(
                      top: 18,
                      child: Text(
                        "Log In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.secondaryText,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 19),
                child: Text(
                  "Forgot Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 25, 39, 240),
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 27),
                child: Text(
                  "Register",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 25, 39, 240),
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 48),
                child: Text(
                  "© 2018 Cascading Enterprises",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.accentText,
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
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
}

*/
