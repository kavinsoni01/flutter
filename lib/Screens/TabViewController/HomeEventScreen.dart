import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:intl/intl.dart';
import 'package:simposi/Screens/MapViewScreen.dart';
import 'package:simposi/Screens/ProfileScreen/ProfileScreen.dart';
import 'package:simposi/Screens/TabViewController/EventDetailScreen.dart';
import 'package:simposi/Screens/TabViewController/GroupFinderChat.dart';
import 'package:simposi/Screens/TabViewController/InvitationDetailScreen/InvitationDetailScreen.dart';
import 'package:simposi/Screens/CreateEventScreens/MeetNowViewScreen.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/colors.dart';
import 'package:simposi/Utils/Utility/gradients.dart';
// import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:simposi/Utils/smartutils.dart';

class HomeEvent extends StatefulWidget {
  @override
  _HomeEventState createState() => _HomeEventState();
}

class _HomeEventState extends State<HomeEvent> {
  String monthName = "";
  String lastName = "";

  var isPush = false;
  EventListResponse _dashboardEventList;
  CalendarStrip calendarStrip;
  // DateTime startDate = DateTime.now().subtract(Duration(days: 10));
  // DateTime endDate = DateTime.now().add(Duration(days: 10));
  DateTime selectedDate = DateTime.now(); //.subtract(Duration(days: 10));

  List<DateTime> markedDates = [];
  // [
  //      DateTime.now().subtract(Duration(days: 1)),
  //      DateTime.now().subtract(Duration(days: 2)),
  //      DateTime.now().subtract(Duration(days: 3)),
  //      DateTime.now().subtract(Duration(days: 4)),
  //      DateTime.now().subtract(Duration(days: 5)),
  //      DateTime.now().subtract(Duration(days: 6)),
  //      DateTime.now().add(Duration(days: 1)),
  //      DateTime.now().add(Duration(days: 2)),
  //      DateTime.now().add(Duration(days: 3)),
  //      DateTime.now().add(Duration(days: 4)),
  //      DateTime.now().add(Duration(days: 5)),
  //      DateTime.now().add(Duration(days: 6)),
  //      DateTime.now(),
  // ];

  onSelect(data) {
    print("Selected Date -> $data");
    var now = data;
    var formatter = new DateFormat('MMM');
    this.monthName = formatter.format(now);
    selectedDate = data;

    new Future.delayed(new Duration(seconds: 2), () {
      callFindWeekEventApi();
    });

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isPush = false;
    var now = new DateTime.now();
    var formatter = new DateFormat('MMM');
    this.monthName = formatter.format(now);

    if (mounted) {
      setState(() {});
    }
    new Future.delayed(new Duration(seconds: 2), () {
      callFindWeekEventApi();
    });
  }

  _monthNameWidget(monthName) {
    return Container(
      child: Text(monthName,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.transparent,
              fontFamily: 'Muli')),
      padding: EdgeInsets.only(top: 0, bottom: 0),
    );
  }

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1, top: 0, bottom: 0),
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      ),
    ]);
  }

  getMarkedTransperentIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1, top: 0, bottom: 0),
        width: 7,
        height: 7,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
      ),
    ]);
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.white : Colors.white;
    TextStyle normalStyle = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: fontColor,
        fontFamily: 'Muli');
    TextStyle selectedStyle = TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Colors.white,
        fontFamily: 'Muli');
    TextStyle dayNameStyle =
        TextStyle(fontSize: 13.5, color: fontColor, fontFamily: 'Muli');
    List<Widget> _children = [
      Opacity(
        opacity: 0.50067,
        child: Text(dayName, style: dayNameStyle),
      ),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    if (isDateMarked == true) {
      _children.add(getMarkedIndicatorWidget());
    } else {
      // _children.add(getMarkedIndicatorWidget());
      _children.add(getMarkedTransperentIndicatorWidget());
    }

    // print("Selected Date -> $data");
    var now = date;
    var formatter = new DateFormat('MMM');
    // this.lastName = this.monthName;
    // this.monthName = formatter.format(now);
    String newMonth = formatter.format(now);
    if (newMonth != this.monthName) {
      this.monthName = formatter.format(now);
      selectedDate = date;
      changeText();
    } else {}

    // new Future.delayed(new Duration(seconds: 1), () {
    //   callFindWeekEventApi();
    // });

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(top: 15, left: 5, right: 5, bottom: 15),
      decoration: BoxDecoration(
        color: !isSelectedDate
            ? Colors.transparent
            : Colors.lightBlue.withOpacity(0.2),
        borderRadius: BorderRadius.all(Radius.circular(60)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: _children,
      ),
    );
  }

  void changeText() {
    new Future.delayed(new Duration(seconds: 2), () {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);

    return Scaffold(
      extendBodyBehindAppBar: true,

      // backgroundColor: SmartUtils.blueBackground,//Colors.white,//
      body: _MainBody(),
    );
  }

  Widget _MainBody() {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _getAppBarUI(),
            setCalendarView(),
            Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                color: AppColors.secondaryElement,
              ),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 18),
                    child: Text(
                      "Upcoming",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Color.fromARGB(255, 187, 187, 187),
                        fontFamily: "Muli",
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    width: 18,
                    height: 18,
                    margin: EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 1, 126),
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            "0",
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
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  297,
              //  child: setEmptyView(),
              child: isPush == false ? setEventData() : null,
            )
          ],
        ),
      ),
    ); //
  }

  Widget buildRow(
    int index,
  ) {
    return _dashboardEventList.eventList[index].is_my_event == true
        ? Container(
            child: eventView(index),
            margin: index == 0
                ? EdgeInsets.only(bottom: 10, top: 10)
                : EdgeInsets.only(bottom: 10, top: 0))
        : invitationView(index);
  }

  Widget setEventScreenData() {
    return new MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            297,
        color: AppColors.lightGrayBackground,
        child: ListView.builder(
            itemCount: _dashboardEventList.eventList.length,
            itemBuilder: (BuildContext ctxt, int index) {
              return new InkWell(
                  child: buildRow(index),
                  onTap: () async {
                    // selectedCard = index;
                    isPush = true;
                    if (_dashboardEventList.eventList[index].is_my_event ==
                        false) {
                      //(index == 0){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InvitationDetailScreen(
                                    event: _dashboardEventList.eventList[index],
                                  )));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventDetailScreens(
                                    event: _dashboardEventList.eventList[index],
                                  )));
                    }
                  });
            }),
/*
                  child: ListView(
                    children: [

                      
                    Container(
                    child: GestureDetector(
                      child:invitationView(),
                      onTap: () => {
                             Navigator.push(context, MaterialPageRoute(builder: (context) => InvitationDetailScreen())),
                      },
                    ),
                   
                    ),  
                    SizedBox(height:00),
                    Container(
                      height: 173,
                       child:eventView()
                    )
                    ],
                  ),*/
      ),
    );
  }

  Widget setEmptyView() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top -
          260,
      color: SmartUtils.homeBackgroundGray,
      child: Center(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 200,
            height: 244,
            margin: EdgeInsets.only(top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 181,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 80,
                          height: 84,
                          margin: EdgeInsets.only(top: 1),
                          child: Image.asset(
                            "assets/calendar-2.png",
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 20, top: 35),
                          child: Text(
                            "Hmm.. No plans?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w800,
                              fontSize: 19,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        "Meet new people by inviting \nthem to join you",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.accentText,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
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
                        borderRadius: BorderRadius.all(Radius.circular(20)),
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
                          checkFreeEvent(),
                          //

                          // Navigator.push(context, MaterialPageRoute(builder: (context) => MeetNowViewScreen())),
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
//             child: Column(
//                 children: <Widget>[

//               Expanded(// mo plan ?
//               flex: 6,
//               child:Text('', style: TextStyle(color:Colors.black,fontSize:20,fontWeight: FontWeight.bold),)
//               ),

//               Expanded(
//               flex: 3,
//                child:new Image.asset("assets/calendar2@3x.png",height: 60 , width: 60,),
//               ),

//               Expanded(// no plan ?
//               flex: 1,
//               child:Text('Hmm..No Plans?', style: TextStyle(color:Colors.black,fontSize:20,fontWeight: FontWeight.bold),)
//               ),
// //expn
//               Expanded(
//               flex: 1,
//               child:Text('Meet new people by inviting them to join you.', style: TextStyle(color:Colors.grey,fontSize:16,fontWeight: FontWeight.normal),)
//               ),

//               Expanded(
//               flex: 6,
//               child:Text('Meet Now', style: TextStyle(color:SmartUtils.blueBackground,fontSize:20,fontWeight: FontWeight.normal),)
//               ),
//                 ],
//              ),
      ),
    );
  }

  void onMeetNowPressed(BuildContext context) {
    isPush = true;

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MeetNowViewScreen())); //MapView()));//
  }

  Widget setCalendarView() {
    calendarStrip = CalendarStrip(
      //
      addSwipeGesture: true,

      // startDate: startDate,
      // endDate: endDate,
      onDateSelected: onSelect,
      dateTileBuilder: dateTileBuilder,
      iconColor: Colors.transparent,
      monthNameWidget: _monthNameWidget,
      containerDecoration: BoxDecoration(color: SmartUtils.blueBackground),
      markedDates: markedDates,
    );

    // setState(() {});
    return Container(height: 105, child: calendarStrip);
  }

  Widget invitationView(int index) {
    return Container(
      // decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16)),
      // ),
      margin: EdgeInsets.only(top: 16, right: 0, left: 0, bottom: 16),
      child: Container(
        height: 172,
        child: Stack(
          children: <Widget>[
            Container(
              //      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6)),
              //      color: Colors.transparent
              // ),
              margin: EdgeInsets.only(top: 0, right: 0, left: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.asset('assets/paper-3.png',
                    height: 172,
                    width: MediaQuery.of(context).size.width - 32,
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  color: Colors.transparent),
              margin: EdgeInsets.only(left: 16, top: 0),
              child: Opacity(
                opacity: 0.7,
                child: Container(
                  width: MediaQuery.of(context).size.width - 32,
                  height: 172,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: AppColors.primaryBackground,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 20, top: 94),
                          child: Text(
                            "You’re invited!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "DM Serif Text",
                              fontWeight: FontWeight.w400,
                              // style: FontStyle.italic,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 21, top: 8, right: 188),
                        child: Text(
                          "Product Presentation",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: AppColors.primaryText,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 14,
                        margin:
                            EdgeInsets.only(left: 21, right: 207, bottom: 17),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              child: Image.asset(
                                "assets/time@3x.png",
                                // fit: BoxFit.none,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(left: 6),
                                child: Text(
                                  _dashboardEventList
                                      .eventList[index].event_date,
                                  // "August 7, 12:00 PM",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: AppColors.primaryText,
                                    fontFamily: "Muli",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 11,
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
            ),
          ],
        ),
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
                    future: this.callEventListApi(),
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

  Widget eventView(int index) {
    //

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        //  color: Colors.red
      ),
      height: 173,
      padding: EdgeInsets.only(
        right: 16,
        left: 16,
      ),
      // child:GestureDetector(

      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              //  color: Colors.red
            ),
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child:
                    _dashboardEventList.eventList[index].imagesModel.length > 0
                        ? Image.network(
                            _dashboardEventList
                                .eventList[index].imagesModel[0].image,
                            height: 173,
                            width: MediaQuery.of(context).size.width - 32,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/rectangle-3.png',
                            height: 173,
                            width: MediaQuery.of(context).size.width - 32,
                            fit: BoxFit.fill,
                          ),
              ),
              //  child: Image.network(
              //        _dashboardEventList.eventList[index].imagesModel[0].image,
              //        height: 173,width:MediaQuery.of(context).size.width-32 ,fit: BoxFit.fill,
              //     )
              //Image.asset('assets/rectangle-3.png',height: 173,width:MediaQuery.of(context).size.width-32 ,fit: BoxFit.fill,),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, top: 75),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _dashboardEventList
                      .eventList[index].title, //"Ditch Fashion Show",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Text(
                      _dashboardEventList.eventList[index].whoIsGointToString,
                      // "1 Men, 2 Women, 2 LGBTQ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: AppColors.secondaryText,
                        fontFamily: "Muli",
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 14,
                  margin: EdgeInsets.only(left: 1, bottom: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: 10,
                          height: 10,
                          margin: EdgeInsets.only(bottom: 3),
                          child: Image.asset(
                            "assets/time-2.png",
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Text(
                            // "August 7, 2:30 PM",

                            _dashboardEventList.eventList[index].event_date,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 60,
                  height: 14,
                  margin: EdgeInsets.only(left: 1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: 9,
                          height: 11,
                          margin: EdgeInsets.only(bottom: 3),
                          child: Image.asset(
                            "assets/location-2.png",
                            fit: BoxFit.none,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 6),
                          child: Text(
                            _dashboardEventList
                                    .eventList[index].location.isEmpty
                                ? 'N/A'
                                : _dashboardEventList.eventList[index].location,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            style: TextStyle(
                              color: AppColors.secondaryText,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15)
              ],
            ),
          ),
        ],
      ),
      // onTap: () => {

      // alldata.profession[index].isSelected = !alldata.profession[index].isSelected,
      //  setState(() {

      // }),
      // },
      // ),
    );
  }

  Widget _getAppBarUI() {
    return Container(
      // margin: EdgeInsets.only(top:MediaQuery.of(context).padding.top),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 padding: EdgeInsets.all(10),
      // height: 70,
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
                  width: 200,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Text(
                          "Socials",
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
                          this.monthName,
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
                Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
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
                      onTap: () => {
                        checkFreeEvent(),
                      },
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  callEventListApi() async {
    //TODO : CALL Register Api Here
    if (isPush == true) {
    } else {
      EventListRequest request;
      request = EventListRequest();
      request.searchKeyWord = '';
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      request.eventDate = formattedDate;

      request.languageId = 1;
      request.isMyEvents = '';

      EventListResponse responseBusiness =
          await ApiProvider().callEvenntListApi(params: request);

      print(responseBusiness);
      if (responseBusiness.status == true) {
      } else {
        // SmartUtils.showErrorDialog(context, responseBusiness.message);
      }

      return responseBusiness;
    }
  }

  callFindWeekEventApi() async {
    //TODO : CALL Register Api Here
    if (isPush == true) {
    } else {
      WeekEventRequest request;
      request = WeekEventRequest();
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      request.eventDate = formattedDate;

      WeekEventResponse responseBusiness =
          await ApiProvider().callEventWeekListApi(params: request);

      print(responseBusiness);
      if (responseBusiness.status == true) {
        responseBusiness.dateTime.forEach((element) {
          // String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
          var newDateTimeObj2 =
              new DateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(element.date);
          markedDates.add(newDateTimeObj2);
        });
        if (mounted) {
          setState(() {});
        }
        // DateTime.now();

      } else {
        // SmartUtils.showErrorDialog(context, responseBusiness.message);
      }

      return responseBusiness;
    }
  }

  checkFreeEvent() async {
    //TODO : CALL Register Api Here
    if (isPush == true) {
    } else {
      FreeEventRequest request;
      request = FreeEventRequest();
      request.language_id = "1";

      FreeEventResponse responseBusiness =
          await ApiProvider().callFreeEventCheckApi(params: request);

      print(responseBusiness);
      if (responseBusiness.status == true) {
        if (responseBusiness.isAllow == 0) {
          isPush = true;
          pushMeetNowScreen();
        } else {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => ProfileScreen()));
        }

        // if (mounted) {
        //   setState(() {});
        // }
        // DateTime.now();

      } else {
        SmartUtils.showErrorDialog(context, responseBusiness.message);
      }

      return responseBusiness;
    }
  }

  pushMeetNowScreen() async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => MeetNowViewScreen()));
    if (mounted) {
      setState(() {
        isPush = false;
        print(result);
      });
    }
  }
}
