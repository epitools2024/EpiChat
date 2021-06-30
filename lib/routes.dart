import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'helpers/empty_view.dart';

import 'views/home_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return MaterialPageRoute(builder: (_) {
          return EmptyView();
        });
    }
  }
}
