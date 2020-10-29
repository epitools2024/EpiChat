import 'package:flutter/material.dart';

List<Widget> pageIndicator(
  int numOfPages,
  int currentPage,
  bool isPageIndicatorCircle,
  BuildContext context,
) {
  List<Widget> list = [];

  for (int i = 0; i < numOfPages; i++) {
    list.add(i == currentPage
        ? currentPageIndicator(true, isPageIndicatorCircle, context)
        : currentPageIndicator(false, isPageIndicatorCircle, context));
  }
  return list;
}

Widget currentPageIndicator(
    bool isActive, bool isPageIndicatorCircle, context) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 500),
    margin: EdgeInsets.symmetric(horizontal: 10),
    height: 8,
    width: isPageIndicatorCircle ? 8 : 24,
    decoration:
        pageIndicatorBoxDecoration(isActive, isPageIndicatorCircle, context),
  );
}

Decoration pageIndicatorBoxDecoration(
    isActive, isPageIndicatorCircle, context) {
  return BoxDecoration(
    color: isActive ? Theme.of(context).accentColor : Colors.grey,
    borderRadius: BorderRadius.all(
      Radius.circular(
        isPageIndicatorCircle ? 5 : 100,
      ),
    ),
  );
}
