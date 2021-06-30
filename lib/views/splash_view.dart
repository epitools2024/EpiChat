import 'dart:async';
import 'package:EpiChat/locator.dart';
import 'package:EpiChat/models/appuser_model.dart';
import 'package:EpiChat/services/local/local_service.dart';
import 'package:EpiChat/views/widgets/custom_centered_column.dart';
import 'package:EpiChat/views/widgets/custom_centered_row.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
/*with SingleTickerProviderStateMixin*/ {
  LocalService _localService = locator<LocalService>();
  var _visible = true;
  AnimationController? animationController;
  Animation<double>? animation;
  AppUser? _currentUser;

  void navigationPage() {
    /*try {
      _currentUser = _localService.readAppUser();
      Navigator.pushReplacementNamed(context, '/home');*/
//    } catch (e) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/choice', (Route<dynamic> route) => false);
    //  }
  }

  @override
  void initState() {
    super.initState();
    /*animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 2000));
    animation =
        new CurvedAnimation(parent: animation!, curve: Curves.bounceInOut);

    animationController!.addListener(() => this.setState(() {}));
    animationController!.forward();*/
    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  startTime() async {
    var _duration = new Duration(milliseconds: 2300);
    return new Timer(_duration, () => navigationPage());
  }

  @override
  Widget build(BuildContext context) {
    double _scalingFactor = 0.70;
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
                width: MediaQuery.of(context).size.width * (_scalingFactor),
                height: MediaQuery.of(context).size.width * (_scalingFactor),
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
      ),
    );
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }
}
