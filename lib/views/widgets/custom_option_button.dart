import 'package:flutter/material.dart';

class CustomOptionButton extends StatelessWidget {
  final void Function()? func;
  final String? label;
  final IconData? ico;
  CustomOptionButton({this.label, this.func, this.ico});

  @override
  Widget build(BuildContext context) {
    return (InkWell(
      borderRadius: BorderRadius.circular(8),
      splashColor: Theme.of(context).accentColor,
      onTap: this.func,
      child: Padding(
        padding: EdgeInsets.all(3),
        child: Container(
          height: MediaQuery.of(context).size.height * (0.065),
          width: MediaQuery.of(context).size.width * (0.95),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 1,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * (0.03),
                ),
                Icon(
                  this.ico,
                  size: MediaQuery.of(context).size.width * (0.08),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * (0.05),
                ),
                Text(
                  this.label!,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * (0.025),
                    color: Theme.of(context).accentColor,
                  ),
                )
              ],
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 0.01,
                color: Colors.grey[350]!,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
