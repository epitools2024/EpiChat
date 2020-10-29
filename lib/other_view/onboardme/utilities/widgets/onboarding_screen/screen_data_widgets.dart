import 'package:flutter/material.dart';

List<Widget> screenData(int numOfPages, screenContent, BuildContext context) {
  List<Widget> list = [];

  for (int i = 0; i < numOfPages; i++) {
    try {
      list.add(getScreenData(screenContent[i], i, context));
    } catch (e) {
      print("You should provide enough content for all screens");
    }
  }
  return list;
}

Widget getScreenData(
    Map<String, String> screenContent, i, BuildContext context) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 40.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 15.0,
        ),
        Container(
          child: Center(
            child: Image.asset(
              screenContent["Scr ${i + 1} Image Path"].toString(),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * (0.0001)),
        Container(
          alignment: Alignment.center,
          child: Text(screenContent["Scr ${i + 1} Heading"].toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -1.0,
                  color: Theme.of(context).accentColor)),
        ),
        SizedBox(height: 15.0),
        Text(screenContent["Scr ${i + 1} Sub Heading"].toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0, color: Colors.black)),
      ],
    ),
  );
}
