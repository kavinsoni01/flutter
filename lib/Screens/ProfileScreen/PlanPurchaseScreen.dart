

import 'package:flutter/material.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/Utility/Values/radii.dart';

class PlanPurchaseScreen extends StatefulWidget {
  @override
  _PlanPurchaseScreenState createState() => _PlanPurchaseScreenState();
}

class _PlanPurchaseScreenState extends State<PlanPurchaseScreen> {
 
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(bottom:9),
              // bottom: 9,
              child: Container(
                width: 134,
                height: 5,
                decoration: BoxDecoration(
                  color: AppColors.accentElement,
                  borderRadius: BorderRadius.all(Radius.circular(2.5)),
                ),
                child: Container(),
              ),
            ),
            Container(
              // left: 0,
              // top: 0,
              // right: -1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 785,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          height: 211,
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              Container(
                                // left: -0,
                                // right: 0,
                                child: Image.asset(
                                  "assets/subscribe-background.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top:46,right:15),
                                // top: 46,
                                // right: 15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: 24,
                                        height: 24,
                                        child: Image.asset(
                                          "assets/close-button.png",
                                          fit: BoxFit.none,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        width: 249,
                                        height: 55,
                                        margin: EdgeInsets.only(top: 37),
                                        child: Stack(
                                          alignment: Alignment.topCenter,
                                          children: [
                                            Container(
                                              // top: 0,
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
                                            Container(
                                              padding: EdgeInsets.only(left:0,top:17,),
                                              // left: 0,
                                              // top: 17,
                                              // right: 0,
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
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 301,
                            height: 135,
                            margin: EdgeInsets.only(top: 126),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: 71,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(top:21),
                                        // left: 0,
                                        // top: 21,
                                        // right: 0,
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(52, 25, 39, 240),
                                            borderRadius: Radii.k25pxRadius,
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(bottom: 3),
                                                child: Text(
                                                  "First Year Free!",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color.fromARGB(255, 25, 39, 240),
                                                    fontFamily: "Muli",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 11,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(255, 25, 39, 240),
                                            borderRadius: Radii.k25pxRadius,
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.only(top: 18),
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryElement,
                                    border: Border.all(
                                      width: 2,
                                      color: Color.fromARGB(255, 24, 39, 240),
                                    ),
                                    borderRadius: Radii.k25pxRadius,
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(top: 18),
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 144,
                            height: 19,
                            margin: EdgeInsets.only(top: 25),
                            child: Row(
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 45, 46, 48),
                                    borderRadius: BorderRadius.all(Radius.circular(3)),
                                  ),
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 4),
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
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 301,
                            child: Text(
                              "Using promo code Caterpillar will apply a credit of \$50 to your account which you can use towards a monthly or annual subsription. Subscriptions automatically renew monthly or annually as selected, You can cancel at anytime. Promotions and subscriptions are subject Simposi’s Terms of Service and Privacy Policy.",
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
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 134,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppColors.accentElement,
                        borderRadius: BorderRadius.all(Radius.circular(2.5)),
                      ),
                      child: Container(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:253,bottom:143),
              // top: 253,
              // bottom: 143,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 239,
                      height: 63,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Limited Time Offer",
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
                            margin: EdgeInsets.only(top: 2),
                            child: Text(
                              "Redeem Promo Code “Caterpillar” \nto get your first year free on us!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryText,
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
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 301,
                      height: 50,
                      margin: EdgeInsets.only(top: 224),
                      decoration: BoxDecoration(
                        color: AppColors.primaryElement,
                        borderRadius: Radii.k25pxRadius,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Redeem Promo",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 301,
                      height: 46,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "Still not sure?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontFamily: "Muli",
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          Text(
                            "Don’t worry, Simposi will always be here when you need us, with one free. meetup per month for everyone.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: AppColors.primaryText,
                              fontFamily: "Muli",
                              fontWeight: FontWeight.w400,
                              fontSize: 11,
                              height: 1.18182,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}