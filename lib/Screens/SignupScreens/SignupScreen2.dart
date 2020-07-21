import 'package:custom_switch_button/custom_switch_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:simposi/Screens/SignupScreens/SignupScreen3.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Models/SignupModel.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/colors.dart';
import 'package:simposi/Utils/smartutils.dart';

class SignupScreen2 extends StatefulWidget {
  // final AllDataModel alldata;
  //  final SignupModel signupModel;
  // SignupScreen2({@required this.signupModel, this.alldata});

  @override
  _SignupScreen2State createState() =>
      _SignupScreen2State(); // signupModel:this.signupModel, alldata:this.alldata
}

class _SignupScreen2State extends State<SignupScreen2> {
  AllDataModel alldata;

  int selectedGender = 0;
  bool isChecked = false;
  bool isLGBTQ = false;

  SignupModel signupModel = SignupModel();

  _SignupScreen2State(); //@required this.signupModel , this.alldata

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () async {
      this.callMainDataApiApi();
    });
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
        height: 141,
        padding: EdgeInsets.only(top: 25, bottom: 66, left: 40, right: 40),
        child: continueButton(),
      ),
    );
  }

  Widget _MainBody() {
    return Container(
      margin: EdgeInsets.only(left: 0),
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getAppBarUI(),
            Container(
              //  margin: EdgeInsets.only(top: 12),
              margin: EdgeInsets.only(left: 20, right: 20, top: 13),
              alignment: Alignment.center,
              height: 30,
              child: Text(
                "I identify as a…",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Helvetica",
                  fontWeight: FontWeight.w400,
                  fontSize: 19,
                ),
              ),
            ),
            SizedBox(height: 00),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 6, right: 40, left: 40),
              height: 50,
              child: manButton(),
            ),
            Container(
              margin: EdgeInsets.only(top: 6, bottom: 10, right: 40, left: 40),
              height: 50,
              child: womanButton(),
            ),
            SizedBox(height: 20),
            Container(
                margin: EdgeInsets.only(left: 40, right: 40),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        width: 150,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.center,
                        child: Text(
                          '  Also member  ',
                          style: TextStyle(
                            color: AppColors.accentText,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )),
            SizedBox(height: 24),
            Container(
              margin: EdgeInsets.only(top: 0, bottom: 10, right: 40, left: 40),
              height: 50,
              child: setLGBTQButton(),
            ),

/*

                        Container(
                              margin: EdgeInsets.only(left:20,right:20),
                              child:Row(
                                children: <Widget>[
                                
                                 Container(
                                   child:Image.asset(
                             "assets/flag.jpeg",
                              fit: BoxFit.cover,
                              width: 20,
                              height: 20,
                          ),
                        ),
                                  
                             
                                  Container(
                                    padding: EdgeInsets.only(left:10,right:10),
                                    alignment: Alignment.center,
                                    child: Text('LGBQT',style: TextStyle(color:Colors.black , fontWeight: FontWeight.bold),),
                                  ),
                                  

                                    Expanded(
                                    flex: 7,
                                  child: 
                                  Container(
                                    padding: EdgeInsets.only(left:20,right:50),
                                    alignment: Alignment.center,
                                    child: Text('',style: TextStyle(color:Colors.black , fontWeight: FontWeight.bold),),
                                  ),
                                  ),                                  
                                   Expanded(
                                    flex: 2,
                                  child: GestureDetector(
                                  onTap: () {
                                  setState(() {
                                   isChecked = !isChecked;
                                   });
                                },
          child: Center(
            child: CustomSwitchButton(
              backgroundColor: Colors.blueGrey,
              unCheckedColor: Colors.white,
              animationDuration: Duration(milliseconds: 400),
              checkedColor: Colors.lightGreen,
              checked: isChecked,
            ),
          ),
        ),
  
                                  ),

                              ],)

                        ),*/
          ],
        ),
      ),
    );
  } //

//
  Widget continueButton() {
    return RaisedButton(
      color: SmartUtils.blueBackground,
      onPressed: () {
        // TODO: Api Call  Here
        this.signupModel.gender = this.selectedGender;
        this.signupModel.lgbqt = this.isChecked;
        // this.signupModel.name = get
        // print(this.signupModel.name);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Signupscreen3(
                    signupModel: signupModel, alldata: this.alldata)));
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
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    ); //signuo screen 1
  }

  Widget manButton() {
    return RaisedButton(
      color: selectedGender == 0
          ? SmartUtils.blueBackground
          : SmartUtils.themeGrayColor,
      onPressed: () {
        selectedGender = 0;

        setState(() {});
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child: selectedGender == 0
            ? Container(
                constraints:
                    const BoxConstraints(minWidth: 100.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: const Text(
                  'Man',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: 'Muli'),
                ),
              )
            : Container(
                constraints:
                    const BoxConstraints(minWidth: 100.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: const Text(
                  'Man',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontFamily: 'Muli'),
                ),
              ),
      ),
    ); //signuo screen 1
  }

  Widget setLGBTQButton() {
    return RaisedButton(
      color: isLGBTQ == true
          ? SmartUtils.blueBackground
          : SmartUtils.themeGrayColor,
      onPressed: () {
        isLGBTQ = !isLGBTQ;

        setState(() {});
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child: isLGBTQ == true
            ? Container(
                constraints:
                    const BoxConstraints(minWidth: 100.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: const Text(
                  'LGBTQ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontFamily: 'Muli'),
                ),
              )
            : Container(
                constraints:
                    const BoxConstraints(minWidth: 100.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: const Text(
                  'LGBTQ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      fontFamily: 'Muli'),
                ),
              ),
      ),
    ); //signuo screen 1
  }

  Widget _getAppBarUI() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top, left: 0, right: 0),
      padding: EdgeInsets.only(
        left: 0,
        right: 0,
        top: 10,
      ),
      height: 72,
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  width: 75,
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

          //  Align(
          //   alignment: Alignment.topLeft,
          //   child:
          //   GestureDetector(
          //       child:  Container(
          //     width: 20,
          //     height: 16,
          //     margin: EdgeInsets.only(left: 16, top: 14),
          //     child: Image.asset(
          //       "assets/backArrow@3x.png",
          //     ),
          //   ),
          //   onTap:() => Navigator.of(context).pop()
          //   ),
          // ),

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

  Widget womanButton() {
    return RaisedButton(
      color: selectedGender == 1
          ? SmartUtils.blueBackground
          : SmartUtils.themeGrayColor,
      onPressed: () {
        selectedGender = 1;
        setState(() {});
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        child: selectedGender == 1
            ? Container(
                constraints:
                    const BoxConstraints(minWidth: 100.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: const Text('Woman',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontFamily:
                            'Muli') //:TextStyle(fontSize:16,fontWeight: FontWeight.bold , color:Colors.black,)
                    ),
              )
            : Container(
                constraints:
                    const BoxConstraints(minWidth: 100.0, minHeight: 50.0),
                alignment: Alignment.center,
                child: const Text('Woman',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontFamily:
                            'Muli') //:TextStyle(fontSize:16,fontWeight: FontWeight.bold , color:Colors.black,)
                    ),
              ),
      ),
    ); //signuo screen 1
  }

  void callMainDataApiApi() async {
    //TODO : call Api Here

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

    var response = await ApiProvider().callMainDataApi();

    Navigator.pop(context); //pop dialog

    new Future.delayed(new Duration(seconds: 1), () {
      // print(response);
      if (response.status == true) {
        this.alldata = response.dataModel;
      } else {
        SmartUtils.showErrorDialog(context, response.message);
      }
    });
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
}
