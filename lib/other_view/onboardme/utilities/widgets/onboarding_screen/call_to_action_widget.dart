import 'package:flutter/material.dart';

Widget callToAction({text = 'COMMENCER', homeRoute, context}) {
  return Container(
      height: 70,
      width: double.infinity,
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('home', (Route<dynamic> route) => false);
        },
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              'COMMENCER',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                letterSpacing: -1.0,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ));
}
