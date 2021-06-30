import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key? key, required this.components}) : super(key: key);
  final List<Widget> components;

  Widget build(BuildContext context) {
    double borderRadius = 10;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[500]!,
            spreadRadius: 1,
            blurRadius: 1,
          )
        ],
      ),
      child: SafeArea(
        child: Row(
          children: this.components,
        ),
      ),
    );
  }
}
