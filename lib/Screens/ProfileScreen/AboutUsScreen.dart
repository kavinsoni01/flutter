import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/smartutils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsScreens extends StatefulWidget {
  @override
  _AboutUsScreensState createState() => _AboutUsScreensState();
}

class _AboutUsScreensState extends State<AboutUsScreens> {
  String termsAndCondition = '';

  // _TermsAndConditionState();
  List<CMSModel> cmsData;
  // WebViewController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      this.callMainDataApiApi();
    });
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _getAppBarUI(),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Text(
                      "About Us",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primaryText,
                        fontFamily: "Muli",
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    margin: EdgeInsets.only(left: 17, top: 10, right: 16),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 187, 187, 187),
                    ),
                    child: Container(),
                  ),

                  Container(
                    margin: EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20,
                    ),
                    height: MediaQuery.of(context).size.height - 127,
                    child: SingleChildScrollView(
                      child: Text(
                        removeAllHtmlTags(termsAndCondition.toString()),

                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        // maxLines: 0,
                      ),
                    ),
                  )
                  // Container(
                  //   margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                  //   height: MediaQuery.of(context).size.height - 127,
                  //   child: WebView(
                  //     initialUrl: '',
                  //     onWebViewCreated: (WebViewController webViewController) {
                  //       _controller = webViewController;
                  //       var newHTML =
                  //           "<!DOCTYPE html><html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"></head><!--termsAndCondition-->";

                  //       _controller.loadUrl(Uri.dataFromString(
                  //               termsAndCondition,
                  //               mimeType: 'text/html',
                  //               encoding: Encoding.getByName('utf-8'))
                  //           .toString());
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  Widget _getAppBarUI() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      padding: EdgeInsets.only(top: 0, bottom: 0),
      height: 41,
      width: MediaQuery.of(context).size.width,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: 0,
            decoration: BoxDecoration(
              color: Color.fromARGB(50, 25, 39, 240),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 25, 39, 240),
                  ),
                  child: Container(
                    margin: EdgeInsets.all(0),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                    child: Container(
                      width: 20,
                      height: 16,
                      margin: EdgeInsets.only(left: 16, top: 14),
                      child: Image.asset(
                        "assets/backArrow@3x.png",
                      ),
                    ),
                    onTap: () => {
                          Navigator.pop(context, ""),
                        }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void callMainDataApiApi() async {
    //TODO : call Api Here

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

    var response = await ApiProvider().callCMSDataApi();

    Navigator.pop(context); //pop dialog

    new Future.delayed(new Duration(seconds: 1), () {
      print(response);
      if (response.status == true) {
        this.cmsData = response.dataModel;
        if (this.cmsData.length > 0) {
          this.cmsData.forEach((element) {
            if (element.cms_title == 'About Us') {
              termsAndCondition = element.cms_description;

              // var newHTML =
              //     "<!DOCTYPE html><html><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"></head><!--" +
              //         termsAndCondition +
              //         "-->";

              // _controller.loadUrl(Uri.dataFromString(termsAndCondition,
              //         mimeType: 'text/html',
              //         encoding: Encoding.getByName('utf-8'))
              //     .toString());

              // String fileText = await rootBundle.loadString('assets/help.html');
            }
          });

          setState(() {});
        }
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
}
