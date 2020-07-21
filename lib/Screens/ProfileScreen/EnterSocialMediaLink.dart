import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simposi/Utils/Utility/Values/colors.dart';

class EnterSocialMediaLink extends StatefulWidget {
  final String stringDesc;
  final String title;

  EnterSocialMediaLink({@required this.stringDesc, this.title});

  @override
  _EnterSocialMediaLinkState createState() =>
      _EnterSocialMediaLinkState(this.stringDesc, this.title);
}

class _EnterSocialMediaLinkState extends State<EnterSocialMediaLink> {
  final String stringDesc;
  final String title;

  TextEditingController txtDescription = new TextEditingController();

  _EnterSocialMediaLinkState(this.stringDesc, this.title);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    txtDescription.text = stringDesc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 21,
                margin: EdgeInsets.only(left: 11, top: 53, right: 13),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      // left: 0,
                      // right: 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: () => {
                              Navigator.pop(context, stringDesc),
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Cancel",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 25, 39, 240),
                                  fontFamily: "Muli",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () => {
                              Navigator.pop(context, txtDescription.text),
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Submit",
                                textAlign: TextAlign.right,
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
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Text(
                  title + " Link",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryText,
                    fontFamily: "Muli",
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 295,
                  margin: EdgeInsets.only(top: 16),
                  child: Text(
                    "Enter your " + title + ' Link',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.accentText,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 1.14286,
                    ),
                  ),
                ),
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 17, top: 11, right: 16),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 187, 187, 187),
                ),
                child: Container(),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  width: 342,
                  height: 598,
                  margin: EdgeInsets.only(left: 17, top: 18),
                  child: TextField(
                    controller: txtDescription,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Type here…",
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 181, 179, 179),
                      ),
                      contentPadding: EdgeInsets.all(0),
                      border: InputBorder.none,
                    ),
                    style: TextStyle(
                      color: AppColors.primaryText,
                      fontFamily: "Muli",
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                    autocorrect: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
