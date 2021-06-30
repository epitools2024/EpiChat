import 'package:flutter/material.dart';

class CustomCenteredColumn extends StatelessWidget {
  final List<Widget> children;

  CustomCenteredColumn({required this.children});

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        Expanded(
          child: SizedBox(),
        ),
        Column(
          children: children,
        ),
        Expanded(
          child: SizedBox(),
        ),
      ],
    ));
  }
}
