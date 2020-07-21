import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:simposi/Screens/ProfileScreen/EnterSocialMediaLink.dart';
import 'package:simposi/Screens/ProfileScreen/SelectGender.dart';
import 'package:simposi/Screens/ProfileScreen/SelectProfessionalScreen.dart';
import 'package:simposi/Utils/Utility/ModelClass.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/Utility/blue_button_full_width.dart';
import 'package:simposi/Utils/Utility/unstyled_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import 'dart:io';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:simposi/Screens/CreateEventScreens/EnterDateAndTime.dart';
import 'package:simposi/Screens/CreateEventScreens/EnterDescriptionScreen.dart';
import 'package:simposi/Screens/CreateEventScreens/SelectActivityScreens.dart';
import 'package:simposi/Screens/CreateEventScreens/SelectAgeScreens.dart';
import 'package:simposi/Screens/CreateEventScreens/SelectGenderAndIncome.dart';
import 'package:simposi/Screens/TabViewController/PickupInvitation.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Models/CreateEventModel.dart';
import 'package:simposi/Utils/Utility/ApiClass.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/smartutils.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  AllDataModel alldata;

  SharedPreferences preferences;

  var whoEarnStringCheck = '';
  void onSavePressed(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (this.alldata != null) {
      callSignUpApiFromSignupGmail(this.alldata);
    } else {
      callMainDataApiApi();
    }
  }

  // LocationResult _pickedLocation;
  var intrestString = '';
  var stringLinkedin = '';
  var stringFacebook = '';
  var stringInsta = '';

  LocationResult _pickedLocation;
  LocationData _locationData; //= LocationData();
  double lat = 00;
  double long = 00;
  Location location = Location();
  // CreateEventModel eventModel;
  CreateEventModel eventModel; //= CreateEventModel();

  FocusNode nameFocusNode = new FocusNode();
  FocusNode emailFocusNode = new FocusNode();
  FocusNode postalcodeFocusNode = new FocusNode();
  FocusNode identifyAsFocusNode = new FocusNode();
  FocusNode currentPasswordFocusNode = new FocusNode();
  FocusNode repeatPasswordFocusNode = new FocusNode();
  FocusNode newPasswordFocusNode = new FocusNode();

  FocusNode joinUserLimitFocusNode = new FocusNode();

  TextEditingController txtName = new TextEditingController();
  TextEditingController txtEmail = new TextEditingController();
  TextEditingController txtPostalCode = new TextEditingController();
  TextEditingController txtiWantToMeet = new TextEditingController();

  TextEditingController txtSocialIntrest = new TextEditingController();
  TextEditingController txtGeneration = new TextEditingController();
  TextEditingController txtProfessional = new TextEditingController();
  TextEditingController txtiIdentifyAs = new TextEditingController();

  TextEditingController txtFacebook = new TextEditingController();
  TextEditingController txtInstagram = new TextEditingController();
  TextEditingController txtLinkedin = new TextEditingController();

  TextEditingController txtNewPassword = new TextEditingController();
  TextEditingController txtCurrentPassword = new TextEditingController();
  TextEditingController txtRepeatPassword = new TextEditingController();

  String time = '';
  String date = '';
  var generationIdentifyString = '';

  String selectedGender = '';
  // String selectedIncome = '';
  // String selectedAge = '';
  var passDate = '';
  File selectImage;
  String selectedGeneration = '';

  AppMultiPartFile uploadfile;

  bool isiIdentifyAsValidation = false;
  bool isWantToMeetValidation = false;
  bool isProfessionalValidation = false;
  bool isGenerationValidation = false;
  bool isNameValidation = false;
  bool isPostalCodeValidation = false;
  bool isEmailValidation = false;
  bool isSocialIntrestValidation = false;

  bool isFacebookValidation = false;
  bool isInstagramValidation = false;
  bool isLinkedInValidation = false;

  bool isCurrentPasswordValidation = false;
  bool isNewPasswordValidation = false;
  bool isRepeatPasswordValidation = false;
  int isLGBTQ = 0;
  List<String> profession = [];
  List<String> generationIdentify = [];
  List<String> wantToMeet = [];
  List<String> interest = [];
  List<String> whoEarn = [];

  List<String> professionTitle = [];
  List<String> generationIdentifyTitle = [];
  List<String> wantToMeetTitle = [];
  List<String> interestTitle = [];
  List<String> whoEarnTitle = [];

  String strError = '';

  Future getImage() async {
    var getImage = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectImage = getImage;
    });
  }

  Widget imagePicker() {
    return new FloatingActionButton(
      onPressed: getImage,
      tooltip: 'Pick Image',
      child: Icon(Icons.add_a_photo),
    );
  }

  @override
  void initState() {
    init();
    super.initState();
    eventModel = CreateEventModel();

    Future.delayed(Duration.zero, () async {
      this.callMainDataApiApi();
    });
  }

  void init() async {
    preferences = await SharedPreferences.getInstance();
    String name = preferences.getString('userName');
    String email = preferences.getString('email');
    String postalcode = preferences.getString('postalcode');
    String gender = preferences.getString('gender');
    isLGBTQ = preferences.getInt('lgbtq');
    if (isLGBTQ == null) {
      isLGBTQ = 0;
    }
    String meet = preferences.getString('meet');

    profession = preferences.getStringList('profession');
    generationIdentify = preferences.getStringList('generationIdentify');
    wantToMeet = preferences.getStringList('wantToMeet');
    interest = preferences.getStringList('interest');
    whoEarn = preferences.getStringList('whoEarn');

    professionTitle = preferences.getStringList('professionTitle');

    stringFacebook = preferences.getString('facebookLink');
    stringInsta = preferences.getString('instagramLink');
    stringLinkedin = preferences.getString('linkedInLink');

    txtFacebook.text = stringFacebook;
    txtInstagram.text = stringInsta;
    txtLinkedin.text = stringLinkedin;
    if (professionTitle != null) {
      if (professionTitle.length > 0) {
        var professionStr = '';
        professionTitle.forEach((element) {
          if (professionStr != '') {
            professionStr = professionStr + ',' + element.toString();
          } else {
            professionStr = element.toString();
          }
        });
        txtProfessional.text = professionStr;
      }
    }
    generationIdentifyTitle =
        preferences.getStringList('generationIdentifyTitle');

    if (generationIdentifyTitle != null) {
      if (generationIdentifyTitle.length > 0) {
        var genStr = '';
        generationIdentifyTitle.forEach((element) {
          if (genStr != '') {
            genStr = genStr + ',' + element.toString();
          } else {
            genStr = element.toString();
          }
        });
        txtGeneration.text = genStr;
      }
    }

    wantToMeetTitle = preferences.getStringList('wantToMeetTitle');

    if (wantToMeetTitle != null) {
      if (wantToMeetTitle.length > 0) {
        var newMeetString = '';
        wantToMeetTitle.forEach((element) {
          if (newMeetString != '') {
            newMeetString = newMeetString + ',' + element.toString();
          } else {
            newMeetString = element.toString();
          }
        });
        txtiWantToMeet.text = newMeetString;
      }
    }

    // alldata.generationIdentify.forEach((element) {
    //   if (element.isSelected == true) {
    //     if (generationIdentifyString != '') {
    //       generationIdentifyString = generationIdentifyString +
    //           ',' +
    //           element.generationsIdentifyId.toString();
    //     } else {
    //       generationIdentifyString = element.generationsIdentifyId.toString();
    //     }
    //   }
    // });

    interestTitle = preferences.getStringList('interestTitle');
    if (interestTitle != null) {
      if (interestTitle.length > 0) {
        var genStr = '';
        interestTitle.forEach((element) {
          if (genStr != '') {
            genStr = genStr + ',' + element.toString();
          } else {
            genStr = element.toString();
          }
        });
        txtSocialIntrest.text = genStr;
      }
    }
    whoEarnTitle = preferences.getStringList('whoEarnTitle');
    if (whoEarnTitle != null) {
      if (whoEarnTitle.length > 0) {
        var whoEarnNew = '';
        whoEarnTitle.forEach((element) {
          if (whoEarnNew != '') {
            whoEarnNew = whoEarnNew + ',' + element.toString();
          } else {
            whoEarnNew = element.toString();
          }
        });
        whoEarnStringCheck = whoEarnNew;
        // txtGeneration.text = genStr;
      }
    }

    txtName.text = name;
    txtEmail.text = email;
    txtPostalCode.text = postalcode;
    txtiIdentifyAs.text = gender;
    txtiWantToMeet.text = meet;
    if (mounted) {
      setState(() {});
    }
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
      final file = await ImagePicker.pickImage(source: imageSource);
      if (file != null) {
        setState(() => selectImage = file as File);
      }
    }
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

  @override

  // void _validateInputs() {
  //       FocusScope.of(context).unfocus();

  //      if  (txtName.text == ''){
  //                 nameFocusNode.unfocus();
  //               // SmartUtils.showErrorDialog(context, ValidationMessage.title_error);
  //               isNameValidation = true;
  //                setState(() { });
  //      }else if  (txtDescription.text == ''){
  //               isDescValidation = true;
  //               descriptionFocusNode.unfocus();
  //                 setState(() { });
  //               // SmartUtils.showErrorDialog(context, ValidationMessage.description_error);
  //      }
  //      else if  (txtActivityTag.text == ''){
  //               isActivityValidation = true;
  //               activityTagFocusNode.unfocus();
  //                 setState(() { });
  //               // SmartUtils.showErrorDialog(context, ValidationMessage.activitytag_error);
  //      }
  //      else if  (txtDate.text == ''){
  //               isDateValidation = true;
  //               dateFocusNode.unfocus();
  //                 setState(() { });
  //               // SmartUtils.showErrorDialog(context, ValidationMessage.dateAndTime_error);
  //      }else if  (txtTime.text == ''){
  //               isDateValidation = true;
  //               timeFocusNode.unfocus();
  //                 setState(() { });
  //               // SmartUtils.showErrorDialog(context, ValidationMessage.dateAndTime_error);
  //      }
  //      else if (eventModel.gendersId == ''){
  //        isGenderValidation = true;
  //          setState(() { });

  //      }else if (eventModel.earningId == ''){
  //        isGenderValidation = true;
  //          setState(() { });
  //      }else if (eventModel.ageId == ''){
  //        isAgeValidation = true;
  //        setState(() { });
  //      }else if  (txtJoinUserLimit.text == ''){
  //                 joinUserLimitFocusNode.unfocus();
  //               // SmartUtils.showErrorDialog(context, ValidationMessage.title_error);
  //               isUserLimitValidation = true;
  //                setState(() { });
  //      }

  //     // JoinUserLimit
  //     else{

  //             eventModel.title = txtName.text;
  //             eventModel.description = stringDesc;
  //             eventModel.selectImage = this.selectImage;
  //             eventModel.location = txtSearch.text.isEmpty ? "N/A":txtSearch.text;
  //             eventModel.lat = this.lat ?? 00;
  //             eventModel.long = this.long ?? 00;

  //           var newDateTimeObj2 = new DateFormat("yyyy-MM-dd hh:mm a").parse(passDate);
  //            var passdateFormate = new DateFormat("yyyy-MM-dd HH:mm");
  //             var newPassDate =  passdateFormate.format(newDateTimeObj2);
  //             eventModel.date = newPassDate;

  //             this.createEventAPI(eventModel, this.alldata);

  //   }
  // }

  void callMainDataApiApi() async {
    var response = await ApiProvider().callMainDataApi();

    // Navigator.pop(context); //pop dialog

    //  new Future.delayed(new Duration(seconds: 0), () {
    // print(response);
    // generationIdentifyTitle = [];
    // interestTitle = [];
    // whoEarnTitle = [];
    // professionTitle = [];
    // wantToMeetTitle = [];

    generationIdentifyTitle =
        preferences.getStringList('generationIdentifyTitle');
    interestTitle = preferences.getStringList('interestTitle');
    whoEarnTitle = preferences.getStringList('whoEarnTitle');
    wantToMeetTitle = preferences.getStringList('wantToMeetTitle');

    if (response.status == true) {
      this.alldata = response.dataModel;

      if (this.alldata.profession.length > 0) {
        this.alldata.profession.forEach((element) {
          if (professionTitle.contains(element.title)) {
            element.isSelected = true;
          }
        });
      }

      if (generationIdentifyTitle != null) {
        if (this.alldata.generationIdentify.length > 0) {
          this.alldata.generationIdentify.forEach((element) {
            if (generationIdentifyTitle.contains(element.title)) {
              element.isSelected = true;
            }
          });
        }
      }
      if (whoEarnTitle != null) {
        if (this.alldata.whoEarn.length > 0) {
          this.alldata.whoEarn.forEach((element) {
            if (whoEarnTitle.contains(element.title)) {
              element.isSelected = true;
            }
          });
        }
      }
      if (interestTitle != null) {
        if (this.alldata.interest.length > 0) {
          this.alldata.interest.forEach((element) {
            if (interestTitle.contains(element.title)) {
              element.isSelected = true;
            }
          });
        }
      }

      if (wantToMeetTitle != null) {
        if (this.alldata.wantToMeet.length > 0) {
          this.alldata.wantToMeet.forEach((element) {
            if (wantToMeetTitle.contains(element.title)) {
              element.isSelected = true;
            }
          });
        }
      }

      if (generationIdentifyTitle != null) {
        if (generationIdentifyTitle.length > 0) {
          var genStr = '';
          generationIdentifyTitle.forEach((element) {
            if (genStr != '') {
              genStr = genStr + ',' + element.toString();
            } else {
              genStr = element.toString();
            }
          });
          txtGeneration.text = genStr;
        }
      }
      if (wantToMeetTitle != null) {
        if (wantToMeetTitle.length > 0) {
          var newMeet = '';
          wantToMeetTitle.forEach((element) {
            if (newMeet != '') {
              newMeet = newMeet + ',' + element.toString();
            } else {
              newMeet = element.toString();
            }
          });
          txtiWantToMeet.text = newMeet;
        }
      }
      if (interestTitle != null) {
        if (interestTitle.length > 0) {
          var genStr = '';
          interestTitle.forEach((element) {
            if (genStr != '') {
              genStr = genStr + ',' + element.toString();
            } else {
              genStr = element.toString();
            }
          });
          txtSocialIntrest.text = genStr;
        }
      }
      if (whoEarnTitle != null) {
        if (whoEarnTitle.length > 0) {
          var genStr = '';
          whoEarnTitle.forEach((element) {
            if (genStr != '') {
              genStr = genStr + ',' + element.toString();
            } else {
              genStr = element.toString();
            }
          });

          whoEarnStringCheck = genStr;
        }
      }
      if (mounted) {
        setState(() {});
      }
    } else {
      SmartUtils.showErrorDialog(context, response.message);
    }
    // });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                margin: EdgeInsets.only(top: 53),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      // left: 0,
                      // top: 0,
                      // right: 0,
                      // bottom: 0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 21,
                            margin: EdgeInsets.only(left: 11, right: 13),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                InkWell(
                                  onTap: () => {
                                    Navigator.pop(context),
                                  },
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Cancel",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 25, 39, 240),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () => this.onSavePressed(context),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Save",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 25, 39, 240),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Spacer(),
                          // Container(
                          //   height: 1,
                          //   decoration: BoxDecoration(
                          //     color: AppColors.primaryElement,
                          //   ),
                          //   child: Container(),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  // top: 0,
                  margin: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Edit Profile",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 0),
                height: MediaQuery.of(context).size.height - 109,
                child: SingleChildScrollView(
                  child: Container(
                    height: 1100,
                    decoration: BoxDecoration(
                      color: AppColors.ternaryBackground,
                      border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 227, 227, 227),
                      ),
                    ),
                    child: Column(
                      children: [
//
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 96,
                            height: 127,
                            margin: EdgeInsets.only(top: 28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                selectImage != null
                                    ? Container(
                                        height: 96,
                                        decoration: new BoxDecoration(
                                          image: DecorationImage(
                                            image: new ExactAssetImage(
                                                selectImage.path),
                                            //  Image.asset(
                                            //   "assets/rectangle-2.png",
                                            //   fit: BoxFit.none,
                                          ),
                                        ),

                                        // width: MediaQuery.of(context).size.width,
                                        // fit: BoxFit.cover,
                                      )
                                    : Container(
                                        height: 96,
                                        child: preferences.getString(
                                                    'profilePhoto') !=
                                                null
                                            ? Image.network(
                                                preferences
                                                    .getString('profilePhoto'),
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                "assets/group-7.png",
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.cover,
                                              )),
                                Spacer(),
                                InkWell(
                                  onTap: () => {
                                    _pickImage(),
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    child: Text(
                                      "Change photo",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 187, 187, 187),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //name start
                        Container(
                          color: Colors.white,
                          child: Container(
                            height: 58,
                            margin:
                                EdgeInsets.only(left: 13, top: 10, right: 13),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isNameValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width: 2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                      left: 3, top: 0, right: 3),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Name",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 45, 45, 48),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // color: Colors.red,
                                  height: 25,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                    top: 3,
                                    left: 3,
                                    right: 3,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // Expanded(
                                      //   flex: 1,
                                      // child:
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          // color: Colors.red,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          height: 25,
                                          margin: EdgeInsets.only(right: 1),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                // color: Colors.yellow,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: UnstyledTextField(
                                                  child: TextField(
                                                    //  maxLength: 60,
                                                    onTap: () => {
                                                      isNameValidation = false,
                                                      if (mounted)
                                                        {
                                                          setState(() {}),
                                                        }
                                                    },
                                                    controller: txtName,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText:
                                                          "Please enter name",
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 5),
                                                      border: InputBorder.none,
                                                    ),
                                                    style:
                                                        UnstyledTextFieldTextStyle(),
                                                    maxLines: 1,
                                                    autocorrect: false,
                                                    onChanged: (text) {
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          width: 15,
                                          height: 15,
                                          margin: EdgeInsets.only(top: 2),
                                          child: Image.asset(
                                            "assets/checked-3.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 1,
                                  margin: EdgeInsets.only(bottom: 1),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                  ),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //name End

                        //email Start

                        Container(
                          color: Colors.white,
                          child: Container(
                            height: 58,
                            margin:
                                EdgeInsets.only(left: 13, top: 10, right: 13),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isEmailValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width: 2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                      left: 3, top: 0, right: 3),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Email Address",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 45, 45, 48),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // color: Colors.red,
                                  height: 25,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                    top: 3,
                                    left: 3,
                                    right: 3,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // Expanded(
                                      //   flex: 1,
                                      // child:
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          // color: Colors.red,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          height: 25,
                                          margin: EdgeInsets.only(right: 1),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                // color: Colors.yellow,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: UnstyledTextField(
                                                  child: TextField(
                                                    //  maxLength: 60,
                                                    onTap: () => {
                                                      isEmailValidation = false,
                                                      if (mounted)
                                                        {
                                                          setState(() {}),
                                                        }
                                                    },
                                                    controller: txtEmail,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText:
                                                          "Please enter email address",
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 5),
                                                      border: InputBorder.none,
                                                    ),
                                                    style:
                                                        UnstyledTextFieldTextStyle(),
                                                    maxLines: 1,
                                                    autocorrect: false,
                                                    onChanged: (text) {
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          width: 15,
                                          height: 15,
                                          margin: EdgeInsets.only(top: 2),
                                          child: Image.asset(
                                            "assets/checked-3.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 1,
                                  margin: EdgeInsets.only(bottom: 1),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                  ),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),

                        //Email End

                        // Postal Code Start

                        Container(
                          color: Colors.white,
                          child: Container(
                            height: 58,
                            margin:
                                EdgeInsets.only(left: 13, top: 10, right: 13),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isPostalCodeValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width: 2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                      left: 3, top: 0, right: 3),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Postal Code",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 45, 45, 48),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // color: Colors.red,
                                  height: 25,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                    top: 3,
                                    left: 3,
                                    right: 3,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // Expanded(
                                      //   flex: 1,
                                      // child:
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          // color: Colors.red,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          height: 25,
                                          margin: EdgeInsets.only(right: 1),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                // color: Colors.yellow,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: UnstyledTextField(
                                                  child: TextField(
                                                    //  maxLength: 60,
                                                    onTap: () => {
                                                      isPostalCodeValidation =
                                                          false,
                                                      if (mounted)
                                                        {
                                                          setState(() {}),
                                                        }
                                                    },
                                                    controller: txtPostalCode,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      hintText:
                                                          "Please enter postal code",
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 5),
                                                      border: InputBorder.none,
                                                    ),
                                                    style:
                                                        UnstyledTextFieldTextStyle(),
                                                    maxLines: 1,
                                                    autocorrect: false,
                                                    onChanged: (text) {
                                                      if (mounted) {
                                                        setState(() {});
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // ),
                                      Spacer(),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          width: 18,
                                          height: 18,
                                          margin: EdgeInsets.only(top: 2),
                                          child: Image.asset(
                                            "assets/search.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 1,
                                  margin: EdgeInsets.only(bottom: 1),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                  ),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Postal code end

                        //i identify as Start
                        Container(
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isiIdentifyAsValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width: isiIdentifyAsValidation == true
                                        ? 2
                                        : 0)),
                            height: 56,
                            margin:
                                EdgeInsets.only(left: 13, top: 7, right: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 3, top: 0, right: 3),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "I identify as…",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 45, 45, 48),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  margin: EdgeInsets.only(
                                    top: 6,
                                    right: 4,
                                    left: 3,
                                  ),
                                  child: InkWell(
                                    onTap: () => {
                                      iDentifyAsViewController(),
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              height: 25,
                                              margin: EdgeInsets.only(right: 6),
                                              child: UnstyledTextField(
                                                child: TextField(
                                                  controller: txtiIdentifyAs,
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    enabled: false,
                                                    hintText:
                                                        "i identify as", // "It’s time to drink champagne and dance on the…",
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 10),
                                                    hintStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            154,
                                                            154,
                                                            154)),
                                                    border: InputBorder.none,
                                                  ),
                                                  style:
                                                      UnstyledTextFieldTextStyle(),
                                                  maxLines: 1,
                                                  autocorrect: false,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: txtiIdentifyAs.text.isEmpty
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      top: 6, right: 2),
                                                  child: Image.asset(
                                                    "assets/forward.png",
                                                    width: 5,
                                                    height: 10,
                                                    fit: BoxFit.none,
                                                  ))
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0,
                                                      left: 5,
                                                      right: 0),
                                                  child: Image.asset(
                                                    "assets/checked-3.png",
                                                    width: 15,
                                                    height: 15,
                                                    // fit: BoxFit.none,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 1,
                                  margin: EdgeInsets.only(bottom: 1),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                  ),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),

//i Identify as End

//
                        //Generations I Identify with Start
                        Container(
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isGenerationValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width: isGenerationValidation == true
                                        ? 2
                                        : 0)),
                            height: 56,
                            margin:
                                EdgeInsets.only(left: 13, top: 7, right: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 3, top: 0, right: 3),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Generations I Identify with…",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 45, 45, 48),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  margin: EdgeInsets.only(
                                    top: 6,
                                    right: 4,
                                    left: 3,
                                  ),
                                  child: InkWell(
                                    onTap: () => {
                                      pushAgeViewController(),
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              height: 25,
                                              margin: EdgeInsets.only(right: 6),
                                              child: UnstyledTextField(
                                                child: TextField(
                                                  // : TextOverflow.ellipsis,
                                                  minLines: 1,
                                                  maxLines: 1,
                                                  controller: txtGeneration,
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    enabled: false,
                                                    // contentPadding: const EdgeInsets.symmetric(vertical: 40.0),

                                                    hintText:
                                                        "Generations I Identify with...", // "It’s time to drink champagne and dance on the…",
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 10,
                                                            right: 20),
                                                    hintStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            154,
                                                            154,
                                                            154)),
                                                    border: InputBorder.none,
                                                  ),
                                                  style:
                                                      UnstyledTextFieldTextStyle(),
                                                  autocorrect: false,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: txtGeneration.text.isEmpty
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      top: 6, right: 2),
                                                  child: Image.asset(
                                                    "assets/forward.png",
                                                    width: 5,
                                                    height: 10,
                                                    fit: BoxFit.none,
                                                  ))
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0,
                                                      left: 5,
                                                      right: 0),
                                                  child: Image.asset(
                                                    "assets/checked-3.png",
                                                    width: 15,
                                                    height: 15,
                                                    // fit: BoxFit.none,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 1,
                                  margin: EdgeInsets.only(bottom: 1),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                  ),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),

//Generation i Identify as End

                        //Profession start

                        Container(
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isProfessionalValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width: isProfessionalValidation == true
                                        ? 2
                                        : 0)),
                            height: 56,
                            margin:
                                EdgeInsets.only(left: 13, top: 7, right: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 3, top: 0, right: 3),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Profession",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 45, 45, 48),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  margin: EdgeInsets.only(
                                    top: 6,
                                    right: 4,
                                    left: 3,
                                  ),
                                  child: InkWell(
                                    onTap: () =>
                                        {pushSelectProffesionViewController()},
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              height: 25,
                                              margin: EdgeInsets.only(right: 6),
                                              child: UnstyledTextField(
                                                child: TextField(
                                                  controller: txtProfessional,
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    enabled: false,
                                                    hintText:
                                                        "Profession", // "It’s time to drink champagne and dance on the…",
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 10),
                                                    hintStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            154,
                                                            154,
                                                            154)),
                                                    border: InputBorder.none,
                                                  ),
                                                  style:
                                                      UnstyledTextFieldTextStyle(),
                                                  maxLines: 1,
                                                  autocorrect: false,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: txtProfessional.text.isEmpty
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      top: 6, right: 2),
                                                  child: Image.asset(
                                                    "assets/forward.png",
                                                    width: 5,
                                                    height: 10,
                                                    fit: BoxFit.none,
                                                  ))
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0,
                                                      left: 5,
                                                      right: 0),
                                                  child: Image.asset(
                                                    "assets/checked-3.png",
                                                    width: 15,
                                                    height: 15,
                                                    // fit: BoxFit.none,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 1,
                                  margin: EdgeInsets.only(bottom: 1),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                  ),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),
// Proffetional as End

                        //Social Interests
                        Container(
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isSocialIntrestValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width: isSocialIntrestValidation == true
                                        ? 2
                                        : 0)),
                            height: 56,
                            margin:
                                EdgeInsets.only(left: 13, top: 7, right: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 3, top: 0, right: 3),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Social Interests",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 45, 45, 48),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  margin: EdgeInsets.only(
                                    top: 6,
                                    right: 4,
                                    left: 3,
                                  ),
                                  child: InkWell(
                                    onTap: () => {
                                      this.pushSelectActivityViewController(),
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              height: 25,
                                              margin: EdgeInsets.only(right: 6),
                                              child: UnstyledTextField(
                                                child: TextField(
                                                  controller: txtSocialIntrest,
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    enabled: false,
                                                    hintText:
                                                        "Social Interests", // "It’s time to drink champagne and dance on the…",
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 10),
                                                    hintStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            154,
                                                            154,
                                                            154)),
                                                    border: InputBorder.none,
                                                  ),
                                                  style:
                                                      UnstyledTextFieldTextStyle(),
                                                  maxLines: 1,
                                                  autocorrect: false,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: txtSocialIntrest.text.isEmpty
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      top: 6, right: 2),
                                                  child: Image.asset(
                                                    "assets/forward.png",
                                                    width: 5,
                                                    height: 10,
                                                    fit: BoxFit.none,
                                                  ))
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0,
                                                      left: 5,
                                                      right: 0),
                                                  child: Image.asset(
                                                    "assets/checked-3.png",
                                                    width: 15,
                                                    height: 15,
                                                    // fit: BoxFit.none,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 1,
                                  margin: EdgeInsets.only(bottom: 1),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                  ),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),

//Social intrest End

                        //i want to meet start
                        Container(
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isWantToMeetValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width: isWantToMeetValidation == true
                                        ? 2
                                        : 0)),
                            height: 56,
                            margin:
                                EdgeInsets.only(left: 13, top: 7, right: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 3, top: 0, right: 3),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "I want to meet",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 45, 45, 48),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  margin: EdgeInsets.only(
                                    top: 6,
                                    right: 4,
                                    left: 3,
                                  ),
                                  child: InkWell(
                                    onTap: () => {
                                      pushGenderViewController(),
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                height: 25,
                                                margin:
                                                    EdgeInsets.only(right: 6),
                                                child: UnstyledTextField(
                                                  child: TextField(
                                                    controller: txtiWantToMeet,
                                                    enabled: false,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      enabled: false,
                                                      hintText:
                                                          "I want to meet",
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              bottom: 10),
                                                      hintStyle: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              154,
                                                              154,
                                                              154)),
                                                      border: InputBorder.none,
                                                    ),
                                                    style:
                                                        UnstyledTextFieldTextStyle(),
                                                    maxLines: 1,
                                                    autocorrect: false,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: txtiWantToMeet.text.isEmpty
                                                ? Container(
                                                    margin: EdgeInsets.only(
                                                        top: 6, right: 2),
                                                    child: Image.asset(
                                                      "assets/forward.png",
                                                      width: 5,
                                                      height: 10,
                                                      fit: BoxFit.none,
                                                    ))
                                                : Container(
                                                    child: whoEarnStringCheck
                                                            .isEmpty
                                                        ? Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 6,
                                                                    right: 2),
                                                            child: Image.asset(
                                                              "assets/forward.png",
                                                              width: 5,
                                                              height: 10,
                                                              fit: BoxFit.none,
                                                            ))
                                                        : Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 0,
                                                                    left: 5,
                                                                    right: 0),
                                                            child: Image.asset(
                                                              "assets/checked-3.png",
                                                              width: 15,
                                                              height: 15,
                                                              // fit: BoxFit.none,
                                                            ),
                                                          ),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 1,
                                  margin: EdgeInsets.only(bottom: 1),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                  ),
                                  child: Container(),
                                ),
                                SizedBox(
                                  height: 0,
                                ),
                              ],
                            ),
                          ),
                        ),

//i want to meet End

                        SizedBox(
                          height: 20,
                        ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Text(
                              "SHARING",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 187, 187, 187),
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 16, top: 1, right: 16),
                          child: Text(
                            "You can choose to share your contact information with anyone you meet in the app.",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Color.fromARGB(255, 187, 187, 187),
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 10,
                        ),

//Facebook Start

                        Container(
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isFacebookValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width:
                                        isFacebookValidation == true ? 2 : 0)),
                            height: 56,
                            margin:
                                EdgeInsets.only(left: 13, top: 7, right: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 3, top: 0, right: 3),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Facebook",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 45, 45, 48),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  margin: EdgeInsets.only(
                                    top: 6,
                                    right: 4,
                                    left: 3,
                                  ),
                                  child: InkWell(
                                    onTap: () => {
                                      pushFacebookScreen(),
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              height: 25,
                                              margin: EdgeInsets.only(right: 6),
                                              child: UnstyledTextField(
                                                child: TextField(
                                                  controller: txtFacebook,
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    enabled: false,
                                                    hintText:
                                                        "Facebook Link", // "It’s time to drink champagne and dance on the…",
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 10),
                                                    hintStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            154,
                                                            154,
                                                            154)),
                                                    border: InputBorder.none,
                                                  ),
                                                  style:
                                                      UnstyledTextFieldTextStyle(),
                                                  maxLines: 1,
                                                  autocorrect: false,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: txtFacebook.text.isEmpty
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      top: 6, right: 2),
                                                  child: Image.asset(
                                                    "assets/forward.png",
                                                    width: 5,
                                                    height: 10,
                                                    fit: BoxFit.none,
                                                  ))
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0,
                                                      left: 5,
                                                      right: 0),
                                                  child: Image.asset(
                                                    "assets/checked-3.png",
                                                    width: 15,
                                                    height: 15,
                                                    // fit: BoxFit.none,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 1,
                                  margin: EdgeInsets.only(bottom: 1),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                  ),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),

//Facebook End

//Instagram Start

                        Container(
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isInstagramValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width:
                                        isInstagramValidation == true ? 2 : 0)),
                            height: 56,
                            margin:
                                EdgeInsets.only(left: 13, top: 7, right: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 3, top: 0, right: 3),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Instagram",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 45, 45, 48),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  margin: EdgeInsets.only(
                                    top: 6,
                                    right: 4,
                                    left: 3,
                                  ),
                                  child: InkWell(
                                    onTap: () => {pushInstagramScreen()},
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              height: 25,
                                              margin: EdgeInsets.only(right: 6),
                                              child: UnstyledTextField(
                                                child: TextField(
                                                  controller: txtInstagram,
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    enabled: false,
                                                    hintText:
                                                        "Instagram Link", // "It’s time to drink champagne and dance on the…",
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 10),
                                                    hintStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            154,
                                                            154,
                                                            154)),
                                                    border: InputBorder.none,
                                                  ),
                                                  style:
                                                      UnstyledTextFieldTextStyle(),
                                                  maxLines: 1,
                                                  autocorrect: false,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: txtInstagram.text.isEmpty
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      top: 6, right: 2),
                                                  child: Image.asset(
                                                    "assets/forward.png",
                                                    width: 5,
                                                    height: 10,
                                                    fit: BoxFit.none,
                                                  ))
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0,
                                                      left: 5,
                                                      right: 0),
                                                  child: Image.asset(
                                                    "assets/checked-3.png",
                                                    width: 15,
                                                    height: 15,
                                                    // fit: BoxFit.none,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 1,
                                  margin: EdgeInsets.only(bottom: 1),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                  ),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),

//Instagram End

//LinkedIn Start

                        Container(
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isLinkedInValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width:
                                        isLinkedInValidation == true ? 2 : 0)),
                            height: 56,
                            margin:
                                EdgeInsets.only(left: 13, top: 7, right: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 3, top: 0, right: 3),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Linkedin",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 45, 45, 48),
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  margin: EdgeInsets.only(
                                    top: 6,
                                    right: 4,
                                    left: 3,
                                  ),
                                  child: InkWell(
                                    onTap: () => {
                                      pushLinkedinScreen(),
                                    },
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              height: 25,
                                              margin: EdgeInsets.only(right: 6),
                                              child: UnstyledTextField(
                                                child: TextField(
                                                  controller: txtLinkedin,
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    enabled: false,
                                                    hintText:
                                                        "Linkedin Link", // "It’s time to drink champagne and dance on the…",
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 10),
                                                    hintStyle: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            154,
                                                            154,
                                                            154)),
                                                    border: InputBorder.none,
                                                  ),
                                                  style:
                                                      UnstyledTextFieldTextStyle(),
                                                  maxLines: 1,
                                                  autocorrect: false,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: txtLinkedin.text.isEmpty
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      top: 6, right: 2),
                                                  child: Image.asset(
                                                    "assets/forward.png",
                                                    width: 5,
                                                    height: 10,
                                                    fit: BoxFit.none,
                                                  ))
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0,
                                                      left: 5,
                                                      right: 0),
                                                  child: Image.asset(
                                                    "assets/checked-3.png",
                                                    width: 15,
                                                    height: 15,
                                                    // fit: BoxFit.none,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 1,
                                  margin: EdgeInsets.only(bottom: 1),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryElement,
                                  ),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                        ),

//LinkedIn End
//                               SizedBox(height: 20,),
//                               Align(
//                                           alignment: Alignment.topLeft,
//                                           child: Container(
//                                             margin: EdgeInsets.only(left: 16),
//                                             child: Text(
//                                               "SECURITY",
//                                               textAlign: TextAlign.left,
//                                               style: TextStyle(
//                                                 color: Color.fromARGB(255, 187, 187, 187),
//                                                 fontFamily: "Muli",
//                                                 fontWeight: FontWeight.w700,
//                                                 fontSize: 13,
//                                               ),
//                                             ),
//                                           ),
//                                         ),

//                                 SizedBox(height: 10,),

//  //Current Password start
//                             Container(
//                                   color: Colors.white,
//                                   child: Container(
//                                   height: 58,
//                                   margin: EdgeInsets.only(left: 13, top: 10, right: 13),
//                                    decoration: BoxDecoration(
//                                      borderRadius: BorderRadius.all(Radius.circular(6)),
//                                      border:Border.all(color: isCurrentPasswordValidation == true ? Color.fromARGB(255, 255, 1, 126):Colors.transparent ,width: 2)
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                                     children: [
//                                       Container(
//                                       width: MediaQuery.of(context).size.width ,
//                                       margin: EdgeInsets.only(left: 3, top: 0, right: 3),
//                                       child:
//                                       Align(
//                                         alignment: Alignment.topLeft,
//                                         child: Text(
//                                           "Current Password",
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             color: Color.fromARGB(255, 45, 45, 48),
//                                             fontFamily: "Muli",
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 15,
//                                           ),
//                                         ),
//                                       ),
//                                       ),
//                                       Container(
//                                         // color: Colors.red,
//                                         height: 25,
//                                         width: MediaQuery.of(context).size.width ,
//                                         margin: EdgeInsets.only(top: 3, left:3,right: 3,),
//                                         child: Row(
//                                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                                           children: [
//                                             // Expanded(
//                                             //   flex: 1,
//                                               // child:
//                                                Align(
//                                                 alignment: Alignment.topLeft,
//                                                 child: Container(
//                                                   // color: Colors.red,
//                                                   width: MediaQuery.of(context).size.width - 60,
//                                                   height: 25,
//                                                   margin: EdgeInsets.only(right: 1),
//                                                   child: Stack(
//                                                     alignment: Alignment.center,
//                                                     children: [
//                                                       Container(
//                                                         // color: Colors.yellow,
//                                                         width: MediaQuery.of(context).size.width,
//                                                         child: UnstyledTextField(
//                                                           child: TextField(

//                                                           //  maxLength: 60,
//                                                             onTap: ()=>{
//                                                               isCurrentPasswordValidation = false,
//                                                                setState(() {

//                                                               }),
//                                                             },
//                                                             focusNode:currentPasswordFocusNode ,
//                                                             controller: txtCurrentPassword,
//                                                             decoration: InputDecoration(
//                                                               hintText: "Please enter current password",
//                                                               contentPadding: EdgeInsets.only(bottom: 5),
//                                                               border: InputBorder.none,
//                                                             ),
//                                                             style: UnstyledTextFieldTextStyle(),
//                                                             maxLines: 1,
//                                                             autocorrect: false,
//                                                             onChanged: (text) {
//                                                               setState(() {

//                                                               });
//                                                             },
//                                                           ),
//                                                         ),
//                                                       ),

//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             // ),
//                                             Spacer(),
//                                              Align(
//                                                 alignment: Alignment.topLeft,
//                                                 child: Container(
//                                                   width: 15,
//                                                   height: 15,
//                                                   margin: EdgeInsets.only(top: 2),
//                                                   child:txtCurrentPassword.text.isEmpty ? Container(

//                                             margin: EdgeInsets.only(top: 6, right: 2),
//                                             // child:
//                                             // Image.asset(
//                                             //  "assets/forward.png", width: 5,
//                                             // height: 10,
//                                             //   fit: BoxFit.none,
//                                             // )
//                                           ):Container(

//                                             margin: EdgeInsets.only(top: 0, left: 5, right: 0),
//                                             child:
//                                            Image.asset(
//                                              "assets/checked-3.png",
//                                              width: 15,
//                                             height: 15,
//                                               // fit: BoxFit.none,
//                                             ),
//                                           ),
//                                                   // child: Image.asset(
//                                                   //   "assets/checked-3.png",
//                                                   //   fit: BoxFit.none,
//                                                   // ),
//                                                 ),
//                                               ),
//                                           ],
//                                         ),
//                                       ),
//                                       Spacer(),
//                                       Container(
//                                         height: 1,
//                                         margin: EdgeInsets.only(bottom: 1),
//                                         decoration: BoxDecoration(
//                                           color: AppColors.primaryElement,
//                                         ),
//                                         child: Container(),
//                                       ),

//                                     ],
//                                   ),
//                                 ),
//                               ),

//                             //Current Password End

//                              //New Password start
//                             Container(
//                                   color: Colors.white,
//                                   child: Container(
//                                   height: 58,
//                                   margin: EdgeInsets.only(left: 13, top: 10, right: 13),
//                                    decoration: BoxDecoration(
//                                      borderRadius: BorderRadius.all(Radius.circular(6)),
//                                      border:Border.all(color: isNewPasswordValidation == true ? Color.fromARGB(255, 255, 1, 126):Colors.transparent ,width: 2)
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                                     children: [
//                                       Container(
//                                       width: MediaQuery.of(context).size.width ,
//                                       margin: EdgeInsets.only(left: 3, top: 0, right: 3),
//                                       child:
//                                       Align(
//                                         alignment: Alignment.topLeft,
//                                         child: Text(
//                                           "New Password",
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             color: Color.fromARGB(255, 45, 45, 48),
//                                             fontFamily: "Muli",
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 15,
//                                           ),
//                                         ),
//                                       ),
//                                       ),
//                                       Container(
//                                         // color: Colors.red,
//                                         height: 25,
//                                         width: MediaQuery.of(context).size.width ,
//                                         margin: EdgeInsets.only(top: 3, left:3,right: 3,),
//                                         child: Row(
//                                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                                           children: [
//                                             // Expanded(
//                                             //   flex: 1,
//                                               // child:
//                                                Align(
//                                                 alignment: Alignment.topLeft,
//                                                 child: Container(
//                                                   // color: Colors.red,
//                                                   width: MediaQuery.of(context).size.width - 60,
//                                                   height: 25,
//                                                   margin: EdgeInsets.only(right: 1),
//                                                   child: Stack(
//                                                     alignment: Alignment.center,
//                                                     children: [
//                                                       Container(
//                                                         // color: Colors.yellow,
//                                                         width: MediaQuery.of(context).size.width,
//                                                         child: UnstyledTextField(
//                                                           child: TextField(

//                                                           //  maxLength: 60,
//                                                             onTap: ()=>{
//                                                               isNewPasswordValidation = false,
//                                                                setState(() {

//                                                               }),
//                                                             },
//                                                             focusNode:newPasswordFocusNode ,
//                                                             controller: txtNewPassword,
//                                                             decoration: InputDecoration(
//                                                               hintText: "Please enter new password",
//                                                               contentPadding: EdgeInsets.only(bottom: 5),
//                                                               border: InputBorder.none,
//                                                             ),
//                                                             style: UnstyledTextFieldTextStyle(),
//                                                             maxLines: 1,
//                                                             autocorrect: false,
//                                                             onChanged: (text) {
//                                                               setState(() {

//                                                               });
//                                                             },
//                                                           ),
//                                                         ),
//                                                       ),

//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             // ),
//                                             Spacer(),
//                                              Align(
//                                                 alignment: Alignment.topLeft,
//                                                    child:txtNewPassword.text.isEmpty ? Container(

//                                             margin: EdgeInsets.only(top: 6, right: 2),
//                                             // child:
//                                             // Image.asset(
//                                             //  "assets/forward.png", width: 5,
//                                             // height: 10,
//                                             //   fit: BoxFit.none,
//                                             // )
//                                           ):Container(

//                                             margin: EdgeInsets.only(top: 0, left: 5, right: 0),
//                                             child:
//                                            Image.asset(
//                                              "assets/checked-3.png",
//                                              width: 15,
//                                             height: 15,
//                                               // fit: BoxFit.none,
//                                             ),
//                                           ),
//                                               ),
//                                           ],
//                                         ),
//                                       ),
//                                       Spacer(),
//                                       Container(
//                                         height: 1,
//                                         margin: EdgeInsets.only(bottom: 1),
//                                         decoration: BoxDecoration(
//                                           color: AppColors.primaryElement,
//                                         ),
//                                         child: Container(),
//                                       ),

//                                     ],
//                                   ),
//                                 ),
//                               ),

//                             //new password End

//                              //repeat password start
//                             Container(
//                                   color: Colors.white,
//                                   child: Container(
//                                   height: 58,
//                                   margin: EdgeInsets.only(left: 13, top: 10, right: 13),
//                                    decoration: BoxDecoration(
//                                      borderRadius: BorderRadius.all(Radius.circular(6)),
//                                      border:Border.all(color: isRepeatPasswordValidation == true ? Color.fromARGB(255, 255, 1, 126):Colors.transparent ,width: 2)
//                                   ),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                                     children: [
//                                       Container(
//                                       width: MediaQuery.of(context).size.width ,
//                                       margin: EdgeInsets.only(left: 3, top: 0, right: 3),
//                                       child:
//                                       Align(
//                                         alignment: Alignment.topLeft,
//                                         child: Text(
//                                           "Repeat Password",
//                                           textAlign: TextAlign.left,
//                                           style: TextStyle(
//                                             color: Color.fromARGB(255, 45, 45, 48),
//                                             fontFamily: "Muli",
//                                             fontWeight: FontWeight.w700,
//                                             fontSize: 15,
//                                           ),
//                                         ),
//                                       ),
//                                       ),
//                                       Container(
//                                         // color: Colors.red,
//                                         height: 25,
//                                         width: MediaQuery.of(context).size.width ,
//                                         margin: EdgeInsets.only(top: 3, left:3,right: 3,),
//                                         child: Row(
//                                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                                           children: [
//                                             // Expanded(
//                                             //   flex: 1,
//                                               // child:
//                                                Align(
//                                                 alignment: Alignment.topLeft,
//                                                 child: Container(
//                                                   // color: Colors.red,
//                                                   width: MediaQuery.of(context).size.width - 60,
//                                                   height: 25,
//                                                   margin: EdgeInsets.only(right: 1),
//                                                   child: Stack(
//                                                     alignment: Alignment.center,
//                                                     children: [
//                                                       Container(
//                                                         // color: Colors.yellow,
//                                                         width: MediaQuery.of(context).size.width,
//                                                         child: UnstyledTextField(
//                                                           child: TextField(

//                                                           //  maxLength: 60,
//                                                             onTap: ()=>{
//                                                               isRepeatPasswordValidation = false,
//                                                                setState(() {

//                                                               }),
//                                                             },
//                                                             focusNode:repeatPasswordFocusNode ,
//                                                             controller: txtRepeatPassword,
//                                                             decoration: InputDecoration(
//                                                               hintText: "Please enter repeat password",
//                                                               contentPadding: EdgeInsets.only(bottom: 5),
//                                                               border: InputBorder.none,
//                                                             ),
//                                                             style: UnstyledTextFieldTextStyle(),
//                                                             maxLines: 1,
//                                                             autocorrect: false,
//                                                             onChanged: (text) {
//                                                               setState(() {

//                                                               });
//                                                             },
//                                                           ),
//                                                         ),
//                                                       ),

//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             // ),
//                                             Spacer(),
//                                              Align(
//                                                 alignment: Alignment.topLeft,
//                                                 child: Container(
//                                                   width: 15,
//                                                   height: 15,
//                                                   margin: EdgeInsets.only(top: 2),
//                                                      child:txtRepeatPassword.text.isEmpty ? Container(

//                                             margin: EdgeInsets.only(top: 6, right: 2),
//                                             // child:
//                                             // Image.asset(
//                                             //  "assets/forward.png", width: 5,
//                                             // height: 10,
//                                             //   fit: BoxFit.none,
//                                             // )
//                                           ):Container(

//                                             margin: EdgeInsets.only(top: 0, left: 5, right: 0),
//                                             child:
//                                            Image.asset(
//                                              "assets/checked-3.png",
//                                              width: 15,
//                                             height: 15,
//                                               // fit: BoxFit.none,
//                                             ),
//                                           ),
//                                                 ),
//                                               ),
//                                           ],
//                                         ),
//                                       ),
//                                       Spacer(),
//                                       Container(
//                                         height: 1,
//                                         margin: EdgeInsets.only(bottom: 1),
//                                         decoration: BoxDecoration(
//                                           color: AppColors.primaryElement,
//                                         ),
//                                         child: Container(),
//                                       ),

//                                     ],
//                                   ),
//                                 ),
//                               ),

                        //Repeat Password End

                        //
                      ],
                    ),
                  ),
                ),
              )

              // ],
              // ),
              // ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }

  void callSignUpApiFromSignupGmail(AllDataModel allDataModel) async {
// selectImage

    // File isSelectImage;

    SharedPreferences preferences;
    preferences = await SharedPreferences.getInstance();
    //TODO : CALL signup Api Here
    var request = UpdateProfileRequest();

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

    if (txtName.text.isEmpty == true) {
      SmartUtils.showErrorDialog(context, 'Please enter name');
    } else if (txtiWantToMeet.text.isEmpty == true) {
      SmartUtils.showErrorDialog(context, 'Please enter you want to meet');
    } else if (txtEmail.text.isEmpty == true) {
      SmartUtils.showErrorDialog(context, 'Please enter email');
    } else if (txtiIdentifyAs.text.isEmpty == true) {
      SmartUtils.showErrorDialog(context, 'Please enter i identify as');
    } else if (txtPostalCode.text.isEmpty == true) {
      SmartUtils.showErrorDialog(context, 'Please enter postalcode');
    } else if (generationIdentifyString.isEmpty == true) {
      SmartUtils.showErrorDialog(context, 'Please select Generation');
    } else if (whatYouLikeString.isEmpty == true) {
      SmartUtils.showErrorDialog(context, 'Please select Interests');
    } else if (professionString.isEmpty == true) {
      SmartUtils.showErrorDialog(context, 'Please select Profession');
    } else if (whoEarnString.isEmpty == true) {
      SmartUtils.showErrorDialog(context, 'Please select Earning');
      // } else if (txtFacebook.text.isEmpty == true) {
      //   SmartUtils.showErrorDialog(context, 'Please enter Facebook url');
      // } else if (txtInstagram.text.isEmpty == true) {
      //   SmartUtils.showErrorDialog(context, 'Please enter Instagram url');
      // } else if (txtLinkedin.text.isEmpty == true) {
      //   SmartUtils.showErrorDialog(context, 'Please enter Linkedin url');
    } else {
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

      request.name = txtName.text;
      request.meet = txtiWantToMeet.text; //'Female';
      request.email = txtEmail.text;
      request.gender =
          txtiIdentifyAs.text; //.gender == 0 ? 'Male':'Female';//'Male';
      request.postalCode = txtPostalCode.text;
      request.city = 'Torento';
      // request.city = 'city';//signupModel.city;
      // request.distance =  signupModel.distance.toString();
      request.languageId = '1';
      request.generation = '[' + generationIdentifyString + ']';
      request.earning = '[' + whoEarnString + ']';
      request.likes = '[' + whatYouLikeString + ']';
      request.profession = '[' + professionString + ']'; //'[2,3]';
      request.latitude = '17.3423'; //signupModel.latitude
      request.longititude = '92.28782'; //signupModel.longititude
      request.deviceToken = 'abcsddsdsdfsdf'; //signupModel.deviceToken
      request.facebookLink = stringFacebook; //signupModel.deviceToken
      request.instagramLink = stringInsta; //signupModel.deviceToken
      request.linkedinLink = stringLinkedin; //signupModel.deviceToken
      request.is_new = 0;

      List<AppMultiPartFile> arrFile;
      if (this.selectImage != null) {
        AppMultiPartFile uploadfile =
            AppMultiPartFile(localFile: this.selectImage, key: 'Image');
        if (uploadfile.localFile != null) {
          arrFile = [uploadfile];
        }
      }

      UpdateProfileResponse response = await ApiProvider()
          .callUpdateProfile(params: request, arrFile: arrFile);

      Navigator.pop(context); //pop dialog

      new Future.delayed(new Duration(seconds: 1), () {
        print(response);
        if (response.status == true) {
          this.setDataInToUserModel(response.userModel, preferences);
          SmartUtils.showErrorDialog(context, response.message);
        } else {
          SmartUtils.showErrorDialog(context, response.message);

          setState(() {});
        }
      });
      // new Future.delayed(new Duration(seconds: 1), () {
      //   if (response.status == true) {
      //     new Future.delayed(new Duration(seconds: 2), () {
      //       preferences.setString("email", txtEmail.text);
      //       preferences.setString("gender", txtiIdentifyAs.text);
      //       preferences.setInt("lgbtq", isLGBTQ);
      //       preferences.setString("meet", txtGeneration.text);
      //       preferences.setString("postalcode", txtPostalCode.text);
      //       // preferences.setString("profilePhoto", .profilePhoto);

      //       List<String> profession = [];
      //       List<String> generationIdentify = [];
      //       List<String> wantToMeet = [];
      //       List<String> interest = [];
      //       List<String> whoEarn = [];

      //       List<String> professionTitle = [];
      //       List<String> generationIdentifyTitle = [];
      //       List<String> wantToMeetTitle = [];
      //       List<String> interestTitle = [];
      //       List<String> whoEarnTitle = [];

      //       if (this.alldata.profession.length > 0) {
      //         this.alldata.profession.forEach((element) {
      //           if (element.isSelected == true) {
      //             profession.add(element.professionId.toString());
      //             professionTitle.add(element.title);
      //           }
      //         });

      //         preferences.setStringList("profession", profession);
      //         preferences.setStringList("professionTitle", professionTitle);
      //       }

      //       if (this.alldata.generationIdentify.length > 0) {
      //         this.alldata.generationIdentify.forEach((element) {
      //           if (element.isSelected == true) {
      //             generationIdentify
      //                 .add(element.generationsIdentifyId.toString());
      //             generationIdentifyTitle.add(element.title);
      //           }
      //         });

      //         preferences.setStringList(
      //             "generationIdentify", generationIdentify);
      //         preferences.setStringList(
      //             "generationIdentifyTitle", generationIdentifyTitle);
      //       }

      //       if (this.alldata.wantToMeet.length > 0) {
      //         this.alldata.wantToMeet.forEach((element) {
      //           if (element.isSelected == true) {
      //             wantToMeet.add(element.iWantToMeetId.toString());
      //             wantToMeetTitle.add(element.title);
      //           }
      //         });
      //         preferences.setStringList("wantToMeet", wantToMeet);
      //         preferences.setStringList("wantToMeetTitle", wantToMeetTitle);
      //       }

      //       if (this.alldata.interest.length > 0) {
      //         this.alldata.interest.forEach((element) {
      //           if (element.isSelected == true) {
      //             interest.add(element.whatYouLikeId.toString());
      //             interestTitle.add(element.title);
      //           }
      //         });

      //         preferences.setStringList("interest", interest);
      //         preferences.setStringList("interestTitle", interestTitle);
      //       }
      //       whoEarn = [];
      //       whoEarnTitle = [];
      //       if (this.alldata.whoEarn.length > 0) {
      //         this.alldata.whoEarn.forEach((element) {
      //           if (element.isSelected == true) {
      //             whoEarn.add(element.whoEarnsId.toString());
      //             whoEarnTitle.add(element.title);
      //           }
      //         });

      //         preferences.setStringList("whoEarn", whoEarn);
      //         preferences.setStringList("whoEarnTitle", whoEarnTitle);
      //       }

      //       preferences.setString("userName", txtName.text);
      //       preferences.setString("facebookLink", stringFacebook);
      //       preferences.setString("instagramLink", stringInsta);
      //       preferences.setString("linkedInLink", stringLinkedin);
      //       // int isMale = 0;

      //       // if (this.txtiIdentifyAs.text == "Male") {
      //       //   isMale = 1;
      //       // } else {
      //       //   isMale = 0;
      //       // }

      //       preferences.setString("gender", this.txtiIdentifyAs.text);
      //       preferences.setInt("lgbtq", isLGBTQ);

      //       Navigator.pop(context, "");

      //       SmartUtils.showErrorDialog(context, response.message);

      //       //pop dialog
      //       // this.setDataInToUserModel(response.user, preferences);
      //       //pop here
      //     });
      //     //
      //   } else {
      //     SmartUtils.showErrorDialog(context, response.message);
      //   }
      // });
    }

    // }
    // return response;
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

    Navigator.pop(context, "");
  }

  Future<void> pushSelectActivityViewController() async {
    FocusScope.of(context).unfocus();
    if (this.alldata != null) {
      var alldataResult = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectActivityScreens(
                    alldata: this.alldata,
                    createEventModel: this.eventModel,
                    isFromMeetNow: false,
                  )));
      isSocialIntrestValidation = false;
      this.alldata = alldataResult;

      var selectIntrestArr = List<Interest>();
      interest = [];
      interestTitle = [];
      this.alldata.interest.forEach((element) {
        if (element.isSelected == true) {
          selectIntrestArr.add(element);
          interest.add(element.whatYouLikeId.toString());
          interestTitle.add(element.title);
        }
      });

      preferences.setStringList("interest", interest);
      preferences.setStringList("interestTitle", interestTitle);

      if (selectIntrestArr.length > 0) {
        var intrestIdString = '';
        intrestString = "";
        selectIntrestArr.forEach((element) {
          if (element.isSelected == true) {
            if (intrestString != '') {
              intrestString = intrestString + ',' + element.title.toString();
            } else {
              intrestString = element.title.toString();
            }

            if (intrestIdString != '') {
              intrestIdString =
                  intrestIdString + ',' + element.whatYouLikeId.toString();
            } else {
              intrestIdString = element.whatYouLikeId.toString();
            }
          }
        });

        this.eventModel.intrestId = intrestIdString;
        txtSocialIntrest.text = intrestString;
      }
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> pushSelectProffesionViewController() async {
    if (this.alldata != null) {
      FocusScope.of(context).unfocus();

      var alldataResult = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectProfessionalScreens(
                    alldata: this.alldata,
                    createEventModel: this.eventModel,
                  )));
      isSocialIntrestValidation = false;
      this.alldata = alldataResult;

      var selectProfessionArr = List<Profession>();
      profession = [];
      professionTitle = [];

      this.alldata.profession.forEach((element) {
        if (element.isSelected == true) {
          selectProfessionArr.add(element);

          profession.add(element.professionId.toString());
          professionTitle.add(element.title);
        }
      });

      preferences.setStringList("profession", profession);
      preferences.setStringList("professionTitle", professionTitle);

      if (selectProfessionArr.length > 0) {
        var intrestIdString = '';
        intrestString = "";
        selectProfessionArr.forEach((element) {
          if (element.isSelected == true) {
            if (intrestString != '') {
              intrestString = intrestString + ',' + element.title.toString();
            } else {
              intrestString = element.title.toString();
            }

            if (intrestIdString != '') {
              intrestIdString =
                  intrestIdString + ',' + element.professionId.toString();
            } else {
              intrestIdString = element.professionId.toString();
            }
          }
        });
        this.eventModel.profestionId = intrestIdString;
        txtProfessional.text = intrestString;
      }
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> pushAgeViewController() async {
    FocusScope.of(context).unfocus();

    if (this.alldata != null) {
      var allDataResult = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectAgeScreens(
                    createEventModel: this.eventModel,
                    alldata: this.alldata,
                    originalData: this.alldata,
                    isFromMeetNow: false,
                  )));

      isGenerationValidation = false;
      // isPush = false;
      // print(result);
      this.alldata = allDataResult;

      var selectAgeArr = List<GenerationIdentify>();
      generationIdentify = [];
      generationIdentifyTitle = [];
      this.alldata.generationIdentify.forEach((element) {
        if (element.isSelected == true) {
          selectAgeArr.add(element);

          generationIdentify.add(element.generationsIdentifyId.toString());
          generationIdentifyTitle.add(element.title);
        }
      });
      preferences.setStringList("generationIdentify", generationIdentify);
      preferences.setStringList(
          "generationIdentifyTitle", generationIdentifyTitle);
      if (selectAgeArr.length > 0) {
        var wantToMeetString = '';
        selectAgeArr.forEach((element) {
          if (element.isSelected == true) {
            if (wantToMeetString != '') {
              selectedGeneration = selectedGeneration + ',' + element.title;

              wantToMeetString = wantToMeetString +
                  ',' +
                  element.generationsIdentifyId.toString();
            } else {
              wantToMeetString = element.generationsIdentifyId.toString();
              selectedGeneration = element.title;
            }
          }
        });
        this.eventModel.ageId = wantToMeetString;

        String newString = selectedGeneration.replaceAll("\n", " ");

        if (newString.length > 40) {
          this.txtGeneration.text =
              newString.substring(0, 40) + '..'; //getInitials(newString);
        } else {
          // txtLinkedin.text = newString;
          this.txtGeneration.text = newString;
        }
      }
      if (mounted) {
        setState(() {});
      }
    } else {
      callMainDataApiApi();
    }
  }

  Future<void> pushFacebookScreen() async {
    FocusScope.of(context).unfocus();

    var strData = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EnterSocialMediaLink(
                stringDesc: stringFacebook, title: 'Facebook')));
    isFacebookValidation = false;
    stringFacebook = strData;
    // String newString = strData.replaceAll("\n", " ");

    // if (newString.length > 40) {
    //   txtFacebook.text = newString.substring(0, 40) + '..';
    //   ; //getInitials(newString);
    // } else {
    txtFacebook.text = strData;
    // }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> pushLinkedinScreen() async {
    FocusScope.of(context).unfocus();

    var strData = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EnterSocialMediaLink(
                stringDesc: stringLinkedin, title: 'Linkedin')));
    isLinkedInValidation = false;
    stringLinkedin = strData;
    // String newString = strData.replaceAll("\n", " ");

    // if (newString.length > 40) {
    //   txtLinkedin.text = newString.substring(0, 40) + '..';
    //   ; //getInitials(newString);
    // } else {
    txtLinkedin.text = stringLinkedin;
    // }
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> pushInstagramScreen() async {
    FocusScope.of(context).unfocus();

    var strData = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EnterSocialMediaLink(
                stringDesc: stringInsta, title: 'Instagram')));
    isInstagramValidation = false;
    stringInsta = strData;
    // String newString = strData.replaceAll("\n", " ");

    // if (newString.length > 40) {
    //   txtInstagram.text = newString.substring(0, 40) + '..';
    //   //getInitials(newString);
    // } else {
    txtInstagram.text = stringInsta;
    // }
    if (mounted) {
      setState(() {});
    }
  }

  String getInitials(passString) {
    List<String> names = passString.split(" ");
    String initials = "";
    int numWords = 4;

    if (numWords < names.length) {
      numWords = names.length;
    }
    for (var i = 0; i < numWords; i++) {
      initials += '${names[i][0]}' + " ";
    }
    return initials;
  }

  Future<void> pushGenderViewController() async {
    if (this.alldata != null) {
      FocusScope.of(context).unfocus();

      var allDataResult = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectGenderAndIncome(
                  alldata: this.alldata,
                  createEventModel: this.eventModel,
                  originalData: this.alldata,
                  isFromMeetNow: false)));
      isiIdentifyAsValidation = false;
      var wantToMEetString = '';

      this.alldata = allDataResult;

      List<String> whoEarn = [];
      List<String> whoEarnTitle = [];

      var selectArr = List<WhoEarn>();
      this.alldata.whoEarn.forEach((element) {
        if (element.isSelected == true) {
          selectArr.add(element);
          whoEarn.add(element.whoEarnsId.toString());
          whoEarnTitle.add(element.title);
        }
      });

      preferences.setStringList("whoEarn", whoEarn);
      preferences.setStringList("whoEarnTitle", whoEarnTitle);

      List<String> wantToMeet = [];
      List<String> wantToMeetTitle = [];

      var selectGenderArr = List<WantToMeet>();
      this.alldata.wantToMeet.forEach((element) {
        if (element.isSelected == true) {
          selectGenderArr.add(element);
          wantToMeet.add(element.iWantToMeetId.toString());
          wantToMeetTitle.add(element.title);
        }
      });

      preferences.setStringList("wantToMeet", wantToMeet);
      preferences.setStringList("wantToMeetTitle", wantToMeetTitle);

      if (selectArr.length > 0) {
        var whoEarngString = '';
        selectArr.forEach((element) {
          if (element.isSelected == true) {
            if (whoEarngString != '') {
              whoEarngString =
                  whoEarngString + ',' + element.whoEarnsId.toString();
            } else {
              whoEarngString = element.whoEarnsId.toString();
            }
          }
        });
        this.eventModel.earningId = whoEarngString;

        if (selectGenderArr.length > 0) {
          var genderIdString = '';
          selectGenderArr.forEach((element) {
            if (element.isSelected == true) {
              if (genderIdString != '') {
                wantToMEetString =
                    wantToMEetString + ',' + element.title.toString();
                genderIdString =
                    genderIdString + ',' + element.iWantToMeetId.toString();
              } else {
                genderIdString = element.iWantToMeetId.toString();
                wantToMEetString = element.title.toString();
              }
            }
          });
          this.txtiWantToMeet.text = wantToMEetString;

          this.eventModel.gendersId = genderIdString;
        }
      }

      // allDataResult.generationIdentify.forEach((element) {
      //   if (element.isSelected == true) {
      //     if (generationIdentifyString != '') {
      //       generationIdentifyString = generationIdentifyString +
      //           ',' +
      //           element.generationsIdentifyId.toString();
      //     } else {
      //       generationIdentifyString = element.generationsIdentifyId.toString();
      //     }
      //   }
      // });
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<void> iDentifyAsViewController() async {
    if (this.alldata != null) {
      FocusScope.of(context).unfocus();

      GenderModel model = GenderModel();
      if (isLGBTQ == null) {
        isLGBTQ = 0;
      }
      model.isLGBTQ = isLGBTQ;
      if (this.txtiIdentifyAs.text == "Male") {
        model.isMale = 0;
      } else {
        model.isMale = 1;
      }

      GenderModel gender = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectGender(
                    alldata: this.alldata,
                    createEventModel: this.eventModel,
                    genderModel: model,
                  )));
      if (gender.isMale == 0) {
        txtiIdentifyAs.text = 'Male';
      } else if (gender.isMale == 1) {
        txtiIdentifyAs.text = 'Female';
      } else {
        txtiIdentifyAs.text = "";
      }
      // txtiIdentifyAs.text = gender.isMale == 0 ? 'Male' : 'Female';
      this.isLGBTQ = gender.isLGBTQ;

      if (mounted) {
        setState(() {});
      }
    }
  }
}
