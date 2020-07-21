import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PreviewImageScreens extends StatefulWidget {
  final String image;

  PreviewImageScreens({this.image});
  @override
  _PreviewImageScreensState createState() =>
      _PreviewImageScreensState(this.image);
}

class _PreviewImageScreensState extends State<PreviewImageScreens> {
  final String image;

  _PreviewImageScreensState(
    this.image,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _getAppBarUI(),
          Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                44,
            child: PhotoView(
              imageProvider: NetworkImage(image),
              // imageProvider: AssetImage("assets/large-image.jpg"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getAppBarUI() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      padding: EdgeInsets.only(top: 00, bottom: 10),
      height: 44,
      width: MediaQuery.of(context).size.width,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
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
}
