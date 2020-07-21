import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simposi/Screens/LoginScreen.dart';
import 'package:simposi/Screens/ProfileScreen/AboutUsScreen.dart';
import 'package:simposi/Screens/ProfileScreen/EditProfileScreen.dart';
import 'package:simposi/Screens/ProfileScreen/FAQScreens.dart';
import 'package:simposi/Screens/ProfileScreen/PlanPurchaseScreen.dart';
import 'package:simposi/Screens/ProfileScreen/PrivacyPolicyScreen.dart';
import 'package:simposi/Screens/ProfileScreen/ResetPasswordScreen.dart';
import 'package:simposi/Screens/ProfileScreen/TermsAndCondition.dart';
import 'package:simposi/String/app_string.dart';
import 'package:simposi/Utils/Utility/AppManager.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/Utility/Values/gradients.dart';
import 'package:simposi/Utils/Utility/Values/radii.dart';
import 'package:simposi/Utils/Utility/subscribe_button.dart';
// import 'package:simposi/Screens/ProfileScreen/TermsAndConditionScreen.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

import 'dart:async';

import 'package:simposi/Utils/smartutils.dart';
//import 'package:flutter/material.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
//import 'consumable_store.dart';

class ProfileScreen extends StatefulWidget {
  bool kAutoConsume = true;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  StreamSubscription _purchaseUpdatedSubscription;
  StreamSubscription _purchaseErrorSubscription;
  StreamSubscription _conectionSubscription;
  final List<String> _productLists = Platform.isAndroid
      ? ['com.monthlypackage', 'com.yearlypackage', 'com.invitationcard.event']
      : ['com.monthlypackage', 'com.yearlypackage', 'com.invitationcard.event'];

// //  String _kConsumableId = 'consumable';
//   List<String> _kProductIds = <String>[
//     'com.monthlypackage',
//     'com.yearlypackage',
//     'com.invitationcard.event'
//   ];

  String _platformVersion = 'Unknown';
  List<IAPItem> _items = [];
  List<PurchasedItem> _purchases = [];
  bool isLoading = true;

  SharedPreferences preferences;
  // StreamSubscription<List<PurchaseDetails>> _subscription;

  void onSubscribePressed(BuildContext context) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => PlanPurchaseScreen()));

    // PlanPurchaseScreen

    showModalBottomSheet(
        context: context,
        clipBehavior: Clip.hardEdge,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              color: Colors.transparent,
              child: new Wrap(
                children: <Widget>[showPlansView()],
              ),
            ),
          );
        } //
        );
  }

  Widget showPlansView() {
    return Container(
      height: 600,
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 600,
            decoration: BoxDecoration(
              color: AppColors.primaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Container(),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 0, top: 0, right: 0),
            child: Image.asset(
              "assets/subscribeBackground@3x.png",
              // "assets/mask-8.png",
              fit: BoxFit.fill,
            ),
          ),
          Container(
            height: 600,
            margin: EdgeInsets.only(top: 00, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Container(
                  margin: EdgeInsets.only(left: 0, top: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Subscribe for",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          // top: 409,
                          margin: EdgeInsets.only(top: 20),
                          child: Text(
                            "Unlimited Access",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w800,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                    title: new Text(
                                      "Confirm Your In-App Purchase",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        // color: Color.fromARGB(255, 0, 0, 0),
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        letterSpacing: -0.408,
                                        height: 1.29412,
                                      ),
                                    ),
                                    content: new Text(
                                      "Do you want to buy \$50 Year Unlimited Access Plan?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        // color: Color.fromARGB(255, 0, 0, 0),
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        letterSpacing: -0.078,
                                        height: 1.23077,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        onPressed: () => {
                                          print('not now'),
                                          Navigator.pop(context),
                                          purchasePlanYearly(),
                                        },
                                        isDefaultAction: true,
                                        child: Text(
                                          "Not Now",
                                        ),
                                      ),
                                      CupertinoDialogAction(
                                        onPressed: () => {
                                          print('buy now'),
                                          Navigator.pop(context),

                                          // createEventAPI(this.createEventModel, this.alldata)
                                          // callPurchaseInvitationCardApi(),
                                        },
                                        child: Text(
                                          "Buy",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            // color: Colors.white,//Color.fromARGB(255, 0, 122, 255),
                                            fontFamily: "Helvetica",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17,
                                            letterSpacing: 0.408,
                                            height: 1.29412,
                                          ),
                                        ),
                                      )
                                    ],
                                  ))
                        },

                        //   child:Align(
                        //   alignment: Alignment.topCenter,
                        //   child: Container(
                        //     width: 300,
                        //     height: 50,
                        //     margin: EdgeInsets.only(bottom: 48),
                        //     decoration: BoxDecoration(
                        //       color: Color.fromARGB(255, 25, 39, 240),
                        //       borderRadius: Radii.k25pxRadius,
                        //     ),
                        //     child: Column(
                        //       children: [
                        //         Container(
                        //           margin: EdgeInsets.only(top: 18),
                        //           child: Text(
                        //             "\$50 / Year Unlimited Access",
                        //             textAlign: TextAlign.center,
                        //             style: TextStyle(
                        //               color: AppColors.secondaryText,
                        //               fontFamily: "Muli",
                        //               fontWeight: FontWeight.w700,
                        //               fontSize: 15,
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 25, 39, 240),
                              borderRadius: Radii.k25pxRadius,
                            ),
                            margin: EdgeInsets.only(top: 100),
                            child: Center(
                              child: Text(
                                "\$50 / Year Unlimited Access",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.secondaryText,
                                  fontFamily: "Muli",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: EdgeInsets.only(top: 0),
                          child: Text(
                            "First Year free",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 25, 39, 240),
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w700,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                      // Spacer(),
                      SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () => {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                    title: new Text(
                                      "Confirm Your In-App Purchase",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        // color: Color.fromARGB(255, 0, 0, 0),
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                        letterSpacing: -0.408,
                                        height: 1.29412,
                                      ),
                                    ),
                                    content: new Text(
                                      "Do you want to buy \$5 Month Unlimited Access Plan?",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        // color: Color.fromARGB(255, 0, 0, 0),
                                        fontFamily: "Helvetica",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                        letterSpacing: -0.078,
                                        height: 1.23077,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        onPressed: () => {
                                          print('not now'),
                                          Navigator.pop(context),
                                        },
                                        isDefaultAction: true,
                                        child: Text(
                                          "Not Now",
                                        ),
                                      ),
                                      CupertinoDialogAction(
                                        onPressed: () => {
                                          print('buy now'),
                                          Navigator.pop(context),
                                          // createEventAPI(this.createEventModel, this.alldata)
                                          // callPurchaseInvitationCardApi(),

                                          this._getProduct(),

                                          callMonthlyPlan()
                                        },
                                        child: Text(
                                          "Buy",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            // color: Colors.white,//Color.fromARGB(255, 0, 122, 255),
                                            fontFamily: "Helvetica",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17,
                                            letterSpacing: 0.408,
                                            height: 1.29412,
                                          ),
                                        ),
                                      )
                                    ],
                                  ))
                        },
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 300,
                            height: 50,
                            decoration: BoxDecoration(
                              // color: Color.fromARGB(255, 25, 39, 240),
                              borderRadius: Radii.k25pxRadius,
                              border: Border.all(
                                width: 1, //
                                color: Color.fromARGB(255, 25, 39,
                                    240), //            <--- border width here
                              ),
                            ),
                            margin: EdgeInsets.only(top: 0),
                            child: Center(
                              child: Text(
                                "\$5 / Month Unlimited Access",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 25, 39, 240),
                                  fontFamily: "Muli",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // child: Align(
                        //   alignment: Alignment.topCenter,
                        //   child: Container(
                        //     margin: EdgeInsets.only(bottom: 41),
                        //     child: Text(
                        //       "\$5 / Month Unlimited Access",
                        //       textAlign: TextAlign.center,
                        //       style: TextStyle(
                        //         color: Color.fromARGB(255, 25, 39, 240),
                        //         fontFamily: "Muli",
                        //         fontWeight: FontWeight.w700,
                        //         fontSize: 15,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.only(right: 0, bottom: 45),
                          child: Text(
                            "Restore Purchases",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "Terms & Conditions Apply",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.accentText,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();

    //  initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterInappPurchase.instance.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // prepare
    var result = await FlutterInappPurchase.instance.initConnection;
    print('result: $result');

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    // refresh items for android
    try {
      String msg = await FlutterInappPurchase.instance.consumeAllItems;
      print('consumeAllItems: $msg');
    } catch (err) {
      print('consumeAllItems error: $err');
    }

    _conectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
      print('connected: $connected');
    });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      print('purchase-updated: $productItem');
    });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
      print('purchase-error: $purchaseError');
    });
  }

  void _requestPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestPurchase(item.productId);
  }

  Future _getProduct() async {
    List<IAPItem> items =
        await FlutterInappPurchase.instance.getProducts(_productLists);
    for (var item in items) {
      print('${item.toString()}');
      this._items.add(item);
    }

    setState(() {
      this._items = items;
      this._purchases = [];
    });
  }

  @override
  void dispose() {
    // _subscription.cancel();
    super.dispose();
    if (_conectionSubscription != null) {
      _conectionSubscription.cancel();
      _conectionSubscription = null;
    }
  }

  void init() async {
    preferences = await SharedPreferences.getInstance();
    isLoading = false;
    setState(() {});
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

  Future<void> openSettingMenu() async {
    return showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          // title: Text(''),
          // message: Text('Please select the best dessert from the options below.'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text('Edit Profile'),
              onPressed: () {
                Navigator.of(context).pop();

                pushToEditProfile();
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Reset Password'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResetPasswoedScreen()));
              },
            ),
            CupertinoActionSheetAction(
              child: Text('FAQ'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FAQScreens()));
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Terms & Condition'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TermsAndConditionScreen()));
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Privacy Policy'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PrivacyPolicyScreen()));
              },
            ),
            CupertinoActionSheetAction(
              child: Text('About Us'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUsScreens()));
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Contact Us'),
              onPressed: () async {
                Navigator.of(context).pop();
                await FlutterEmailSender.send(email);
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Delete Account'),
              onPressed: () {
                //Navigator.of(context).pop(); },

                showDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: new Text(
                      "Delete Account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: "Helvetica",
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        letterSpacing: -0.408,
                        height: 1.29412,
                      ),
                    ),
                    content: new Text(
                      AppStrings.dt_deleteAccount,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: "Helvetica",
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        letterSpacing: -0.078,
                        height: 1.23077,
                      ),
                    ),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        onPressed: () => {
                          print('not now'),
                          Navigator.pop(context),
                        },
                        isDefaultAction: true,
                        child: Text(
                          "Cancel",
                        ),
                      ),
                      CupertinoDialogAction(
                        onPressed: () => {
                          callDeleteAccountApi(),
                        },
                        child: Text(
                          "Delete Account",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // color: Colors.white,//Color.fromARGB(255, 0, 122, 255),
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            letterSpacing: 0.408,
                            height: 1.29412,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            CupertinoActionSheetAction(
              child: Text('Sign Out'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => CupertinoAlertDialog(
                    title: new Text(
                      "Sign Out",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: "Helvetica",
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        letterSpacing: -0.408,
                        height: 1.29412,
                      ),
                    ),
                    content: new Text(
                      AppStrings.dt_logout,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: "Helvetica",
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        letterSpacing: -0.078,
                        height: 1.23077,
                      ),
                    ),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        onPressed: () => {
                          print('not now'),
                          Navigator.pop(context),
                        },
                        isDefaultAction: true,
                        child: Text(
                          "Cancel",
                        ),
                      ),
                      CupertinoDialogAction(
                        onPressed: () => {
                          AppManager.logout(this.preferences),
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                              (Route<dynamic> route) => false),
                        },
                        child: Text(
                          "Sign Out",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // color: Colors.white,//Color.fromARGB(255, 0, 122, 255),
                            fontFamily: "Helvetica",
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            letterSpacing: 0.408,
                            height: 1.29412,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  void showLoader() {
    if (isLoading == false) {
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
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? _centerLoading()
          : Container(
              // height: MediaQuery.of(context).size.height,
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
              ),

              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height - 100, //706,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        height: 51,
                        margin: EdgeInsets.only(left: 15, top: 46, right: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 300,
                              height: 51,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Text(
                                      // "Flora",
                                      preferences.getString('userName'),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: AppColors.primaryText,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w800,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 2,
                                    top: 35,
                                    child: Text(
                                      // "Vancouver",
                                      preferences.getString('location') == null
                                          ? 'N/A'
                                          : preferences.getString('location'),

                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: AppColors.accentText,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Container(
                              height: 30,
                              width: 30,
                              margin: EdgeInsets.only(top: 10),
                              child: GestureDetector(
                                child: Image.asset(
                                  "assets/settings.png",
                                  height: 30,
                                  width: 30,
                                ),
                                onTap: () => {
                                  openSettingMenu(),
                                  //                       showDialog(
                                  //                         context: context,
                                  //                         builder: (BuildContext context) {
                                  //                           // return object of type Dialog
                                  //                           return AlertDialog(
                                  //                             backgroundColor: Colors.white,
                                  //                             shape: RoundedRectangleBorder(
                                  //                                 borderRadius:
                                  //                                     BorderRadius.all(Radius.circular(10.0))),
                                  //                             title: new Text(AppStrings.logout,
                                  //                                 style: TextStyle(
                                  //                                     fontSize: 16, fontWeight: FontWeight.normal,fontFamily: 'Brown',
                                  // )),
                                  //                             titleTextStyle: TextStyle(
                                  //                                 color: Colors.black),
                                  //                             contentTextStyle:
                                  //                                 TextStyle(color: Colors.grey),
                                  //                             content: new Text(
                                  //                               AppStrings.dt_logout,
                                  //                               style: TextStyle(
                                  //                                   fontSize: 12, fontWeight: FontWeight.normal, fontFamily: 'Brown',),
                                  //                             ),
                                  //                             actions: <Widget>[
                                  //                               // usually buttons at the bottom of the dialog
                                  //                               new FlatButton(
                                  //                                 child: new Text(AppStrings.no),
                                  //                                 textColor: Colors.black,
                                  //                                 onPressed: () {
                                  //                                   Navigator.of(context).pop();
                                  //                                 },
                                  //                               ),

                                  //                               new FlatButton(
                                  //                                 child: new Text(AppStrings.yes),
                                  //                                 textColor: Colors.black,
                                  //                                 onPressed: () {

                                  //                                   AppManager.logout(this.preferences);

                                  //                                   Navigator.of(context).pushAndRemoveUntil(
                                  //                                   MaterialPageRoute(builder: (_) => LoginScreen()),
                                  //                                  (Route<dynamic> route) => false);

                                  //                                 },
                                  //                               ),
                                  //                             ],
                                  //                           );
                                  //                         },
                                  //                       ),
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          margin: EdgeInsets.only(top: 9),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Positioned(
                                // Container(
                                // margin: EdgeInsets.only(left:1,right:0,top:0),
                                left: 1,
                                top: 0,
                                right: 1,
                                child: Container(
                                  height: MediaQuery.of(context).size.height -
                                      125, //706,
                                  decoration: BoxDecoration(
                                    gradient: Gradients.primaryGradient,
                                  ),
                                  // child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context)
                                                      .size
                                                      .height >
                                                  800
                                              ? 326
                                              : MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.70, //326,
                                          child: preferences.getString(
                                                      'profilePhoto') !=
                                                  null
                                              ? Image.network(
                                                  preferences.getString(
                                                      'profilePhoto'),
                                                  // "assets/rectangle-6.png",
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
                                      // SizedBox(height: 10,),
                                      Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            gradient:
                                                Gradients.secondaryGradient,
                                          ),
                                          child: Row(children: [
                                            Spacer(),
                                            Center(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "0",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: AppColors
                                                            .primaryText,
                                                        fontFamily: "Muli",
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: 1),
                                                      child: Text(
                                                        "Invitiations",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Color.fromARGB(
                                                              255,
                                                              187,
                                                              187,
                                                              187),
                                                          fontFamily: "Muli",
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                            ),
                                            Spacer(),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "0",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color:
                                                        AppColors.primaryText,
                                                    fontFamily: "Muli",
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  "Events Attended",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 187, 187, 187),
                                                    fontFamily: "Muli",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "0",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color:
                                                          AppColors.primaryText,
                                                      fontFamily: "Muli",
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.only(top: 1),
                                                    child: Text(
                                                      "People Met",
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 187, 187, 187),
                                                        fontFamily: "Muli",
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13,
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                            Spacer(),
                                          ])),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          // width: 288,
                                          // height: 100,
                                          margin: EdgeInsets.only(
                                            top: 44,
                                            left: 40,
                                            right: 40,
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "Get Unlimited Access",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: AppColors.primaryText,
                                                  fontFamily: "Muli",
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 19,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 1),
                                                child: Text(
                                                  "Subscribe for unlimited access and meet as many people as you like.",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: AppColors.accentText,
                                                    fontFamily: "Muli",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15,
                                                    height: 1.2,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      //  Spacer(),

                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          width: 200,
                                          height: 40,
                                          //  margin: EdgeInsets.only(bottom: 130),
                                          child: SubscribeButtonButton(
                                            padding: EdgeInsets.all(0),
                                            onPressed: () => this
                                                .onSubscribePressed(context),
                                            child: Text(
                                              "Subscribe",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      // Container(
                                      //                                   margin: EdgeInsets.only(top: 1),
                                      //                                   child: Text(
                                      //                                     "Subscription not required.\nFree Users get access to one social/month.",
                                      //                                     textAlign: TextAlign.center,
                                      //                                     style: TextStyle(
                                      //                                       color: AppColors.accentText,
                                      //                                       fontFamily: "Muli",
                                      //                                       fontWeight: FontWeight.w400,
                                      //                                       fontSize: 15,
                                      //                                       height: 1.2,
                                      //                                     ),
                                      //                                   ),
                                      //                                 ),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          height: 60,
                                          // margin: EdgeInsets.only(bottom: 30),
                                          child: Text(
                                            "Subscription not required.\nFree Users get access to one social/month.",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColors.accentText,
                                              fontFamily: "Muli",
                                              fontWeight: FontWeight.w400,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  // void handleError(IAPError error) {
  //   setState(() {
  //     _purchasePending = false;
  //   });
  // }

  // Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {
  //   // IMPORTANT!! Always verify a purchase before delivering the product.
  //   // For the purpose of an example, we directly return true.
  //   return Future<bool>.value(true);
  // }

  purchasePlanYearly() async {
    //  Set<String> _kIds = {'com.monthlypackage', 'com.yearlypackage'};
    // final ProductDetailsResponse response = await InAppPurchaseConnection.instance.queryProductDetails(_kIds);
    // if (!response.notFoundIDs.isEmpty) {
    //     // Handle the error.
    // }
    //   List<ProductDetails> products = response.productDetails;

    // final ProductDetails productDetails = products[0]; // Saved earlier from queryPastPurchases().

    //   final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
    //     InAppPurchaseConnection.instance.buyConsumable(purchaseParam: purchaseParam);

    //   purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
    //   if (purchaseDetails.status == PurchaseStatus.pending) {
    //     // showPendingUI();
    //   } else {
    //     if (purchaseDetails.status == PurchaseStatus.error) {
    //       handleError(purchaseDetails.error);
    //     } else if (purchaseDetails.status == PurchaseStatus.purchased) {
    //       bool valid = await _verifyPurchase(purchaseDetails);
    //       if (valid) {
    //         deliverProduct(purchaseDetails);
    //       } else {
    //         _handleInvalidPurchase(purchaseDetails);
    //         return;
    //       }
    //     }
    //     if (Platform.isAndroid) {
    //       if (!kAutoConsume && purchaseDetails.productID == _kConsumableId) {
    //         await InAppPurchaseConnection.instance
    //             .consumePurchase(purchaseDetails);
    //       }
    //     }
    //     if (purchaseDetails.pendingCompletePurchase) {
    //       await InAppPurchaseConnection.instance
    //           .completePurchase(purchaseDetails);
    //     }
    //   }
    // });
  }

  // InAppPurchaseConnection.instance.buyNonConsumable(purchaseParam: )
  //   if (_isConsumable(productDetails)) {
  //     InAppPurchaseConnection.instance.buyConsumable(purchaseParam: purchaseParam);
  // } else {
  //     InAppPurchaseConnection.instance.buyNonConsumable(purchaseParam: purchaseParam);
  // }
  // }

  final Email email = Email(
    body: '',
    subject: '',
    recipients: ['support@simposi.com'],
    // cc: ['cc@example.com'],
    // bcc: ['bcc@example.com'],
    // attachmentPaths: ['/path/to/attachment.zip'],
    isHTML: false,
  );

  pushToEditProfile() async {
    var alldataResult = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditProfileScreen()));

    setState(() {});
  }

  callMonthlyPlan() {
    _requestPurchase(_items[0]);
  }

  callDeleteAccountApi() async {
    //TODO : CALL delete Api Here

    DeleteAccoundResponse responseBusiness =
        await ApiProvider().callDeleteAccountApi();

    print(responseBusiness);
    if (responseBusiness.status == true) {
      AppManager.logout(this.preferences);

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => LoginScreen()),
          (Route<dynamic> route) => false);

      // if (mounted) {
      //   setState(() {});
      // }
      // DateTime.now();

    } else {
      SmartUtils.showErrorDialog(context, responseBusiness.message);
    }
  }

  // Future _getPurchases() async {
  //   List<PurchasedItem> items =
  //       await FlutterInappPurchase.instance.getAvailablePurchases();
  //   for (var item in items) {
  //     print('${item.toString()}');
  //     this._purchases.add(item);
  //   }

  //   setState(() {
  //     this._items = [];
  //     this._purchases = items;
  //   });
  // }

  // Future _getPurchaseHistory() async {
  //   List<PurchasedItem> items =
  //       await FlutterInappPurchase.instance.getPurchaseHistory();
  //   for (var item in items) {
  //     print('${item.toString()}');
  //     this._purchases.add(item);
  //   }

  //   setState(() {
  //     this._items = [];
  //     this._purchases = items;
  //   });
  // }
  // void _requestPurchase(IAPItem item) {
  //   FlutterInappPurchase.instance.requestPurchase(item.productId);
  // }
}
