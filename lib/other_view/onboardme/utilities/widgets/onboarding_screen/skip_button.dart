import 'package:flutter/material.dart';

Widget skipButton({text: 'SKIP', homeRoute, context}) {
  return FlatButton(
    onPressed: () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('login', (Route<dynamic> route) => false);
    },
    child: Text(
      text.toString().toUpperCase(),
      style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.0,
          color: Theme.of(context).accentColor),
    ),
  );
}
