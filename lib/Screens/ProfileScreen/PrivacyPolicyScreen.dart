import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simposi/Utils/Models/AppDataModel.dart';
import 'package:simposi/Utils/Utility/SmartApiProvider.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';
import 'package:simposi/Utils/smartutils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  // final String stringDesc;

  // PrivacyPolicyScreen({@required this.stringDesc});

  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  // final String stringDesc;

  String privacyPolicy = '';

  // _PrivacyPolicyScreenState();
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
        // child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getAppBarUI(),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    child: Text(
                      "Privacy Policy",
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
                        removeAllHtmlTags(privacyPolicy.toString()),

                        style: TextStyle(
                          color: AppColors.primaryText,
                          fontFamily: "Muli",
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        // maxLines: 0,
                      ),
                    ),
                    //  WebView(
                    //   initialUrl: '',
                    //   onWebViewCreated: (WebViewController webViewController) {
                    //     _controller = webViewController;
                    //     var stri = privacyPolicy.toString();

                    // var htmlText = '<p style="font-size:60px">' +
                    //     privacyPolicy +
                    //     '</p>';

                    // _controller.loadUrl(Uri.dataFromString(htmlText,
                    //         mimeType: 'text/html',
                    //         encoding: Encoding.getByName('utf-8'))
                    //     .toString());
                    // },
                    // ),
                  )
                ],
              ),
            )
          ],
        ),
        // ),
      ),
    );
  }

  // Widget continueButton() {
  //   return RaisedButton(
  //     color: SmartUtils.blueBackground,
  //     onPressed: () {
  //             Navigator.pop(context, txtDescription.text);
  //     },
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
  //     padding: const EdgeInsets.all(0.0),
  //     child: Ink(

  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.all(Radius.circular(50.0)),
  //       ),
  //       child: Container(
  //         constraints: const BoxConstraints(minWidth: 100.0, minHeight: 50.0),
  //         alignment: Alignment.center,
  //         child: const Text(
  //           'Submit',
  //           textAlign: TextAlign.center,
  //           style: TextStyle(fontSize:16,fontWeight: FontWeight.w800, fontFamily: 'Muli', color: Colors.white),
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
            if (element.cms_title == 'Privacy Policy') {
              privacyPolicy = element.cms_description;

              var stri = privacyPolicy.toString();

              // var htmlText = '<p style="font-size:60px">' +
              //     privacyPolicy +
              //     '</p>'; // + <p style="font-family:verdana">This is a paragraph.</p>

              // _controller.loadUrl(Uri.dataFromString(htmlText,
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

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
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
