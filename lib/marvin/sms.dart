import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Sms extends StatelessWidget {
  final String from;
  final String message;
  final double _fontSize = 15;

  Sms(this.from, this.message);

  Widget userSms(BuildContext context) {
    return (Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          this.message,
          style: TextStyle(
            color: Colors.white,
            fontSize: _fontSize,
          ),
        ),
      )
    ]));
  }

  Widget botSms(BuildContext context) {
    return (Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Icon(
          FontAwesomeIcons.robot,
          color: Theme.of(context).accentColor,
          size: 15,
        ),
        SizedBox(
          width: 8,
        ),
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.all(8),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * (0.5),
          ),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            this.message,
            style: TextStyle(color: Colors.black, fontSize: _fontSize),
          ),
        ),
      ]),
    ]));
  }

  @override
  Widget build(BuildContext context) =>
      (this.from == 'user' ? userSms(context) : botSms(context));
}
