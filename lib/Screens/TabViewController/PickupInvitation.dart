import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simposi/Screens/CreateEventScreens/PreviewImageScreen.dart';
import 'package:simposi/Screens/TabViewController/HomeEventScreen.dart';
import 'package:simposi/Screens/TabViewController/mainTabView.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Models/CreateEventModel.dart';
import 'package:simposi/Utils/Utility/ApiClass.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/smartutils.dart';

class PickInvitation extends StatefulWidget {
  final AllDataModel alldata;
  final int eventId;

  PickInvitation({@required this.eventId, this.alldata});

  @override
  _PickInvitationState createState() =>
      _PickInvitationState(eventId: this.eventId, alldata: this.alldata);
}

class _PickInvitationState extends State<PickInvitation> {
  final int eventId;
  final AllDataModel alldata;
  //  AllDataModel originalData;

  _PickInvitationState({@required this.eventId, this.alldata});

  InvitationCardDataResponse _dashboardEventList;
  int selectedCard = -1;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return Scaffold(
      backgroundColor: SmartUtils.blueBackground, //Colors.white,//

      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 4,
              margin: EdgeInsets.only(top: 36),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 25, 39, 240),
              ),
              child: Container(),
            ),
            Container(
              height: 35,
              margin: EdgeInsets.only(top: 13),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 15),
                          Container(
                            width: 9,
                            height: 17,
                            margin: EdgeInsets.only(top: 3),
                            child: Image.asset(
                              "assets/left-arrow.png",
                              fit: BoxFit.none,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "Details",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromARGB(255, 25, 39, 240),
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ]),
                    onTap: () => {
                      Navigator.pop(context),
                    },
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => MainTabView()),
                          (Route<dynamic> route) => false),
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 17),
                      child: Text(
                        "Cancel",
                        textAlign: TextAlign.left,
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
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  "Pick an Invitation",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "Helvetica",
                    fontWeight: FontWeight.w400,
                    fontSize: 19,
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 127,
              margin: EdgeInsets.only(left: 16, top: 15, right: 16),
              child: setData(), // setInvitationCard(),  //
            ),
          ],
        ),
      ),
    );
  }

  callMainDataApiApi() async {
    //TODO : call Api Here

    InvitationCardDataResponse responsePickupInvitation =
        await ApiProvider().callPickupInvitation();

    print(responsePickupInvitation);
    if (responsePickupInvitation.status == true) {
    } else {
      SmartUtils.showErrorDialog(context, responsePickupInvitation.message);
    }

    return responsePickupInvitation;
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

  Widget setData() {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 8,
          child: Container(
            child: //this. expandableTheme()

                FutureBuilder(
                    future: this.callMainDataApiApi(),
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
                                  ? setInvitationCard()
                                  : setEmptyView();
                            } else {
                              return setEmptyView();
                            }
                          }
                      } //  createCategoryList(
                    }),
          ),
        ),
      ],
    );
  }

  setInvitationCard() {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 10, right: 10),
      child: new MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 20,
          childAspectRatio: 0.85,
          children:
              List.generate(_dashboardEventList.invitationList.length, (index) {
            return Center(
              child: new InkWell(
                  child: buildRow(index),
                  onTap: () async {
                    if (selectedCard == index) {
                      selectedCard = -1;
                    } else {
                      selectedCard = index;
                    }
                    setState(() {});
                  }),
              //    Text(
              //   'Item $index',
              //   style: TextStyle(color:Colors.black),//Theme.of(context).textTheme.headline5,
              // ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildRow(
    int index,
  ) {
    return selectedCard != index
        ? Container(
            height: (MediaQuery.of(context).size.width / 2) + 60,
            //  color: Colors.red,
            margin: EdgeInsets.only(left: 5, right: 5),
            child: Container(
              // color: Colors.orange,
              alignment: Alignment.topLeft,
              child: Container(
                width: (MediaQuery.of(context).size.width / 2) - 20,
                height: (MediaQuery.of(context).size.width / 2) + 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.primaryElement, width: 3),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    10.0) //                 <--- border radius here
                                )),
                        // height: MediaQuery.of(context).size.height > 800
                        //     ? (MediaQuery.of(context).size.width / 2) - 20 //165
                        //     : 148,
                        width: (MediaQuery.of(context).size.width / 2) - 20,
                        height: (MediaQuery.of(context).size.width / 2) - 40,
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/group-7.png',
                          image: _dashboardEventList
                              .invitationList[index].backgroundimage,
                          fit: BoxFit.cover,
                        )
                        // Image.network(
                        //    _dashboardEventList.invitationList[index].backgroundimage,
                        // ),
                        // Image.asset(
                        //   "assets/rectangle-10.png",
                        //   fit: BoxFit.cover,
                        // ),
                        ),
                    Spacer(),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "\$" +
                              _dashboardEventList.invitationList[index].price
                                  .toString(), // "\$0.99",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.accentText,
                            fontFamily: "Muli",
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Container(
            height: (MediaQuery.of(context).size.width / 2) + 60,
            //  color: Colors.red,
            margin: EdgeInsets.only(top: 0),
            child: Container(
              alignment: Alignment.topLeft,
              child: Container(
                width: (MediaQuery.of(context).size.width / 2) - 20,
                height: (MediaQuery.of(context).size.width / 2) + 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width / 2) - 20,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 255, 1, 126),
                              width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(
                                  10.0) //                 <--- border radius here
                              )),
                      height: (MediaQuery.of(context).size.width / 2) - 40,

                      // MediaQuery.of(context).size.height > 800 ? 165 : 148,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(
                            _dashboardEventList
                                .invitationList[index].backgroundimage,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 72,
                            child: Container(
                              width: 100,
                              height: 25,
                              decoration: BoxDecoration(
                                color: AppColors.secondaryElement,
                                border: Border.all(
                                  width: 1.5,
                                  color: Color.fromARGB(255, 255, 1, 126),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    child: Container(
                                      height: 22,
                                      child: FlatButton(
                                        onPressed: () {
                                          print('Press Preview button');
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PreviewImageScreens(
                                                          image: _dashboardEventList
                                                              .invitationList[
                                                                  index]
                                                              .backgroundimage)));
                                        },
                                        child: Text(
                                          "PREVIEW",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 1, 126),
                                            fontFamily: "Muli",
                                            fontWeight: FontWeight.w800,
                                            fontSize: 11,
                                          ),
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
                    ),
                    Spacer(),
                    GestureDetector(
                      child: Container(
                        width: (MediaQuery.of(context).size.width / 2) - 50,
                        height: 27,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 25, 39, 240),
                          border: Border.all(
                            width: 1.5,
                            color: Color.fromARGB(255, 25, 39, 240),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Container(
                                height: 24,
                                child: FlatButton(
                                  onPressed: () {
                                    print('Press select button');

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
                                                "Do you want to buy one Invitation for \$" +
                                                    _dashboardEventList
                                                        .invitationList[index]
                                                        .price
                                                        .toString(),
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
                                                    callPurchaseInvitationCardApi(),
                                                  },
                                                  child: Text(
                                                    "Buy",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      // color: Colors.white,//Color.fromARGB(255, 0, 122, 255),
                                                      fontFamily: "Helvetica",
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 17,
                                                      letterSpacing: 0.408,
                                                      height: 1.29412,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ));
                                  },
                                  child: Text(
                                    "SELECT",
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
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  setEmptyView() {
    new Center(
      child: new Text(
        _dashboardEventList.message,
        style: TextStyle(fontSize: 18, fontStyle: FontStyle.normal),
      ),
    );
  }

  callPurchaseInvitationCardApi() async {
    //TODO : CALL Register Api Here

    PickupInvitationCardRequest request;
    request = PickupInvitationCardRequest();
    request.eventId = this.eventId.toString();
    request.inappPurchaseId = 'asdfsdfsd';
    request.periodStart = "2020-06-11";
    request.periodEnd = "2020-09-11";
    request.amount = '50';
    PickupInvitationResponse responseBusiness =
        await ApiProvider().callPickupInvitationApi(params: request);

    print(responseBusiness);
    if (responseBusiness.status == true) {
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: new Text(
                  "You have a Social!",
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
                  "Your invitations are on their way, and fun times are here to stay.",
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
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => MainTabView()),
                          (Route<dynamic> route) => false),
                    },
                    child: Text(
                      "Okay",
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
              ));
    } else {
      // SmartUtils.showErrorDialog(context, responseBusiness.message);
    }

    return responseBusiness;
  }



//  void createEventAPI(CreateEventModel eventModel, AllDataModel allDataModel) async {

//         showDialog(
//               context: context,
//               barrierDismissible: false,
//               builder: (BuildContext context) {
//          return Dialog(
//            backgroundColor: Colors.transparent,
//             child: _centerLoading(),
//       );
//     },
//   );

// // selectImage

//   // File isSelectImage;
//   AppMultiPartFile uploadfile = AppMultiPartFile(localFile: eventModel.selectImage, key: 'Image');

//     //TODO : CALL signup Api Here
//        var request = CreateEventRequest();
//       request.title = eventModel.title;
//       request.date = eventModel.date;//'Female';
//       request.description = eventModel.description;
//       request.location = eventModel.location;
//       request.latitude= eventModel.lat.toString();
//       request.longititude = eventModel.long.toString();
//       request.languageId = '1';
//       request.activityTagIDs = eventModel.intrestId;
//       request.income = eventModel.earningId;
//       request.age = eventModel.ageId;
//       request.invitedUserIDs = '2,3';

//       List<AppMultiPartFile> arrFile;
//       if (uploadfile.localFile != null) {
//         arrFile = [uploadfile];
//       }

//       CreateEventResponse response = await ApiProvider()
//           .callCreateEventApi(params: request, arrFile: arrFile);

//       Navigator.pop(context); //pop dialog

//        new Future.delayed(new Duration(seconds: 1), () {

//       if (response.status == true) {

//         SmartUtils.showErrorDialog(context, response.message);
//         new Future.delayed(new Duration(seconds: 2), () {

//           Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(builder: (_) => HomeEvent()),
//                 (Route<dynamic> route) => false);
//        });
//    //   this.setDataInToUserModel(response.user, preferences);
//       } else {
//         SmartUtils.showErrorDialog(context, response.message);
//       }
//       });

//     // }
//     // return response;
//   }

}
