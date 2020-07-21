import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simposi/Screens/TabViewController/MeetAgainScreens/MeetAgainReallyBad.dart';
import 'package:simposi/Screens/TabViewController/MeetAgainScreens/MeetAgainVeryLike.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/SmartRequestMethod.dart';
import 'package:simposi/Utils/Utility/SmartResponse.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/Utility/Values/gradients.dart';
import 'package:simposi/Utils/smartutils.dart';

class MeetAgainScreen extends StatefulWidget {
  final NotificationList notification;
  MeetAgainScreen({
    @required this.notification,
  });

  @override
  _MeetAgainScreenState createState() =>
      _MeetAgainScreenState(notification: this.notification);
}

class _MeetAgainScreenState extends State<MeetAgainScreen> {
  final NotificationList notification;

  _MeetAgainScreenState({
    @required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 310,
                height: 70,
                margin: EdgeInsets.only(top: 72),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "Do you want to meet again?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "Increase or decrease the odds of meeting \nagain. You’ll never be matched twice with someone \nyou didn’t like.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.accentText,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          height: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin:
                    EdgeInsets.only(left: 16, top: 36, right: 16, bottom: 8),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: 510,
                      // left: 0,
                      // top: 0,
                      // right: 0,
                      child: ClipRRect(
                          // decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            notification.profile_photo,
                            width: MediaQuery.of(context).size.width,
                            fit: BoxFit.fitHeight,
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 310,
                      ),
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: Gradients.imageGradient,
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(
                    //     top: 435,
                    //   ),
                    //   height: 150,
                    //   color: Colors.white,
                    //   // decoration: BoxDecoration(
                    //   // gradient: Gradients.imageGradient,
                    //   // ),
                    // ),
                    Positioned(
                      left: 20,
                      bottom: 0,
                      // margin: EdgeInsets.only(
                      //   top: 635,
                      // ),
                      child: Text(
                        notification.user_name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.w700,
                          fontSize: 21,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: MediaQuery.of(context).size.width - 80,
                height: 41,
                margin: EdgeInsets.only(bottom: 73),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => {
                              callApiForRating(rating: 5),
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 40,
                                height: 40,
                                // margin: EdgeInsets.only(left: 27),
                                child: Image.asset(
                                  "assets/heart1-2.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () => {
                              callApiForRating(rating: 4),
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 40,
                                height: 40,
                                // margin: EdgeInsets.only(left: 27),
                                child: Image.asset(
                                  "assets/like.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () => {
                              callApiForRating(rating: 3),
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 41,
                                height: 41,
                                // margin: EdgeInsets.only(right: 26),
                                child: Image.asset(
                                  "assets/didnt-like.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () => {
                              callApiForRating(rating: 2),
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 40,
                                height: 40,
                                child: Image.asset(
                                  "assets/hate.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () => {
                              callApiForRating(rating: 1),
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 40,
                                height: 40,
                                child: Image.asset(
                                  "assets/neutral.png",
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Positioned(
                    //   child: Image.asset(
                    //     "assets/neutral.png",
                    //     fit: BoxFit.none,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 25),
                child: Text(
                  "This information will never be shared with anyone.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 187, 187, 187),
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }

  callApiForRating({int rating}) async {
    UserRatingRequest request;
    request = UserRatingRequest();
    request.opponent_user_id = this.notification.user_id.toString();
    request.language_id = '1';
    request.rating = rating.toString();

    RatingResponse responseBusiness =
        await ApiProvider().callRatingResponse(params: request);

    print(responseBusiness);
    if (rating == 5) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MeetAgainVeryLike(notification: this.notification)));

      // MeetAgainVeryLike
    } else if (rating == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MeetAgainReallyBad(notification: this.notification)));
    } else {
      Navigator.of(context).pop();
      SmartUtils.showErrorDialog(context, responseBusiness.message);
    }

    return responseBusiness;
  }
}
