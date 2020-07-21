import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simposi/Screens/ProfileScreen/ProfileScreen.dart';
import 'package:simposi/Screens/TabViewController/AlertScreen/AlertScreen.dart';
import 'package:simposi/Screens/TabViewController/DiscoverViewScreen/DiscoverViewScreen.dart';
import 'package:simposi/Screens/TabViewController/HomeEventScreen.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/smartutils.dart';

class MainTabView extends StatefulWidget {
  @override
  _MainTabViewState createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView>
    with SingleTickerProviderStateMixin {
  // SharedPreferences preferences;
  // Logger logger;

  static const TAB_HOME = 0;
  static const TAB_BOOKING = 1;
  static const TAB_PROFILE = 2;
  static const TAB_MORE = 3;

  int currentIndex = TAB_HOME;
  int userId = 0;
  int userType = 0;
  bool isLoding = false;

  var socialCount = '0';
  var discoverCount = '0';
  var alertCount = '0';

  List<Widget> _list = [
    HomeEvent(),
    DiscoverViewScreen(),
    AlertScreen(),
    ProfileScreen(),
    // More()
  ];

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _currentTabIndex = 0;
  // TabController _tabController;

  // MainHomeState();

  Widget currentScreen = HomeEvent();

/*
  void onTappedBar(int index) {
    // if (index != 0){
    //       var userId = preferences.getInt('userId');
    //       if (userId != null && userId != '0'){
    //           setState(() {
    //                 currentIndex = index;
    //           });
    //       }else{
    //             //guest user
    //               SmartUtils.showErrorDialog(context, 'Please login for use this function.');

    //       }
    // }else{
if (mounted){
      setState(() {
      currentIndex = index;
    });
}

    // }
    
  }*/

  @override
  void initState() {
    init();
    // super.initState();
    // _tabController = new TabController(length: 4, vsync: this);

    if (mounted) {
      setState(() {
        currentIndex = 0;
      });
    }
  }

  void init() async {
    //  preferences = await SharedPreferences.getInstance();
    //  userId = preferences.getInt('userId');
    //  this.userType = preferences.getInt('userType') ?? 0;

    if (userType != null && isLoding == false) {
      isLoding = true;
      //  if (mounted) {
      setState(() {});
      //}

      new Future.delayed(new Duration(seconds: 0), () {
        //Future.delayed(Duration.zero, () async {
        this.callBadgeApi();
      });
    }
    // if (userType != null) {
    //   if (userType == 3) {
    //         _list = [
    //             Home(),
    //             JobListCurrent(),
    //             Profile(),
    //             More()
    //           ];
    //   } else {
    //      _list = [
    //             Home(),
    //             Booking(),
    //             Profile(),
    //             More()
    //           ];
    //   }
    // }

    //  getLocation();
  }

  void getLocation() async {
    // Position position = await Geolocator()
    //     .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    // print(position);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loadJobListing();
  }

  Widget loadJobListing() {
    final bool iphonex = MediaQuery.of(context).size.height >= 812.0;
    final double bottomPadding = iphonex ? 16.0 : 0.0;
// this is new container
    return new Container(
        child: new Stack(
      children: <Widget>[
        new Scaffold(
          backgroundColor: Colors.white,
          body: _list[currentIndex],
          bottomNavigationBar: new Container(
            padding: EdgeInsets.only(bottom: bottomPadding, left: 0),
            child: new Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    child: new Container(
                      // decoration: currentIndex==0?decorationSelected:null,
                      height: 66,
                      child: Stack(
                        children: [
                          new Column(
                            children: <Widget>[
                              Center(
                                child: new Container(
                                    color: Colors.white,
                                    margin: EdgeInsets.all(
                                        10), //only(t,bottom: 10),
                                    height: 25,
                                    width: 25,
                                    child: new Image.asset(
                                      currentIndex == 0
                                          ? "assets/calendar@3x.png"
                                          : "assets/calendarnormal@3x.png",
                                      height: 20,
                                      width: 20,
                                    )),
                              ),
                              Center(
                                  child: new Text(
                                "Socials",
                                style: TextStyle(
                                  color: currentIndex == 0
                                      ? SmartUtils.darkGrayColorText
                                      : SmartUtils.lighGrayColorText,
                                  fontFamily: "Muli",
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12,
                                ),
                              ))
                            ],
                          ),
                          Positioned(
                            left: 57,
                            top: 0,
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 1, 126),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(9)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Container(
                                    width: 18,
                                    margin: EdgeInsets.only(left: 0, right: 0),
                                    child: Text(
                                      socialCount,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: AppColors.secondaryText,
                                        fontFamily: "Muli",
                                        fontWeight: FontWeight.w800,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () => {
                      // if (mounted){
                      currentIndex = 0,
                      _onTap(currentIndex)
                      // },Django
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    child: new Container(
                        color: Colors.white,
                        // decoration: currentIndex==1?decorationSelected:null,
                        height: 66,
                        child: Stack(
                          children: [
                            new Column(
                              children: <Widget>[
                                Center(
                                  child: new Container(
                                      margin: EdgeInsets.all(10),
                                      height: 25,
                                      width: 25,
                                      child: new Image.asset(
                                        currentIndex == 1
                                            ? "assets/group9@3x.png"
                                            : "assets/cardDeck@3x.png",
                                        height: 20,
                                        width: 20,
                                      )),
                                ),
                                Center(
                                  child: new Text(
                                    "Discover",
                                    style: TextStyle(
                                      color: currentIndex == 1
                                          ? Colors.black
                                          : SmartUtils.lighGrayColorText,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 12,
                                    ),
                                  ),
                                ), //:new Text("My Job",style: TextStyle(color: currentIndex==1?Colors.white : Colors.black, fontSize: 14,),)
                              ],
                            ),
                            Positioned(
                              left: 55,
                              top: 0,
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 255, 1, 126),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(9)),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      width: 18,
                                      margin:
                                          EdgeInsets.only(left: 0, right: 0),
                                      child: Text(
                                        discoverCount,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: AppColors.secondaryText,
                                          fontFamily: "Muli",
                                          fontWeight: FontWeight.w800,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                    onTap: () => {currentIndex = 1, _onTap(currentIndex)},
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    child: new Container(
                      color: Colors.white,
                      // decoration: currentIndex==2?decorationSelected:null,
                      height: 66,
                      child: Stack(children: [
                        new Column(
                          children: <Widget>[
                            Center(
                              child: new Container(
                                  margin: EdgeInsets.all(10),
                                  height: 25,
                                  width: 25,
                                  child: new Image.asset(
                                    currentIndex == 2
                                        ? "assets/alertsSelected@3x.png"
                                        : "assets/alerts@3x.png",
                                    height: 20,
                                    width: 20,
                                  )),
                            ),
                            Center(
                                child: new Text(
                              "Alerts",
                              style: TextStyle(
                                color: currentIndex == 2
                                    ? Colors.black
                                    : SmartUtils.lighGrayColorText,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w800,
                                fontSize: 12,
                              ),
                            ) //:new Text("Availability",style: TextStyle(color: currentIndex==1?Colors.white : Colors.black, fontSize: 14,),)
                                ),
                            // new Text("Profile",style: TextStyle(color: currentIndex==2?Colors.white : Colors.black, fontSize: 14,),)
                          ],
                        ),
                        Positioned(
                          left: 53,
                          top: 0,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 1, 126),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  width: 18,
                                  margin: EdgeInsets.only(left: 0, right: 0),
                                  child: Text(
                                    alertCount,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.secondaryText,
                                      fontFamily: "Muli",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 11,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                    onTap: () => {
                      currentIndex = 2,
                      _onTap(currentIndex)
                      // SmartUtils.showErrorDialog(context, 'Comming Soon.')
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    child: new Container(
                      color: Colors.white,
                      // decoration: currentIndex==3?decorationSelected:null,
                      height: 66,
                      child: new Column(
                        children: <Widget>[
                          Center(
                            child: new Container(
                                margin: EdgeInsets.all(10),
                                height: 25,
                                width: 25,
                                child: new Image.asset(
                                  currentIndex == 3
                                      ? "assets/selectedprofile@3x.png"
                                      : "assets/profile@3x.png",
                                  height: 20,
                                  width: 20,
                                )),
                          ),
                          Center(
                              child: new Text(
                            "Profile",
                            style: TextStyle(
                              color: currentIndex == 3
                                  ? Colors.black
                                  : SmartUtils.lighGrayColorText,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w800,
                              fontSize: 12,
                            ),
                          )),
                        ],
                      ),
                    ),
                    onTap: () => {
                      if (mounted) {currentIndex = 3, _onTap(currentIndex)}
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }

  _onTap(int tabIndex) {
    switch (tabIndex) {
      case 0:
        // _navigatorKey.currentState.pushReplacementNamed("Home");

        break;
      case 1:
        // _navigatorKey.currentState.pushReplacementNamed("Booking");
        break;
      case 2:
        // _navigatorKey.currentState.pushReplacementNamed("Profile");
        break;
      case 3:
        // _navigatorKey.currentState.pushReplacementNamed("More");
        break;
    }
    if (mounted) {
      setState(() {
        // _currentTabIndex = tabIndex;
      });
    }
  }

  Route<dynamic> generateRoute(RouteSettings settings) {
    // switch (settings.name) {
    //   case "Home":
    //     return MaterialPageRoute(builder: (context) => Container(color: Colors.transparent,child: Home()));
    //     case "Booking":
    //     return MaterialPageRoute(builder: (context) => Container(color: Colors.transparent,child: Booking()));
    //   case "Profile":
    //     return MaterialPageRoute(builder: (context) => Container(color: Colors.transparent,child: Profile()));
    //   case "More":
    //     return MaterialPageRoute(builder: (context) => Container(color: Colors.transparent,child: More()));
    //   default:
    //     return MaterialPageRoute(builder: (context) => Container(color: Colors.transparent,child: Home()));
    // }
  }

  void callBadgeApi() async {
    //TODO : call Api Here

    var getBadge = GetBedgeRequest();
    // getBadge.eventId = 5;

    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return Dialog(
    //       backgroundColor: Colors.transparent,
    //       child: _centerLoading(),
    //     );
    //   },
    // );

    var response = await ApiProvider().callBadgeDataApi(getBadge);

    // Navigator.pop(context); //pop dialog

    new Future.delayed(new Duration(seconds: 1), () {
      // print(response);
      if (response.status == true) {
        alertCount = response.alert.toString();
        discoverCount = response.discover.toString();
        socialCount = response.social;
        if (mounted) {
          setState(() {});
        }
      } else {
        SmartUtils.showErrorDialog(context, response.message);
      }
    });
  }

  // Widget _centerLoading() {
  //   return Container(
  //     color: Colors.transparent,
  //     child: Stack(
  //       children: <Widget>[
  //         new Center(
  //           child: new CircularProgressIndicator(
  //             valueColor:
  //                 new AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
