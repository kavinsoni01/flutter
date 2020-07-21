
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simposi/Screens/LoginScreen.dart';
import 'package:simposi/String/validation_message.dart';
import 'package:simposi/Utils/Utility/AppManager.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/smartutils.dart';


class ResetPasswoedScreen extends StatefulWidget {
  @override
  _ResetPasswoedScreenState createState() => _ResetPasswoedScreenState();
}

class _ResetPasswoedScreenState extends State<ResetPasswoedScreen> {

  SharedPreferences preferences;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FocusNode currentPasswordFocusNode = new FocusNode();
  FocusNode newPasswordFocusNode = new FocusNode();
  FocusNode repeatFocusNode = new FocusNode();

  TextEditingController txtCurrentPassword = new TextEditingController();
  TextEditingController txtNewPassword = new TextEditingController();
  TextEditingController txtRepeatPassword = new TextEditingController();

  String emailError = 'Please enter password';
  bool isObscure = true;

bool isCurrentPasswordValidation = false;
bool isNewPasswordValidation = false;
bool isRepeatPasswordValidation = false;


  void _init() async {
    preferences = await SharedPreferences.getInstance();
  }



  @override Widget build(BuildContext context) {

    FlutterStatusbarcolor.setStatusBarColor(Colors.white);

    return Scaffold(

      extendBodyBehindAppBar: true,
      // backgroundColor: SmartUtils.blueBackground,//Colors.white,//
      body: GestureDetector(
        child:_MainBody(),
        onTap: ()=>{
            FocusScope.of(context).requestFocus(new FocusNode()),
        },
        )
    );
  }


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();

    newPasswordFocusNode.addListener(() {
          setState(() {
          });
    });


currentPasswordFocusNode.addListener(() {
          setState(() {
            
          });
    });

        repeatFocusNode.addListener(() {
          setState(() {
            
          });
    });
  }

  void _validateInputs() {
        FocusScope.of(context).unfocus();

     if  (txtCurrentPassword.text == ''){
                // SmartUtils.showErrorDialog(context, ValidationMessage.enter_email);
                isCurrentPasswordValidation = true;
                emailError = ValidationMessage.enter_currentPassword;
                currentPasswordFocusNode.unfocus();

                setState(() {                  

                });

       }else if (txtNewPassword.text == ''){
                isNewPasswordValidation = true;
                emailError = ValidationMessage.enter_newPassword;
                newPasswordFocusNode.unfocus();
                setState(() {                  

                });

                // SmartUtils.showErrorDialog(context, ValidationMessage.enter_password);
      }
      else if (txtRepeatPassword.text == ''){
                isRepeatPasswordValidation = true;
                emailError = ValidationMessage.enter_repearPassword;
                repeatFocusNode.unfocus();
                setState(() {                  

                });

                // SmartUtils.showErrorDialog(context, ValidationMessage.enter_password);
      }
      else if (txtNewPassword.text != txtRepeatPassword.text){
                 isRepeatPasswordValidation = true;
                emailError = ValidationMessage.password_not_match;
                repeatFocusNode.unfocus();
                setState(() {                  

                });

                // SmartUtils.showErrorDialog(context, ValidationMessage.enter_password);
      }else{
                   callResetPassword();
      }
    //   else{

    // Pattern emailpattern =
    //     r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    // RegExp regexemail = new RegExp(emailpattern);

    // // _formKey.currentState.save();

    // if(regexemail.hasMatch(txtEmail.text)){
    //    callLoginCheckApi();
    // }else{
    //     isEmailValidation = true;
    //             emailError = ValidationMessage.email_valid;
    //             emailFocusNode.unfocus();

    //             setState(() {                  

    //             });

        // SmartUtils.showErrorDialog(context, ValidationMessage.email_valid);
    // }
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



  // void callLoginCheckApi() async {
  //  //TODO : call login Api Here


  //   showDialog(
  //             context: context,
  //             barrierDismissible: false,
  //             builder: (BuildContext context) {
  //        return Dialog(
  //          backgroundColor: Colors.transparent,
  //           child: _centerLoading(),
  //     );
  //   },
  // );

  //   LoginCheckRequest request = LoginCheckRequest();
  //     request.email = this.txtEmail.text;
  //     request.password = this.txtPassword.text;
  //     request.device_token = "abcdegd";

  //       LoginCheckResponse response =  await ApiProvider().callLogin(params:request);   

  //                 Navigator.pop(context); //pop dialog

  //                  new Future.delayed(new Duration(seconds: 1), () {
                        
  //                     print(response);
  //                     if (response.status == true){

  //                     }else{
  //                      SmartUtils.showErrorDialog(context, response.message);
  //                     }
  //               });
  // }


Widget _MainBody(){

    return Container(
        child: Stack(
        children: <Widget>[
      SingleChildScrollView(
            padding: EdgeInsets.all(0),
            physics: BouncingScrollPhysics(),//
            scrollDirection: Axis.vertical,
            child: 
        Container(
          height: MediaQuery.of(context).size.height ,
        // constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
     
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [         

            
              Align(
                 
              alignment: Alignment.topLeft,
              child: 
              GestureDetector(
                child:  Container(
                // color: Colors.red,
                width: 24,
                height: 24,
                margin: EdgeInsets.only(left: 16, top: MediaQuery.of(context).padding.top+10),
                child: Image.asset(
                  "assets/backArrow@3x.png",
                  width: 20,
                  height: 20,
                ),
              ),
              onTap:() => {
                   Navigator.pop(context,""),
              }
              ), 
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 111,
                height: 123,
                margin: EdgeInsets.only(top: 50),
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

                child:
                Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[

                //
                         
           Container(
                height: isCurrentPasswordValidation == true? 80:60,

                margin: EdgeInsets.only(top:10,bottom:14,left:40,right:40),
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),

    ),
                child: TextFormField(
                  
                     onTap: (){
                       isCurrentPasswordValidation = false;
                       setState(() {
                                                                
                      });
                     },
        style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 18),
        focusNode: currentPasswordFocusNode,
        controller: txtCurrentPassword,
        obscureText:isObscure,
        decoration: InputDecoration(

                errorText: isCurrentPasswordValidation == true ? 'Please enter current password' : null,
                  hintText: '',
                  errorStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 1, 126),
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                   errorBorder: OutlineInputBorder(
                    
                         borderSide: BorderSide(color: Color.fromARGB(255, 255, 1, 126),),
                        // borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                         borderRadius: BorderRadius.circular(30),
    
                  ),
        contentPadding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 28.0),

        // decoration: InputDecoration(
    suffixIcon: IconButton(
      onPressed: () => {
        
         setState(() {
          isObscure = !isObscure;
           })          
      },
      icon: isObscure == true ? Image.asset("assets/hidden@3x.png", height: 15, width: 15,):Image.asset("assets/eye@3x.png", height: 15, width: 15,)
    ),
      
      labelText: 'Current Password',labelStyle: TextStyle(color:this.currentPasswordFocusNode.hasFocus == false  ?Colors.grey:SmartUtils.blueBackground,  fontFamily: 'Muli', fontSize: 15, fontWeight: FontWeight.w700,
      ),
   
  // focusColor: SmartUtils.blueBackground,
  // hoverColor:SmartUtils.blueBackground,
  focusedErrorBorder: OutlineInputBorder(
       borderSide: BorderSide(color: Colors.red,),
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
       borderSide: BorderSide(color: SmartUtils.blueBackground),
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
                height: isNewPasswordValidation == true? 80:60,
                margin: EdgeInsets.only(top:00,bottom:14,left:40,right:40),
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),

    ),
                child: TextFormField(
                  
                     onTap: (){
                       isNewPasswordValidation = false;
                       setState(() {
                                                                
                      });
                     },
        style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 18),
        focusNode: newPasswordFocusNode,
        controller: txtNewPassword,
        obscureText:isObscure,
        decoration: InputDecoration(

                errorText: isNewPasswordValidation == true ? 'Please enter new password' : null,
                  hintText: '',
                  errorStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 1, 126),
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                   errorBorder: OutlineInputBorder(
                    
                         borderSide: BorderSide(color: Color.fromARGB(255, 255, 1, 126),),
                        // borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                         borderRadius: BorderRadius.circular(30),
    
                  ),
        contentPadding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 28.0),

        // decoration: InputDecoration(
    suffixIcon: IconButton(
      onPressed: () => {
        
         setState(() {
          isObscure = !isObscure;
           })          
      },
      icon: isObscure == true ? Image.asset("assets/hidden@3x.png", height: 15, width: 15,):Image.asset("assets/eye@3x.png", height: 15, width: 15,)
    ),
      
      labelText: 'New Password',labelStyle: TextStyle(color:this.newPasswordFocusNode.hasFocus == false  ?Colors.grey:SmartUtils.blueBackground,  fontFamily: 'Muli', fontSize: 15, fontWeight: FontWeight.w700,
      ),
   
  // focusColor: SmartUtils.blueBackground,
  // hoverColor:SmartUtils.blueBackground,
  focusedErrorBorder: OutlineInputBorder(
       borderSide: BorderSide(color: Colors.red,),
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
       borderSide: BorderSide(color: SmartUtils.blueBackground),
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
                height: isRepeatPasswordValidation == true? 80:60,

                margin: EdgeInsets.only(top:0,bottom:14,left:40,right:40),
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),

    ),
                child: TextFormField(
                  
                     onTap: (){
                       isRepeatPasswordValidation = false;
                       setState(() {
                                                                
                      });
                     },
        style: TextStyle(
                  color: AppColors.primaryText,
                  fontSize: 18),
        focusNode: repeatFocusNode,
        controller: txtRepeatPassword,
        obscureText:isObscure,
        decoration: InputDecoration(

                errorText: isRepeatPasswordValidation == true ? 'Please enter repeat password' : null,
                  hintText: '',
                  errorStyle: TextStyle(
                        color: Color.fromARGB(255, 255, 1, 126),
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                   errorBorder: OutlineInputBorder(
                    
                         borderSide: BorderSide(color: Color.fromARGB(255, 255, 1, 126),),
                        // borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                         borderRadius: BorderRadius.circular(30),
    
                  ),
        contentPadding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 28.0),

        // decoration: InputDecoration(
    suffixIcon: IconButton(
      onPressed: () => {
        
         setState(() {
          isObscure = !isObscure;
           })          
      },
      icon: isObscure == true ? Image.asset("assets/hidden@3x.png", height: 15, width: 15,):Image.asset("assets/eye@3x.png", height: 15, width: 15,)
    ),
      
      labelText: 'Repeat Password',labelStyle: TextStyle(color:this.repeatFocusNode.hasFocus == false  ?Colors.grey:SmartUtils.blueBackground,  fontFamily: 'Muli', fontSize: 15, fontWeight: FontWeight.w700,
      ),
   
  // focusColor: SmartUtils.blueBackground,
  // hoverColor:SmartUtils.blueBackground,
  focusedErrorBorder: OutlineInputBorder(
       borderSide: BorderSide(color: Colors.red,),
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
       borderSide: BorderSide(color: SmartUtils.blueBackground),
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
      padding: EdgeInsets.only(top: 0 , bottom: 19 , left: 40,right: 40),
      child:LoginButton(),

  ),
    SizedBox(height:0),
                          
         ], 
      ),
    ),
SizedBox(height:100),
        Spacer(),
        Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 28),
                child:GestureDetector(
                                   //
                    child: Center(
                      child:Text('Log In',style: TextStyle(color: Color.fromARGB(255, 25, 39, 240),fontSize: 15,fontFamily: "Muli",
                    fontWeight: FontWeight.w800,
                    )
                    ),   
                    ) ,                  
                        onTap: () => {

                           AppManager.logout(this.preferences),

                                  Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (_) => LoginScreen()),
                                 (Route<dynamic> route) => false),
                              // Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen1())),
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
  }//



  Widget LoginButton() {
    return RaisedButton(
      color: SmartUtils.blueBackground,//
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
            "Reset Password",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize:16,fontWeight: FontWeight.bold,color: Colors.white,)
          ),
        ),
      ),
    );
  }


   callResetPassword() async {
   //TODO : CALL Register Api Here
      
      ResetPasswordRequest request;
      request = ResetPasswordRequest();
      request.newPassword = txtNewPassword.text;
      request.currentPassword = txtCurrentPassword.text;//txtDescription.text;
      request.language_id = 1;

      ResetPasswordResponse responseBusiness =  await ApiProvider().callResetPasswordEventApi(params:request); 

        print(responseBusiness);
        if (responseBusiness.status == true){
                 Navigator.pop(context); 
        }else{
            SmartUtils.showErrorDialog(context, responseBusiness.message);
        }
    return responseBusiness;
  }
}

