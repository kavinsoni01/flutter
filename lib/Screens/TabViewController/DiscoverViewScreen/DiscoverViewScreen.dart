import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simposi/Screens/CreateEventScreens/MeetNowViewScreen.dart';
import 'package:simposi/Screens/ProfileScreen/ProfileScreen.dart';
import 'package:simposi/Screens/TabViewController/DiscoverViewScreen/DiscoverDetails.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/Utility/Values/gradients.dart';
import 'package:simposi/Utils/Utility/pink_button.dart';
import 'package:simposi/Utils/Utility/youre_going_badge.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:simposi/Utils/smartutils.dart';

class DiscoverViewScreen extends StatefulWidget {
  @override
  _DiscoverViewScreenState createState() => _DiscoverViewScreenState();
}

class _DiscoverViewScreenState extends State<DiscoverViewScreen> {
  CardController controller; //Use this to trigger swap.

  DiscoverEventListResponse _dashboardEventList;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          // margin: EdgeInsets.only(top:MediaQuery.of(context).padding.top),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 padding: EdgeInsets.all(10),
          // height: 70,

          child: setEventData() //setEmptyView(),//

          ),
    );
  }

  Widget setEventScreenData() {
    return Container(
      height: 667,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 46,
            margin: EdgeInsets.only(left: 15, top: 46, right: 16),
            // margin: EdgeInsets.only(left: 15, top: 55, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // left: 0,
                  // top: 0,
                  child: Text(
                    "Discover",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => {
                    checkFreeEvent(),
                    // Navigator.push(
                    //     context,
                    // MaterialPageRoute(
                    //     builder: (context) => MeetNowViewScreen())),
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 13),
                    child: Text(
                      "Meet Now",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color.fromARGB(255, 25, 39, 240),
                        fontFamily: "Muli",
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // color: Colors.white,
            child: Container(
              // color: Colors.white,
              height: MediaQuery.of(context).size.height - 179,
              child:

                  // Expanded(
                  // flex: 1,
                  // child:
                  Container(
                // color: Colors.white,
                margin: EdgeInsets.only(top: 0, bottom: 10),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      // left: 0,
                      // top: 0,
                      // right: 0,
                      padding: EdgeInsets.only(top: 0, bottom: 0),
                      child: Container(
                        height: MediaQuery.of(context).size.height - 211, //601,
                        decoration: BoxDecoration(
                          gradient: Gradients.primaryGradient,
                        ),
                        child: setEmptyViewBackground(),
                      ),
                    ),
                    //end container

                    Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20),
                      // decoration: BoxDecoration(
                      // color: Colors.red,
                      // borderRadius: BorderRadius.all(Radius.circular(20)),
                      // boxShadow: [
                      // BoxShadow(color: Colors.grey, spreadRadius: 1),
                      // ],
                      // ),
                      child: TinderSwapCard(
                          // orientation: AmassOrientation.TOP,
                          totalNum: _dashboardEventList.eventList.length,
                          // stackNum: 2,
                          swipeEdge: 0.1,
                          maxWidth: MediaQuery.of(context).size.width, //* 0.9,
                          maxHeight:
                              MediaQuery.of(context).size.height, // * 0.9,
                          minWidth: MediaQuery.of(context).size.width * 0.85,
                          minHeight: MediaQuery.of(context).size.height * 0.80,
                          cardBuilder: (context, index) => Card(
                                shadowColor: Colors.transparent,
                                color: Colors
                                    .transparent, //AppColors.ternaryBackground,//Color.fromARGB(255, 255, 255, 255),
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: Gradients.primaryGradient,
                                  ),
                                  margin: EdgeInsets.all(0),
                                  // left: 16,
                                  // top: 16,
                                  // right: 16,
                                  // bottom: 16,

                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        // margin: EdgeInsets.only(top:20, bottom:20),
                                        height:
                                            MediaQuery.of(context).size.height -
                                                211,
                                        child: ClipRRect(
                                          // decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          // boxShadow: [
                                          // BoxShadow(color: Colors.grey, spreadRadius: 1),
                                          // ],
                                          //),
                                          // padding: EdgeInsets.only(top:20),
                                          // margin: EdgeInsets.only(top:20),
                                          //  height: MediaQuery.of(context).size.height - 211,
                                          // left: -1,
                                          // right: -1,
                                          child: _dashboardEventList
                                                      .eventList[index]
                                                      .imagesModel
                                                      .length >
                                                  0
                                              ? Image.network(
                                                  _dashboardEventList
                                                      .eventList[index]
                                                      .imagesModel[0]
                                                      .image,
                                                  // 'https://homepages.cae.wisc.edu/~ece533/images/tulips.png',
                                                  fit: BoxFit.fitHeight,
                                                  //fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  "assets/rectangle-ease-in-outlrgb15.png",
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              485,
                                        ),
                                        height: 100,
                                        decoration: BoxDecoration(
                                          gradient: Gradients.imageGradient,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              385,
                                        ),
                                        height: 150,
                                        color: Colors.white,
                                        // decoration: BoxDecoration(
                                        // gradient: Gradients.imageGradient,
                                        // ),
                                      ),

                                      // Positioned(
                                      //   height: MediaQuery.of(context).size.height - 300,
                                      //   left: -1,
                                      //   right: -1,
                                      //    child:Image.network(
                                      //      _dashboardEventList.eventList[index].imagesModel[0].image,fit: BoxFit.cover,
                                      //   )
                                      //   // Image.asset(
                                      //   //   "assets/rectangle-ease-in-outlrgb15.png",
                                      //   //   fit: BoxFit.cover,
                                      //   // ),
                                      // ),
                                      Positioned(
                                        left: 20,
                                        top: 14,
                                        right: 14,
                                        bottom: 20,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            GestureDetector(
                                              onTap: () => {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            DiscoverDetails(
                                                              event: _dashboardEventList
                                                                      .eventList[
                                                                  index],
                                                            ))),
                                              },
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  width: 25,
                                                  height: 25,
                                                  child: Image.asset(
                                                    "assets/info.png",
                                                    fit: BoxFit.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            // SizedBox(height:520),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                _dashboardEventList
                                                    .eventList[index].title,
                                                // "Ditch Fashion Show",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: AppColors.primaryText,
                                                  fontFamily: "Muli",
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 21,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 7),
                                                child: Text(
                                                  // "5 Men, 10 Women, 13 LGBTQ",
                                                  _dashboardEventList
                                                      .eventList[index]
                                                      .wantToMeetString,
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    color: AppColors.accentText,
                                                    fontFamily: "Muli",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                // "Cobana Pool Bar",
                                                _dashboardEventList
                                                    .eventList[index].title,
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: AppColors.accentText,
                                                  fontFamily: "Muli",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                _dashboardEventList
                                                        .eventList[index]
                                                        .eventDay +
                                                    ', ' +
                                                    _dashboardEventList
                                                        .eventList[index]
                                                        .eventMonth +
                                                    ' ' +
                                                    _dashboardEventList
                                                        .eventList[index]
                                                        .eventDate +
                                                    ', ' +
                                                    _dashboardEventList
                                                        .eventList[index]
                                                        .eventTime,
                                                // "Thursday, September 19, 6:00 PM",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: AppColors.accentText,
                                                  fontFamily: "Muli",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 11,
                                                ),
                                              ),
                                            ),
                                            MediaQuery.of(context).size.height >
                                                    800
                                                ? SizedBox(height: 40)
                                                : SizedBox(height: 0),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          cardController: controller = CardController(),
                          swipeUpdateCallback:
                              (DragUpdateDetails details, Alignment align) {
                            /// Get swiping card's alignment
                            if (align.x < 0) {
                              //Card is LEFT swiping
                            } else if (align.x > 0) {
                              //Card is RIGHT swiping
                            }
                          },
                          swipeCompleteCallback:
                              (CardSwipeOrientation orientation, int index) {
                            /// Get orientation & index of swiped card!
                          }),
                    ),
                  ],
                ),
              ),
            ),
            //here
            // child: Image.asset('${welcomeImages[index]}'),
            //
          )
          // ),
        ],
      ),
    );
  }

  Widget setEventData() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 8,
          child: Container(
            child: //this. expandableTheme()

                FutureBuilder(
                    future: this.callDiscoverEventList(),
                    builder: (context, data) {
                      switch (data.connectionState) {
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                        case ConnectionState.active:
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.pink,
                            ),
                          );
                        case ConnectionState.done:
                          if (data.hasError) {
                            return Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.pink,
                              ),
                            );
                          } else {
                            _dashboardEventList = data.data;
                            if (data.hasData) {
                              return _dashboardEventList
                                      .status // ? setEmptyView()
                                  ? setEventScreenData()
                                  : setEmptyView();
                            } else {
                              return setEmptyView();
                            }
                          }
                      }
                    }),
          ),
        ),
      ],
    );
  }

  Widget setEmptyView() {
    return Container(
      child: Column(
        children: [
          Container(
            height: 38,
            margin: EdgeInsets.only(left: 15, top: 46, right: 16),

            // margin: EdgeInsets.only(left: 15, top: 55, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  //  left: 0,
                  //  top: 0,
                  child: Text(
                    "Discover",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.w800,
                      fontSize: 30,
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MeetNowViewScreen())),
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 13),
                    child: Text(
                      "Meet Now",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Color.fromARGB(255, 25, 39, 240),
                        fontFamily: "Muli",
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 272,
              height: 263,
              margin: EdgeInsets.only(top: 165),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 84,
                      height: 84,
                      margin: EdgeInsets.only(top: 12),
                      child: Image.asset(
                        "assets/global-events-2-2.png",
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                  Container(
                    height: 145,
                    margin: EdgeInsets.only(top: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "No Events Found",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w800,
                              fontSize: 19,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 1),
                          child: Text(
                            "We don’t have any public events right now. Invite people to meet you \nsomewhere instead",
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
                        Spacer(),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 130,
                            height: 40,
                            margin: EdgeInsets.only(top: 23),
                            child: FlatButton(
                              onPressed: () => this.onMeetNowPressed(context),
                              color: Color.fromARGB(255, 255, 1, 126),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              textColor: Color.fromARGB(255, 255, 255, 255),
                              padding: EdgeInsets.all(0),
                              child: GestureDetector(
                                child: Text(
                                  "Meet Now",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                ),
                                onTap: () => {
                                  // isPush = true,
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MeetNowViewScreen())),
                                },
                              ),
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
        ],
      ),
    );
  }

  Widget setEmptyViewBackground() {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              width: 272,
              height: 263,
              margin: EdgeInsets.only(top: 165),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 84,
                      height: 84,
                      margin: EdgeInsets.only(top: 12),
                      child: Image.asset(
                        "assets/global-events-2-2.png",
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                  Container(
                    height: 145,
                    margin: EdgeInsets.only(top: 22),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "No Events Found",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w800,
                              fontSize: 19,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 1),
                          child: Text(
                            "We don’t have any public events right now. Invite people to meet you \nsomewhere instead",
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
                        Spacer(),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 130,
                            height: 40,
                            margin: EdgeInsets.only(top: 23),
                            child: FlatButton(
                              onPressed: () => this.onMeetNowPressed(context),
                              color: Color.fromARGB(255, 255, 1, 126),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              textColor: Color.fromARGB(255, 255, 255, 255),
                              padding: EdgeInsets.all(0),
                              child: GestureDetector(
                                child: Text(
                                  "Meet Now",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.secondaryText,
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.w800,
                                    fontSize: 15,
                                  ),
                                ),
                                onTap: () => {
                                  // isPush = true,
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MeetNowViewScreen())),
                                },
                              ),
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
        ],
      ),
    );
  }

  callDiscoverEventList() async {
    //TODO : Call Register Api Here

    DiscoverEventListResponse responseBusiness =
        await ApiProvider().callDiscoverEvenntListApi();

    print(responseBusiness);
    if (responseBusiness.status == true) {}

    return responseBusiness;
    // }
  }

  void onMeetNowPressed(BuildContext context) {
    checkFreeEvent();
  }

  checkFreeEvent() async {
    //TODO : CALL Register Api Here

    FreeEventRequest request;
    request = FreeEventRequest();
    request.language_id = "1";

    FreeEventResponse responseBusiness =
        await ApiProvider().callFreeEventCheckApi(params: request);

    print(responseBusiness);
    if (responseBusiness.status == true) {
      if (responseBusiness.isAllow == 0) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MeetNowViewScreen()));
      } else {
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen()));
      }
    } else {
      SmartUtils.showErrorDialog(context, responseBusiness.message);
    }

    return responseBusiness;
  }
}
