import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
// import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simposi/Screens/CreateEventScreens/EnterDateAndTime.dart';
import 'package:simposi/Screens/CreateEventScreens/EnterDescriptionScreen.dart';
import 'package:simposi/Screens/CreateEventScreens/SelectActivityScreens.dart';
import 'package:simposi/Screens/CreateEventScreens/SelectAgeScreens.dart';
import 'package:simposi/Screens/CreateEventScreens/SelectGenderAndIncome.dart';
import 'package:simposi/Screens/SignupScreens/SignupScreen2.dart';
import 'package:simposi/Screens/TabViewController/HomeEventScreen.dart';
import 'package:simposi/Screens/TabViewController/PickupInvitation.dart';
import 'package:simposi/String/validation_message.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Models/CreateEventModel.dart';
import 'package:simposi/Utils/Utility/ApiClass.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/Utility/blue_button_full_width.dart';
import 'package:simposi/Utils/Utility/unstyled_text_field.dart';
import 'package:simposi/Utils/smartutils.dart';

class MeetNowViewScreen extends StatefulWidget {
  @override
  _MeetNowViewScreenState createState() => _MeetNowViewScreenState();
}

class _MeetNowViewScreenState extends State<MeetNowViewScreen> {
  // LocationResult _pickedLocation;
  var intrestString = '';
  bool isLoading = false;
  final picker = ImagePicker();

  AllDataModel alldata;
  SharedPreferences preferences;
  LocationResult _pickedLocation;
  LocationData _locationData; //= LocationData();
  double lat = 00;
  double long = 00;
  Location location;
  var strLocation = '';
  // CreateEventModel eventModel;
  CreateEventModel eventModel; //= CreateEventModel();

  FocusNode titleFocusNode = new FocusNode();
  FocusNode descriptionFocusNode = new FocusNode();
  FocusNode activityTagFocusNode = new FocusNode();
  FocusNode dateFocusNode = new FocusNode();
  FocusNode timeFocusNode = new FocusNode();
  FocusNode searchFocusNode = new FocusNode();

  FocusNode joinUserLimitFocusNode = new FocusNode();
  Completer<GoogleMapController> _controller = Completer();

  TextEditingController txtTitle = new TextEditingController();
  TextEditingController txtDescription = new TextEditingController();
  TextEditingController txtActivityTag = new TextEditingController();
  TextEditingController txtDate = new TextEditingController();
  TextEditingController txtTime = new TextEditingController();

  TextEditingController txtSearch = new TextEditingController();
  TextEditingController txtJoinUserLimit = new TextEditingController();

  String time = '';
  String date = '';
  String stringDesc = '';
  // String selectedGender = '';
  // String selectedIncome = '';
  // String selectedAge = '';
  var passDate = '';
  File selectImage;
  AppMultiPartFile uploadfile;

  bool isDescValidation = false;
  bool isActivityValidation = false;
  bool isDateValidation = false;
  bool isTimeValidation = true;
  bool isTitleValidation = false;
  bool isAgeValidation = false;
  bool isGenderValidation = false;
  bool isUserLimitValidation = false;
  // GoogleMapController _controller;
  String _mapStyle;
  BitmapDescriptor bitmapImage;
  final Set<Marker> _markers = {};

  // Completer<GoogleMapController> _controller = Completer();

  String strError = '';

  Future getImage() async {
    PickedFile getImage = await picker.getImage(source: ImageSource.gallery);
    selectImage = File(getImage.path);

// final File file = File(pickedFile.path);

    // var getImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (mounted) {
      setState(() {});
    }
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
    // TODO: implement initState
    super.initState();
    init();

    rootBundle.loadString('assets/json/map_style.json').then((string) {
      _mapStyle = string;
      print("Map style" + _mapStyle);
    });

    dateFocusNode.addListener(_onFocusChangeDate);
    timeFocusNode.addListener(_onFocusChangeTime);

    searchFocusNode.addListener(_onFocusChangeSearch);
    eventModel = CreateEventModel();
  }

  void init() async {
    findCurrentLocation();

    preferences = await SharedPreferences.getInstance();

    Future.delayed(Duration.zero, () async {
      this.callMainDataApiApi();
    });

    //  this.();
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
      PickedFile getImage = await picker.getImage(source: imageSource);
      selectImage = File(getImage.path);

      // final file = await ImagePicker.pickImage(source: imageSource);
      if (mounted) {
        setState(() {});
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

    lat = _locationData.latitude;
    long = _locationData.longitude;
    isLoading = false;

    changeLocationORShowLocation();
    if (mounted) {
      setState(() {
        lat = _locationData.latitude;
        long = _locationData.longitude;
      });
    }
    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
      _locationData = currentLocation;
      lat = _locationData.latitude;
      long = _locationData.longitude;
// changeLocationORShowLocation();
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Completer<GoogleMapController> _controller = Completer();
    //    CameraPosition _kGooglePlex = CameraPosition(
    //      target: LatLng(lat ?? 0, long ?? 0),
    //      zoom: 14.4746,
    // );
    // var SmartUtils;
    return Scaffold(
      body: isLoading == true
          ? _centerLoading()
          : Container(
              //  constraints: BoxConstraints.expand(),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              child: SingleChildScrollView(
                // height:MediaQuery.of(context).size.height,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 1350,
                      margin: EdgeInsets.only(top: 50),
                      //   child: SingleChildScrollView(
                      padding: EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            //container height
                            height: 4,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(50, 25, 39, 240),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 188,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 25, 39, 240),
                                  ),
                                  child: Container(),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              child: Container(
                                width: 15,
                                height: 15,
                                margin: EdgeInsets.only(top: 22, left: 15),
                                child: Image.asset(
                                  "assets/64px-close-2.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                              onTap: () => {
                                //  Navigator.of(context).pop(),
                                Navigator.pop(context, 'Back'),
                              },
                            ),
                          ),

                          Stack(children: [
                            Container(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.ternaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 187, 187, 187),
                                      offset: Offset(0, -0.5),
                                      blurRadius: 0,
                                    ),
                                  ],
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: 260,
                                margin: EdgeInsets.only(top: 14),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Container(
                                      margin: selectImage == null
                                          ? EdgeInsets.only(top: 42)
                                          : EdgeInsets.only(top: 0),
                                      width: selectImage == null
                                          ? 76
                                          : MediaQuery.of(context).size.width,
                                      height: selectImage == null ? 76 : 260,
                                      decoration: new BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: selectImage == null
                                              ? new ExactAssetImage(
                                                  "assets/rectangle-2.png",
                                                ) //rectangle-2 placeholder.jpg
                                              : new ExactAssetImage(
                                                  selectImage.path),
                                          //  Image.asset(
                                          //   "assets/rectangle-2.png",
                                          //   fit: BoxFit.none,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top:
                                              42), //selectImage == null ?EdgeInsets.only(top:42) : EdgeInsets.only(top:0),
                                      height: 76,
                                      width: 76,
                                      child: GestureDetector(
                                        onTap: () => {
                                          _pickImage(),
                                        },
                                        child: Image.asset(
                                          "assets/icons-photo.png",
                                          fit: BoxFit.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 260,
                              margin: EdgeInsets.only(top: 14),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 90),
                                  //
                                  Container(
                                    width: 256,
                                    height: 68,
                                    margin: EdgeInsets.only(top: 31),
                                    child: Column(
                                      //  crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Center(
                                            child: Text(
                                              "Create an Activity",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.primaryText,
                                                fontFamily: "Muli",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 21,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 6),
                                          child: Text(
                                            "Post an activity and we’ll match people \nwho want to do the same thing you do.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              height: 1.28571,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                          Container(
                            height: 58,
                            margin:
                                EdgeInsets.only(left: 13, top: 30, right: 13),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isTitleValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width: 2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 3, top: 0, right: 3),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Title",
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
                                  height: 19,
                                  margin: EdgeInsets.only(
                                    top: 3,
                                    left: 3,
                                    right: 3,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            height: 19,
                                            margin: EdgeInsets.only(right: 1),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  child: UnstyledTextField(
                                                    child: TextFormField(
                                                      //  maxLength: 60,
                                                      onTap: () => {
                                                        isTitleValidation =
                                                            false,
                                                        if (mounted)
                                                          {
                                                            if (mounted)
                                                              {
                                                                setState(() {}),
                                                              }
                                                          },
                                                      },
                                                      controller: txtTitle,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            "Please enter title",
                                                        contentPadding:
                                                            EdgeInsets.only(
                                                                bottom: 5),
                                                        border:
                                                            InputBorder.none,
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
                                                Positioned(
                                                  top: 0,
                                                  right: 10,
                                                  child: Text(
                                                    txtTitle.text.length
                                                            .toString() +
                                                        "/60",
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 154, 154, 154),
                                                      fontFamily: "Muli",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                            width: 19,
                                            height: 19,
                                            child: CircularProgressIndicator(
                                                value:
                                                    (txtTitle.text.length / 60),
                                                valueColor:
                                                    new AlwaysStoppedAnimation<
                                                            Color>(
                                                        SmartUtils
                                                            .blueBackground))
                                            //  Image.asset(
                                            //   "assets/load-2.png",
                                            //   fit: BoxFit.none,
                                            // ),
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

                          Container(
                            height: 307,
                            margin:
                                EdgeInsets.only(left: 16, top: 15, right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 76,
                                    height: 19,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            margin: EdgeInsets.only(right: 6),
                                            child: Text(
                                              "Location",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 45, 45, 48),
                                                fontFamily: "Muli",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 8,
                                          height: 8,
                                          child: Image.asset(
                                            "assets/location-2-2.png",
                                            fit: BoxFit.none,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 36,
                                  margin: EdgeInsets.only(top: 6),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(31, 142, 142, 147),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(31, 142, 142, 147),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      height: 40,
                                      margin:
                                          EdgeInsets.only(left: 0, right: 0),
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                100,
                                            child: TextFormField(
                                              focusNode: searchFocusNode,
                                              maxLines: 1,
                                              controller: txtSearch,
                                              keyboardType: TextInputType.text,
                                              style: TextStyle(
                                                  fontFamily: 'Muli',
                                                  fontWeight: FontWeight.w700,
                                                  // color: SmartUtils.blueBackground,
                                                  fontSize: 15),
                                              decoration: InputDecoration(
                                                hintText: 'Search',
                                                // focusColor: SmartUtils.blueBackground,
                                                // hoverColor:SmartUtils.blueBackground,
                                                border: InputBorder.none,
                                                isDense: true,
                                                hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                ),
                                Container(
                                  height: 229,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(top: 17, right: 0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        height: 229,
                                        child: GoogleMap(
                                          mapType: MapType.normal,
                                          myLocationButtonEnabled: false,
                                          myLocationEnabled: false,
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(lat ?? 0, long ?? 0),
                                            zoom: 14.4746,
                                          ),
                                          onMapCreated:
                                              (GoogleMapController controller) {
                                            controller.setMapStyle(_mapStyle);
                                            _controller.complete(controller);
                                          },
                                          markers: _markers,
                                        ),

                                        // Positioned(

                                        // left: -1,
                                        // right: -1,
                                        // child: GoogleMap(
                                        // myLocationButtonEnabled: false,
                                        //    mapType: MapType.normal,
                                        //   initialCameraPosition: _kGooglePlex,
                                        //  onMapCreated:

                                        //  (GoogleMapController controller) {
                                        //       _controller.complete(controller);
                                        //    },
                                        // ),
                                      ),
                                      // Positioned(

                                      //   left: -1,
                                      //   right: -1,
                                      //   child: Image.asset(
                                      //     "assets/maps---4600-cambie-st-vancouver-bc-v5z-2z1-canada---zoom-15.png",
                                      //     fit: BoxFit.cover,
                                      //   ),
                                      // ),
                                      // Positioned(
                                      //   top: 32,
                                      //   right: 135,
                                      //   child: Image.asset(
                                      //     "assets/pin.png",
                                      //     fit: BoxFit.none,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap: () => {
                              pushDescriptionScreen(),
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                  border: Border.all(
                                      color: isDescValidation == true
                                          ? Color.fromARGB(255, 255, 1, 126)
                                          : Colors.transparent,
                                      width: 2)),
                              height: 61,
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  EdgeInsets.only(left: 13, top: 20, right: 13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 4, top: 2, right: 2, bottom: 2),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Description",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 45, 45, 48),
                                          fontFamily: "Muli",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    margin: EdgeInsets.only(
                                      top: 2,
                                      right: 3,
                                      left: 4,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              height: 30,
                                              margin: EdgeInsets.only(right: 6),
                                              child: UnstyledTextField(
                                                child: TextFormField(
                                                  maxLines: 1,
                                                  controller: txtDescription,
                                                  textAlign: TextAlign.start,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    hintText:
                                                        "Enter Description", // "It’s time to drink champagne and dance on the…",
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 0),
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
                                          child: txtDescription.text.isEmpty
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0, right: 2),
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
                                                    "assets/checkmark.png",
                                                    width: 14,
                                                    height: 14,
                                                    // fit: BoxFit.none,
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
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isActivityValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width:
                                        isActivityValidation == true ? 2 : 0)),
                            height: 61,
                            margin:
                                EdgeInsets.only(left: 13, top: 7, right: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Stack(
                                //   child:
                                // )
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 3, top: 5, right: 3, bottom: 5),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Activity Tags",
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
                                  height: 30,
                                  margin: EdgeInsets.only(
                                    top: 0,
                                    right: 4,
                                    left: 3,
                                  ),
                                  child: GestureDetector(
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
                                              height: 30,
                                              margin: EdgeInsets.only(right: 6),
                                              child: UnstyledTextField(
                                                child: TextFormField(
                                                  controller: txtActivityTag,
                                                  enabled: false,
                                                  decoration: InputDecoration(
                                                    enabled: false,
                                                    isDense: true,
                                                    hintText:
                                                        "Enter Activity Tags", // "It’s time to drink champagne and dance on the…",
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            bottom: 5),
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
                                          child: txtActivityTag.text.isEmpty
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0, right: 2),
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
                                                    "assets/checkmark.png",
                                                    width: 14,
                                                    height: 14,
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
                          Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isDateValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width: isDateValidation == true ? 2 : 0)),
                            height: 61,
                            margin:
                                EdgeInsets.only(left: 13, top: 20, right: 13),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        height: 28,
                                        margin:
                                            EdgeInsets.only(left: 3, top: 0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Date",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 45, 45, 48),
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(left: 3, top: 0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Time",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 45, 45, 48),
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: txtDate.text.isEmpty
                                          ? Container(
                                              width: 5,
                                              height: 10,

                                              margin: EdgeInsets.only(
                                                  top: 0, right: 2),
                                              // child:
                                              // Image.asset(
                                              //  "assets/forward.png",
                                              //                                               fit: BoxFit.none,
                                              // )
                                            )
                                          : Container(
                                              width: 14,
                                              height: 14,
                                              margin: EdgeInsets.only(
                                                  top: 0, right: 2),
                                              // child:
                                              //  Image.asset(
                                              //    "assets/checkmark.png",

                                              //     // fit: BoxFit.none,
                                              //   ),
                                            ),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 28,
                                  margin: EdgeInsets.only(
                                      top: 2, right: 1, left: 3),
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
                                                focusNode: dateFocusNode,
                                                controller: txtDate,
                                                keyboardType:
                                                    TextInputType.datetime,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      "Enter Date", // "It’s time to drink champagne and dance on the�������������������������",
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          bottom: 10),
                                                  hintStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 154, 154, 154)),
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
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            height: 25,
                                            margin: EdgeInsets.only(right: 6),
                                            child: UnstyledTextField(
                                              child: TextFormField(
                                                focusNode: timeFocusNode,
                                                controller: txtTime,
                                                keyboardType:
                                                    TextInputType.datetime,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  hintText:
                                                      "Enter Time", // "It’s time to drink champagne and dance on the…",
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          bottom: 10),
                                                  hintStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 154, 154, 154)),
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
                                        child: txtDate.text.isEmpty
                                            ? Container(
                                                margin: EdgeInsets.only(
                                                    top: 0, right: 2),
                                                child: Image.asset(
                                                  "assets/forward.png",
                                                  width: 5,
                                                  height: 10,
                                                  fit: BoxFit.none,
                                                ))
                                            : Container(
                                                margin: EdgeInsets.only(
                                                    top: 0, right: 2),
                                                child: Image.asset(
                                                  "assets/checkmark.png",
                                                  width: 14,
                                                  height: 14,
                                                  // fit: BoxFit.none,
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

                          Container(
                            height: 62,
                            margin: EdgeInsets.only(top: 24),
                            decoration: BoxDecoration(
                              color: AppColors.ternaryBackground,
                              border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 227, 227, 227),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 16, top: 36),
                                  child: Text(
                                    "Who do you want to invite…",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: AppColors.accentText,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // color: Colors.red,

                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isGenderValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width: 2)),
                            height: 50,
                            margin: EdgeInsets.only(
                                left: 13, top: 0, right: 13, bottom: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(
                                        left: 3, top: 0, right: 3),
                                    height: 44,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              60,
                                          color: Colors.white,
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Gender & Income",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              color: AppColors.primaryText,
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Align(
                                          alignment: Alignment.center,
                                          child:
                                              this.eventModel.gendersId.isEmpty
                                                  ? Container(
                                                      margin: EdgeInsets.only(
                                                          top: 0, right: 2),
                                                      child: Image.asset(
                                                        "assets/forward.png",
                                                        width: 5,
                                                        height: 10,
                                                        fit: BoxFit.none,
                                                      ))
                                                  : Container(
                                                      margin: EdgeInsets.only(
                                                          top: 0, right: 2),
                                                      child: Image.asset(
                                                        "assets/checkmark.png",
                                                        width: 14,
                                                        height: 14,
                                                        // fit: BoxFit.none,
                                                      ),
                                                    ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () => {
                                    this.pushGenderViewController(),
                                  },
                                ),
                                Spacer(),
                                // SizedBox(height:3),
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

                          Container(
                            width: MediaQuery.of(context).size.width,
                            // color: Colors.yellow,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isAgeValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width: 2)),
                            height: 50,
                            margin: EdgeInsets.only(
                                left: 13, top: 0, right: 13, bottom: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    // color: Colors.yellow,
                                    height: 44,
                                    margin: EdgeInsets.only(
                                        left: 3, top: 0, right: 3, bottom: 0),

                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        GestureDetector(
                                          child: Container(
                                            color: Colors.white,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                60,
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Age",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.primaryText,
                                                fontFamily: "Muli",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          onTap: () => {
                                            this.pushAgeViewController(),
                                          },
                                        ),
                                        Spacer(),
                                        Align(
                                          alignment: Alignment.center,
                                          child: this.eventModel.ageId.isEmpty
                                              ? Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0, right: 2),
                                                  child: Image.asset(
                                                    "assets/forward.png",
                                                    width: 5,
                                                    height: 10,
                                                    fit: BoxFit.none,
                                                  ))
                                              : Container(
                                                  margin: EdgeInsets.only(
                                                      top: 0, right: 2),
                                                  child: Image.asset(
                                                    "assets/checkmark.png",
                                                    width: 14,
                                                    height: 14,
                                                    // fit: BoxFit.none,
                                                  ),
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () async => {
                                    // alldata
                                    this.pushAgeViewController(),
                                  },
                                ),
                                // SizedBox(height:5),
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

                          Container(
                            height: 58,
                            margin:
                                EdgeInsets.only(left: 13, top: 10, right: 13),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                                border: Border.all(
                                    color: isUserLimitValidation == true
                                        ? Color.fromARGB(255, 255, 1, 126)
                                        : Colors.transparent,
                                    width: 2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      left: 3, top: 0, right: 3),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Join User Limit",
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
                                  height: 19,
                                  margin: EdgeInsets.only(
                                    top: 3,
                                    left: 3,
                                    right: 3,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            height: 19,
                                            margin: EdgeInsets.only(right: 1),
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  child: UnstyledTextField(
                                                    child: TextFormField(
                                                      //  maxLength: 60,
                                                      onTap: () => {
                                                        isUserLimitValidation =
                                                            false,
                                                        if (mounted)
                                                          {
                                                            setState(() {}),
                                                          }
                                                      },
                                                      controller:
                                                          txtJoinUserLimit,
                                                      decoration: InputDecoration(
                                                          hintText:
                                                              "Please enter join user limit",
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                                  bottom: 5),
                                                          border:
                                                              InputBorder.none),
                                                      style:
                                                          UnstyledTextFieldTextStyle(),
                                                      maxLines: 1,
                                                      keyboardType:
                                                          TextInputType.number,
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

                          //     ],
                          //   ),
                          // ),

                          // Spacer(),
                          SizedBox(
                            height: 50,
                          ),

                          Container(
                            height: 50,
                            margin: EdgeInsets.only(
                                left: 16, right: 16, bottom: 37),
                            child: BlueButtonFullWidthButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () => {
                                // PickInvitation

                                _validateInputs(),

                                // Navigator.push(context, MaterialPageRoute(builder: (context) => PickInvitation())),
                              }, //this.onCreateSocialPressed(context),
                              child: Text(
                                "Create Social",
                                textAlign: TextAlign.center,
                                style: TextStyle(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<void> pushAgeViewController() async {
    FocusScope.of(context).unfocus();

    var allDataResult = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectAgeScreens(
                  createEventModel: this.eventModel,
                  alldata: this.alldata,
                  originalData: this.alldata,
                  isFromMeetNow: true,
                )));

    isAgeValidation = false;
    if (mounted) {
      setState(() {
        // isPush = false;
        // print(result);
        this.alldata = allDataResult;

        var selectAgeArr = List<GenerationIdentify>();
        this.alldata.generationIdentify.forEach((element) {
          if (element.isSelected == true) {
            selectAgeArr.add(element);
          }
        });

        if (selectAgeArr.length > 0) {
          var wantToMeetString = '';
          selectAgeArr.forEach((element) {
            if (element.isSelected == true) {
              if (wantToMeetString != '') {
                wantToMeetString = wantToMeetString +
                    ',' +
                    element.generationsIdentifyId.toString();
              } else {
                wantToMeetString = element.generationsIdentifyId.toString();
              }
            }
          });
          this.eventModel.ageId = wantToMeetString;
        }
      });
    }
    ;
  }

  Future<void> pushDescriptionScreen() async {
    FocusScope.of(context).unfocus();

    var strData = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EnterDescription(stringDesc: stringDesc)));
    isDescValidation = false;
    stringDesc = strData;
    String newString = strData.replaceAll("\n", " ");

    // if (newString.length > 50) {
    //   txtDescription.text =
    //       newString.substring(0, 50); //getInitials(newString);
    // } else {
    txtDescription.text = newString;
    // }
    if (mounted) {
      (() {});
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

  Future<void> pushSetDateAndTime() async {
    FocusScope.of(context).unfocus();

    var strData = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => EnterDateAndTimeScreen()));
    if (strData != null) {
      isTimeValidation = false;
      var newStr = strData;
      //     var formatter = new DateFormat("yyyy-MM-dd hh:mm a");
      var newDateTimeObj2 = new DateFormat("yyyy-MM-dd hh:mm a").parse(newStr);
      passDate = newStr;
      // var newDateTimeObj2 = new DateFormat("EEEE, MMM dd hh:mm a").parse(newStr);
      // var formatterTime = new DateFormat("EEEE, MMM dd hh:mm a");
      var timeFormate = new DateFormat("hh:mm a");
      var dateFormate = new DateFormat("yyyy-MM-dd");
      this.time = timeFormate.format(newDateTimeObj2);
      this.date = dateFormate.format(newDateTimeObj2);
      txtTime.text = this.time;
      txtDate.text = this.date;
      if (mounted) {
        setState(() {});
      }
    }
  }

  Future<BitmapDescriptor> _createMarkerImageFromAsset() async {
    ImageConfiguration configuration = ImageConfiguration();
    bitmapImage =
        await BitmapDescriptor.fromAssetImage(configuration, 'assets/pin.png');
    return bitmapImage;
  }

  Set<Marker> _getMarkerData() {
    Marker marker;
    //double lat, long;
    _createMarkerImageFromAsset();
    for (int i = 1; i <= 1; i++) {
      // setState(() {
      marker = new Marker(
          markerId: MarkerId(i.toString()),
          position: new LatLng(lat, long),
          // infoWindow: InfoWindow(title: "Dance Class", onTap: () {}),
          icon: bitmapImage);

      _markers.add(marker);
      // });
    }

    return _markers;
  }

  Future<void> pushGenderViewController() async {
    FocusScope.of(context).unfocus();
    if (this.alldata == null) {
      this.callMainDataApiApi();
    } else {
      var allDataResult = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectGenderAndIncome(
                  alldata: this.alldata,
                  createEventModel: this.eventModel,
                  originalData: this.alldata,
                  isFromMeetNow: true)));
      isGenderValidation = false;
      this.alldata = allDataResult;

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
        var professionString = '';
        selectArr.forEach((element) {
          if (element.isSelected == true) {
            if (professionString != '') {
              professionString =
                  professionString + ',' + element.whoEarnsId.toString();
            } else {
              professionString = element.whoEarnsId.toString();
            }
          }
        });
        this.eventModel.earningId = professionString;

        if (selectGenderArr.length > 0) {
          var genderIdString = '';
          selectGenderArr.forEach((element) {
            if (element.isSelected == true) {
              if (genderIdString != '') {
                genderIdString =
                    genderIdString + ',' + element.iWantToMeetId.toString();
              } else {
                genderIdString = element.iWantToMeetId.toString();
              }
            }
          });
          this.eventModel.gendersId = genderIdString;
        }
      }
      if (mounted) {
        //Do something
        setState(() {});
      }
    }
  }

  Future<void> pushSelectActivityViewController() async {
    FocusScope.of(context).unfocus();
    if (this.alldata == null) {
      this.callMainDataApiApi();
    } else {
      var alldataResult = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SelectActivityScreens(
                  alldata: this.alldata,
                  createEventModel: this.eventModel,
                  isFromMeetNow: true)));
      isActivityValidation = false;
      this.alldata = alldataResult;

      var selectIntrestArr = List<Interest>();
      this.alldata.interest.forEach((element) {
        if (element.isSelected == true) {
          selectIntrestArr.add(element);
        }
      });

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
        txtActivityTag.text = intrestString;
      }
      if (mounted) {
        setState(() {});
      }
    }
  }

  void _validateInputs() {
    FocusScope.of(context).unfocus();

    if (txtTitle.text == '') {
      titleFocusNode.unfocus();
      // SmartUtils.showErrorDialog(context, ValidationMessage.title_error);
      isTitleValidation = true;
      if (mounted) {
        setState(() {});
      }
    } else if (txtDescription.text == '') {
      isDescValidation = true;
      descriptionFocusNode.unfocus();
      if (mounted) {
        setState(() {});
      }
      // SmartUtils.showErrorDialog(context, ValidationMessage.description_error);
    } else if (txtActivityTag.text == '') {
      isActivityValidation = true;
      activityTagFocusNode.unfocus();
      if (mounted) {
        setState(() {});
      }
      // SmartUtils.showErrorDialog(context, ValidationMessage.activitytag_error);
    } else if (txtDate.text == '') {
      isDateValidation = true;
      dateFocusNode.unfocus();
      if (mounted) {
        setState(() {});
      }
      // SmartUtils.showErrorDialog(context, ValidationMessage.dateAndTime_error);
    } else if (txtTime.text == '') {
      isDateValidation = true;
      timeFocusNode.unfocus();
      if (mounted) {
        setState(() {});
      }
      // SmartUtils.showErrorDialog(context, ValidationMessage.dateAndTime_error);
    } else if (eventModel.gendersId == '') {
      isGenderValidation = true;
      if (mounted) {
        setState(() {});
      }
    } else if (eventModel.earningId == '') {
      isGenderValidation = true;
      if (mounted) {
        setState(() {});
      }
    } else if (eventModel.ageId == '') {
      isAgeValidation = true;
      if (mounted) {
        setState(() {});
      }
    } else if (txtJoinUserLimit.text == '') {
      joinUserLimitFocusNode.unfocus();
      // SmartUtils.showErrorDialog(context, ValidationMessage.title_error);
      isUserLimitValidation = true;
      if (mounted) {
        setState(() {});
      }
    } else if (this.selectImage == null) {
      SmartUtils.showErrorDialog(context, ValidationMessage.uploadImage);
      if (mounted) {
        setState(() {});
      }
    }

    // JoinUserLimite
    else {
      eventModel.title = txtTitle.text;
      eventModel.description = stringDesc;
      eventModel.selectImage = this.selectImage;
      eventModel.location = strLocation.isEmpty
          ? "N/A"
          : strLocation; //txtSearch.text.isEmpty ? "N/A":txtSearch.text;
      eventModel.lat = this.lat ?? 00;
      eventModel.long = this.long ?? 00;

      var newDateTimeObj2 =
          new DateFormat("yyyy-MM-dd hh:mm a").parse(passDate);
      var passdateFormate = new DateFormat("yyyy-MM-dd HH:mm");
      var newPassDate = passdateFormate.format(newDateTimeObj2);
      eventModel.date = newPassDate;

      this.createEventAPI(eventModel, this.alldata);
    }
  }

  void createEventAPI(
      CreateEventModel eventModel, AllDataModel allDataModel) async {
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
    AppMultiPartFile uploadfile =
        AppMultiPartFile(localFile: eventModel.selectImage, key: 'Image');

    //TODO : CALL signup Api Here
    var request = CreateEventRequest();
    request.title = eventModel.title;
    request.date = eventModel.date; //'Female';
    request.description = eventModel.description;
    request.location = eventModel.location;
    request.latitude = eventModel.lat.toString();
    request.longititude = eventModel.long.toString();
    request.languageId = '1';
    request.activityTagIDs = eventModel.intrestId;
    request.income = eventModel.earningId;
    request.age = eventModel.ageId;
    request.invitedUserIDs = '2,3';
    request.gendars = eventModel.gendersId;
    request.joinUserLimit = txtJoinUserLimit.text;

    List<AppMultiPartFile> arrFile;
    if (uploadfile.localFile != null) {
      arrFile = [uploadfile];
    }

    CreateEventResponse response = await ApiProvider()
        .callCreateEventApi(params: request, arrFile: arrFile);

    Navigator.pop(context); //pop dialog

    new Future.delayed(new Duration(seconds: 1), () {
      if (response.status == true) {
        //  SmartUtils.showErrorDialog(context, response.message);
        // new Future.delayed(new Duration(seconds: 2), () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PickInvitation(
              eventId: response.eventData.eventId,
              alldata: this.alldata,
            ),
          ),
        );

        // Navigator.of(context).pushAndRemoveUntil(
        //       MaterialPageRoute(builder: (_) => HomeEvent()),
        //       (Route<dynamic> route) => false);
        //  });

        //   this.setDataInToUserModel(response.user, preferences);
      } else {
        SmartUtils.showErrorDialog(context, response.message);
      }
    });

    // }
    // return response;
  }

  void callMainDataApiApi() async {
    //TODO : call Api Here

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

    var response = await ApiProvider().callMainDataApi();

    // Navigator.pop(context); //pop dialog

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

  showGoogleMap() async {
    LocationResult result = await showLocationPicker(
      context,
      'AIzaSyAcFxt9w_8X_0G5j1VTZuTL4BvhChT9cYI', //'AIzaSyB73WfgoTy0WEkuWFvCe3Kfb7Y8Rpp9J0Y',
      initialCenter: LatLng(lat ?? 00, long ?? 00),
//                      automaticallyAnimateToCurrentLocation: true,
      //  mapStylePath: 'assets/mapStyle.json',
      myLocationButtonEnabled: true,
      layersButtonEnabled: true,
//                      resultCardAlignment: Alignment.bottomCenter,
    );
    print("result = $result");
    if (result != null) {
      strLocation = result.address ?? '';
      // if (strLocation.length > 40) {
      //   txtSearch.text = strLocation.substring(0, 40);
      // } else {
      txtSearch.text = strLocation;
      // }
      lat = result.latLng.latitude;
      long = result.latLng.longitude;
      _getMarkerData();
      _pickedLocation = result;
      changeLocationORShowLocation();
      if (mounted) {
        setState(() {});
      }
    }
  }

  void _onFocusChangeDate() {
    if (dateFocusNode.hasFocus == true) {
      dateFocusNode.unfocus();
      titleFocusNode.unfocus();
      FocusScope.of(context).unfocus();

      pushSetDateAndTime();
      //  showDatePickerWiddgetDate(context);
    }
    // debugPrint("Focus: "+__focus.toString());
  }

  void _onFocusChangeTime() {
    if (timeFocusNode.hasFocus == true) {
      timeFocusNode.unfocus();
      titleFocusNode.unfocus();

      pushSetDateAndTime();
      //  showTimePickerWiddgetDate(context);
    }
    // debugPrint("Focus: "+__focus.toString());
  }

  Future<void> changeLocationORShowLocation() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat ?? 0, long ?? 0),
      zoom: 14.4746,
    )));
  }

  void _onFocusChangeSearch() {
    if (searchFocusNode.hasFocus == true) {
      searchFocusNode.unfocus();
      //  showDatePickerWiddgetDate(context);
      showGoogleMap();
    }
    // debugPrint("Focus: "+__focus.toString());
  }

//  showDatePickerWiddgetDate(BuildContext context) async {

//   final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2020, 4),
//         lastDate: DateTime(2101));
//     if (picked != null)
//       setState(() {
//         DateFormat dateFormat = DateFormat("MM-dd-yyyy");
//         String formattedDate = dateFormat.format(picked);
//         this.date = formattedDate. toString();//format(context).toString();
//         this.txtDateAndTime.text = formattedDate.toString();
//       });
//  }

//  showTimePickerWiddgetDate(BuildContext context) async {

//   final DateTime picked = await showTimePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2020, 4),
//         lastDate: DateTime(2101));
//     if (picked != null)
//       setState(() {
//         DateFormat dateFormat = DateFormat("MM-dd-yyyy");
//         String formattedDate = dateFormat.format(picked);
//         this.date = formattedDate. toString();//format(context).toString();
//         this.txtDateAndTime.text = formattedDate.toString();
//       });
//  }

}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
