import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simposi/Screens/TabViewController/EventDetailScreen.dart';
import 'package:simposi/Screens/TabViewController/mainTabView.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Utility/ModelClass.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'dart:ui';
import 'dart:async';

class GroupFinderChat extends StatefulWidget {
  final EventList event;
  GroupFinderChat({
    @required this.event,
  });

  @override
  _GroupFinderChatState createState() =>
      _GroupFinderChatState(event: this.event);
}

class _GroupFinderChatState extends State<GroupFinderChat> {
  Timer _timer;
  int _start = 3600;
  final EventList event;

  // var countTimer = 0;
  bool _hasPermissions = false;
  double _lastRead = 0;
  DateTime _lastReadAt;
  TextEditingController txtSearch;
  String messageKeyword = '';
  ChatListResponse _dashboardEventList;
  SharedPreferences preferences;

//

  bool isChatSelected = false;
  List<UserModel> chatUsers = []; //['Peter', 'James', 'Tom']; //'John',
  // List<String> selectedImages = [
  //   ""
  // "assets/oval-copy.png",
  // 'assets/oval-copy.png',
  // 'assets/bramdejager-600x600.png',
  // 'assets/free-profile-photo-whatsapp-4.png'
  // ];

  var selectedIndex = 0;
  _GroupFinderChatState({
    @required this.event,
  });

  @override
  void initState() {
    super.initState();
    _init();
    startTimer();

    _fetchPermissionStatus();
  }

  void _init() async {
    preferences = await SharedPreferences.getInstance();
    preferences.setInt("isEventGoing", 1);
    preferences.setInt("event_id", event.event_id);
    String startTime = preferences.getString('startTime');

    if (startTime != null) {
      DateTime tempDate =
          new DateFormat("yyyy-MM-dd hh:mm:ss").parse(startTime);

      final date2 = DateTime.now();
      final difference = date2.difference(tempDate).inMinutes;
      if (difference < 60) {
        _start = (60 - difference) * 60;
        //  Navigator.push(
        // context, MaterialPageRoute(builder: (context) => MainTabView()));
      }
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 60);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            preferences.setInt("isEventGoing", 0);
            //  String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
            //  preferences.setString("startTime", date);

            timer.cancel();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => MainTabView()),
                (Route<dynamic> route) => false);
          } else {
            _start = _start - 60;
            //  String date = DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
            //  preferences.setString("startTime", date);

          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  final TextEditingController _chatController = new TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  void _handleSubmit(String text) {
    _chatController.clear();
    callSendMessageApi(text);

    // ChatMessage message = new ChatMessage(
    //     // text: text
    //     );
    setState(() {
      // _messages.insert(0, message);
    });
  }

  Widget _getAppBarUI() {
    return Container(
      height: 60,
      margin: EdgeInsets.only(left: 15, top: 46, right: 16),
      width: MediaQuery.of(context).size.width,
      // color: SmartUtils.homeBackgroundGray,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50,
            // margin: EdgeInsets.only(left: 15, top: 47, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 260,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Text(
                          "Group Finder",
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
                          findReminingTime(),
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
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventDetailScreens(
                                  event: event,
                                ))),
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Event Info",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color.fromARGB(255, 25, 39, 240),
                        fontFamily: "Muli",
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chatEnvironment() {
    return IconTheme(
      data: new IconThemeData(color: Colors.blue),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: Container(
                height: 40,
                child: new TextField(
                    decoration: new InputDecoration.collapsed(
                        hintText: "chat as " + event.user_name),
                    controller: _chatController,
                    onSubmitted: _handleSubmit //_handleSubmit,
                    ),
              ),
            ),
            new Container(
              // margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: GestureDetector(
                onTap: () => {
                  _handleSubmit(_chatController.text),
                },
                child: Image.asset(
                  "assets/send.png",
                  height: 40,
                  fit: BoxFit.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          children: [
            _getAppBarUI(),
            Container(
              height: MediaQuery.of(context).size.height - 120,
              child: SingleChildScrollView(
                child: Container(
                  height: 799,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Container(
                      //   height: 381,
                      //   child: Stack(
                      //     children: [
                      //       Container(
                      //         child: Image.asset(
                      //           "assets/compassBackground@3x.png",
                      //           fit: BoxFit.cover,
                      //         ),
                      //       ),
                      Container(
                        height: 381,
                        color: Color.fromARGB(255, 45, 46, 48),
                        margin: EdgeInsets.only(top: 15),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              height: 281,
                              child: Builder(builder: (context) {
                                if (_hasPermissions) {
                                  return Column(
                                    children: <Widget>[
                                      // _buildManualReader(),
                                      Expanded(child: _buildCompass()),
                                    ],
                                  );
                                } else {
                                  PermissionHandler().requestPermissions([
                                    PermissionGroup.locationWhenInUse
                                  ]).then((ignored) {
                                    _fetchPermissionStatus();
                                  });
                                  return Container(
                                    height: 341,
                                    child: Image.asset(
                                      "assets/compassBackground@3x.png",
                                      fit: BoxFit.fill,
                                    ),
                                  );
                                }
                              }),
                            ),

                            isChatSelected == false
                                ? Container(
                                    margin: EdgeInsets.only(top: 341, left: 1),
                                    // left: 1,
                                    // top: 341,
                                    // right: 0,
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 243, 243, 243),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 16),
                                            child: Text(
                                              "0 out of 0 arrived",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.accentText,
                                                fontFamily: "Muli",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () => {
                                              isChatSelected = true,
                                              if (mounted)
                                                {
                                                  setState(() {}),
                                                }
                                            },
                                            child: Container(
                                              width: 19,
                                              height: 18,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Image.asset(
                                                "assets/chat.png",
                                                fit: BoxFit.none,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(
                                    margin: EdgeInsets.only(top: 341, left: 1),
                                    // left: 1,
                                    // top: 341,
                                    // right: 0,
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 243, 243, 243),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(left: 16),
                                            child: Text(
                                              "Group Chat",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.accentText,
                                                fontFamily: "Muli",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: () => {
                                              isChatSelected = false,
                                              if (mounted)
                                                {
                                                  setState(() {}),
                                                }
                                            },
                                            child: Container(
                                              width: 22,
                                              height: 22,
                                              margin:
                                                  EdgeInsets.only(right: 16),
                                              child: Image.asset(
                                                "assets/profile-view.png",
                                                fit: BoxFit.none,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      isChatSelected == false
                          ? Container(
                              height: 381,
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                        width: 150,
                                        // MediaQuery.of(context).size.width -
                                        //  100, //117,
                                        height: 50,
                                        margin: EdgeInsets.only(top: 15),
                                        child: GridView.builder(
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 1),
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder: (_, index) => InkWell(
                                                child: buildRowImage(index),
                                                onTap: () async {
                                                  selectedIndex = index;
                                                  setState(() {});
                                                }),
                                            // buildRowImage(index),
                                            itemCount: chatUsers.length)
                                        //   child: Image.asset(
                                        //     "assets/arrived.png",
                                        //     fit: BoxFit.none,
                                        //   ),
                                        ),
                                  ),
                                  Spacer(),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      width: 152,
                                      height: 183,
                                      margin: EdgeInsets.only(bottom: 40),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Container(
                                            height: 155,
                                            child: CircleAvatar(
                                                // child: Image.asset(
                                                // "assets/oval-copy.png",
                                                // selectedImages[selectedIndex],
                                                //  fit: BoxFit.none,
                                                // ),
                                                ),
                                          ),
                                          Spacer(),
                                          Align(
                                            alignment: Alignment.topCenter,
                                            child: Text(
                                              // "Peter",
                                              chatUsers[selectedIndex].userName,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: AppColors.primaryText,
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
                                ],
                              ),
                            )
                          : Container(
                              height: 371,
                              child: Column(
                                children: [
                                  Container(
                                    height: 311,
                                    child: FutureBuilder(
                                        future: this.callAllChatMessageApi(),
                                        builder: (context, data) {
                                          switch (data.connectionState) {
                                            case ConnectionState.none:
                                            case ConnectionState.waiting:
                                            case ConnectionState.active:
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor: Colors.pink,
                                                ),
                                              );
                                            case ConnectionState.done:
                                              if (data.hasError) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    backgroundColor:
                                                        Colors.pink,
                                                  ),
                                                );
                                              } else {
                                                _dashboardEventList = data.data;
                                                if (data.hasData) {
                                                  return _dashboardEventList
                                                          .status // ? setEmptyView()
                                                      ? setChatView()
                                                      : Container();
                                                } else {
                                                  return Container();
                                                }
                                              }
                                          }
                                        }),
                                  ),
                                  Spacer(),
                                  _chatEnvironment(),
                                  // Container(
                                  //   height: 50,
                                  //   child: Text(
                                  //     "Chat as kavin soni",
                                  //     textAlign: TextAlign.left,
                                  //     style: TextStyle(
                                  //       color:
                                  //           Color.fromARGB(255, 187, 187, 187),
                                  //       fontFamily: "Muli",
                                  //       fontWeight: FontWeight.w700,
                                  //       fontSize: 13,
                                  //     ),
                                  //   ),
                                  // ),
                                  //     new MediaQuery.removePadding(
                                  //       context: context,
                                  //       removeTop: true,
                                  //       child: new Container(
                                  //         child: Container(
                                  //             height:
                                  //                 281, //MediaQuery.of(context).size.height-270 - 119, alldata.generationIdentify.length.toDouble() * 62
                                  //             child: new ListView.builder(
                                  //                 itemCount: 5,
                                  //                 itemBuilder:
                                  //                     (BuildContext ctxt, int index) {
                                  //                   return Container(
                                  //                       margin: EdgeInsets.only(
                                  //                           top: 0,
                                  //                           bottom: 0,
                                  //                           right: 20,
                                  //                           left: 20),
                                  //                       height: 62,
                                  //                       child: buildRow(index));
                                  //                 })),
                                  //       ),
                                  //     ),
                                  //     Container(
                                  //       height: 60,
                                  //       decoration: BoxDecoration(
                                  //         color: AppColors.secondaryElement,
                                  //         boxShadow: [
                                  //           BoxShadow(
                                  //             color: Color.fromARGB(13, 0, 0, 0),
                                  //             offset: Offset(0, -2),
                                  //             blurRadius: 2,
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       child: Row(
                                  //         children: [
                                  //           Container(
                                  //             width: 27,
                                  //             height: 27,
                                  //             margin: EdgeInsets.only(left: 16),
                                  //             child: Image.asset(
                                  //               "assets/oval-copy-6.png",
                                  //               fit: BoxFit.none,
                                  //             ),
                                  //           ),
                                  //           Container(
                                  //             margin: EdgeInsets.only(left: 7),
                                  //             child: TextFormField(
                                  //               controller: txtSearch,
                                  //               keyboardType: TextInputType.text,
                                  //               textInputAction:
                                  //                   TextInputAction.search,
                                  //               style: TextStyle(fontSize: 16),
                                  //               decoration: InputDecoration(
                                  //                 hintText: 'Search',
                                  //                 border: InputBorder.none,
                                  //                 hintStyle:
                                  //                     TextStyle(color: Colors.grey),
                                  //               ),
                                  //               validator: (String email) {
                                  //                 return null;
                                  //               },
                                  //               onChanged: (String value) {
                                  //                 // searchShouldCall = true;
                                  //                 messageKeyword = value.trim();
                                  //               },
                                  //             ),
                                  //             // Text(
                                  //             //   "Chat as Pauline…",
                                  //             //   textAlign: TextAlign.left,
                                  //             //   style: TextStyle(
                                  //             //     color: Color.fromARGB(
                                  //             //         255, 187, 187, 187),
                                  //             //     fontFamily: "Muli",
                                  //             //     fontWeight: FontWeight.w700,
                                  //             //     fontSize: 13,
                                  //             //   ),
                                  //             // ),
                                  //           ),
                                  //           Spacer(),
                                  //           Container(
                                  //             width: 24,
                                  //             height: 24,
                                  //             margin: EdgeInsets.only(right: 16),
                                  //             child: Image.asset(
                                  //               "assets/send.png",
                                  //               fit: BoxFit.none,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ),
                                ],
                              )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget setChatView() {
    return Container(
        // color: Colors.red,
        height: 311,
        child: Column(
          children: [
            new MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: new Container(
                  height:
                      311, //MediaQuery.of(context).size.height-270 - 119, alldata.generationIdentify.length.toDouble() * 62
                  child: new ListView.builder(
                      itemCount: _dashboardEventList.chatList.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return Container(
                            margin: EdgeInsets.only(
                                top: 0, bottom: 0, right: 20, left: 20),
                            height: 62,
                            child: buildRow(index));
                      })),
            ),
            // Container(
            //   height: 60,
            //   decoration: BoxDecoration(
            //     color: AppColors.secondaryElement,
            //     boxShadow: [
            //       BoxShadow(
            //         color: Color.fromARGB(13, 0, 0, 0),
            //         offset: Offset(0, -2),
            //         blurRadius: 2,
            //       ),
            //     ],
            //   ),
            //   child: Row(
            //     children: [
            //       Container(
            //         width: 27,
            //         height: 27,
            //         margin: EdgeInsets.only(left: 16),
            //         child: Image.asset(
            //           "assets/oval-copy-6.png",
            //           fit: BoxFit.none,
            //         ),
            //       ),
            //       Container(
            //         margin: EdgeInsets.only(left: 7),
            //         child: TextFormField(
            //           controller: txtSearch,
            //           keyboardType: TextInputType.text,
            //           textInputAction: TextInputAction.search,
            //           style: TextStyle(fontSize: 16),
            //           decoration: InputDecoration(
            //             hintText: "chat as " + event.user_name,
            //             border: InputBorder.none,
            //             hintStyle: TextStyle(color: Colors.grey),
            //           ),
            //           validator: (String email) {
            //             return null;
            //           },
            //           onChanged: (String value) {
            //             // searchShouldCall = true;
            //             messageKeyword = value.trim();
            //           },
            //         ),
            //         // Text(
            //         //   "Chat as Pauline…",
            //         //   textAlign: TextAlign.left,
            //         //   style: TextStyle(
            //         //     color: Color.fromARGB(
            //         //         255, 187, 187, 187),
            //         //     fontFamily: "Muli",
            //         //     fontWeight: FontWeight.w700,
            //         //     fontSize: 13,
            //         //   ),
            //         // ),
            //       ),
            // Spacer(),
            // Container(
            //   width: 24,
            //   height: 24,
            //   margin: EdgeInsets.only(right: 16),
            //   child: Image.asset(
            //     "assets/send.png",
            //     fit: BoxFit.none,
            //   ),
            // ),
            //     ],
            //   ),
            // ),
          ],
        ));
  }

  Widget buildRow(
    int index,
  ) {
    return Container(
      height: 30,
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          width: 278,
          height: 27,
          margin: EdgeInsets.only(left: 16, top: 10),
          child: Row(
            children: [
              Container(
                  width: 28,
                  height: 28,
                  child: CircleAvatar(
                    child: Image.network(
                      _dashboardEventList.chatList[index].sender_profile_image,
                      height: 28,
                      width: 28,
                      fit: BoxFit.cover,
                    ),
                  )
                  // Image.asset(
                  //   "assets/oval-copy-8-2.png",
                  //   fit: BoxFit.none,
                  // ),
                  ),
              Container(
                margin: EdgeInsets.only(left: 7),
                child: Text(
                  "5:09 PM",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color.fromARGB(255, 187, 187, 187),
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 4),
                child: Text(
                  _dashboardEventList.chatList[index].sender_name,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.accentText,
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              // Spacer(),
              Text(
                _dashboardEventList.chatList[index].message,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: AppColors.primaryText,
                  fontFamily: "Muli",
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionSheet() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Location Permission Required'),
          RaisedButton(
            child: Text('Request Permissions'),
            onPressed: () {
              PermissionHandler().requestPermissions(
                  [PermissionGroup.locationWhenInUse]).then((ignored) {
                _fetchPermissionStatus();
              });
            },
          ),
          SizedBox(height: 16),
          RaisedButton(
            child: Text('Open App Settings'),
            onPressed: () {
              PermissionHandler().openAppSettings().then((opened) {
                //
              });
            },
          )
        ],
      ),
    );
  }

  Widget _buildCompass() {
    return StreamBuilder<double>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error reading heading: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        double direction = snapshot.data;

        // if direction is null, then device does not support this sensor
        // show error message
        if (direction == null)
          return Center(
            child: Text("Device does not have sensors !"),
          );

        return Container(
          alignment: Alignment.center,
          child: Transform.rotate(
            angle: ((direction ?? 0) * (math.pi / 180) * -1),
            child: Image.asset('assets/compassBackground@3x.png'),
          ),
        );
      },
    );
  }

  void _fetchPermissionStatus() {
    PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationWhenInUse)
        .then((status) {
      if (mounted) {
        setState(() => _hasPermissions = status == PermissionStatus.granted);
      }
    });
  }

  String findReminingTime() {
    double newValue = _start / 60;

    int valueString = int.parse(newValue.toStringAsFixed(0));
    return "This session will expire in 00:" + valueString.toString() + " m";
  }
  // Widget _buildManualReader() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Row(
  //       children: <Widget>[
  //         RaisedButton(
  //           child: Text('Read Value'),
  //           onPressed: () async {
  //             final double tmp = await FlutterCompass.events.first;
  //             setState(() {
  //               _lastRead = tmp;
  //               _lastReadAt = DateTime.now();
  //             });
  //           },
  //         ),
  //         Expanded(
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.end,
  //             children: <Widget>[
  //               Text(
  //                 '$_lastRead',
  //                 style: Theme.of(context).textTheme.caption,
  //               ),
  //               Text(
  //                 '$_lastReadAt',
  //                 style: Theme.of(context).textTheme.caption,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  callAllChatMessageApi() async {
    //TODO : CALL Register Api Here
    ChatListRequest request;
    request = ChatListRequest();
    request.languageId = 1;
    request.event_id = event.event_id.toString();

    ChatListResponse responseBusiness =
        await ApiProvider().callChatListApi(params: request);

    print(responseBusiness);
    if (responseBusiness.status == true) {
    } else {
      // SmartUtils.showErrorDialog(context, responseBusiness.message);
    }

    return responseBusiness;
  }

  callSendMessageApi(String text) async {
    //TODO : CALL Register Api Here
    SendMessageRequest request;
    request = SendMessageRequest();
    request.languageId = 1;
    request.event_id = event.event_id.toString();
    request.sender_id = "9";
    request.receiver_id = "14";
    request.message = text;
    SendChatResponse responseBusiness =
        await ApiProvider().callSendMessageApi(params: request);

    print(responseBusiness);
    if (responseBusiness.status == true) {
    } else {
      // SmartUtils.showErrorDialog(context, responseBusiness.message);
    }

    return responseBusiness;
  }

  Widget buildRowImage(
    int index,
  ) {
    return Container(
      margin: EdgeInsets.only(left: 5),
      width: 35,
      height: 35,
      child: Image.asset(chatUsers[index].profilePhoto,
          width: 35, height: 35, fit: BoxFit.fill),
    );
  }

  // Function to be called on click
  void _onTileClicked(int index) {
    debugPrint("You tapped on item $index");
  }
}
