import 'dart:ui';

import 'package:EpiChat/widget/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:EpiChat/main.dart';
import 'package:EpiChat/lib.dart' as lib;
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  bool enableOnBoard = true;
  int nbrTimeOpened;
  var isEpitech, mail, autologin;
  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(milliseconds: 2300);
    isEpitech = await lib.getBoolFromSharedPref('isEpitech');
    mail = await lib.getStringFromSharedPref('email');
    autologin = await lib.getStringFromSharedPref('autologin');
    return new Timer(_duration, () => navigationPage());
  }

  void navigationPage() {
    if (isEpitech == true && mail != null && autologin != null)
      Navigator.pushReplacementNamed(context, 'home');
    else
      Navigator.of(context).pushNamedAndRemoveUntil(
          'questions', (Route<dynamic> route) => false);
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 2000));
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.bounceInOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();
    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scaling_factor = 0.70;

    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomCenteredColumn(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * (0.6),
              width: MediaQuery.of(context).size.width * (0.8),
              child: Center(
                child: new Image.asset(
                  'assets/png/epichat-name.png',
                  width: animation.value *
                      MediaQuery.of(context).size.width *
                      (scaling_factor),
                  height: animation.value *
                      MediaQuery.of(context).size.width *
                      (scaling_factor),
                ),
              ),
            ),
            CustomCenteredRow(
              children: [
                Text(
                  "by",
                  style: TextStyle(
                      fontFamily: 'Robotto', fontStyle: FontStyle.italic),
                ),
                Image.asset(
                  'assets/png/epitools.jpeg',
                  scale: 9,
                )
              ],
            )
          ],
        ));
  }
}
