import 'package:flutter/material.dart';

class CustomCenteredRow extends StatelessWidget {
  final List<Widget> children;

  CustomCenteredRow({required this.children});

  @override
  Widget build(BuildContext context) {
    return (Row(
      children: [
        Expanded(
          child: SizedBox(),
        ),
        Row(
          children: children,
        ),
        Expanded(
          child: SizedBox(),
        ),
      ],
    ));
  }
}
