import 'package:EpiChat/views/epitech_choice_view.dart';
import 'package:EpiChat/views/home_view.dart';
import 'package:EpiChat/views/login_view.dart';
import 'package:EpiChat/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'helpers/empty_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => SplashView());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginView());
      case '/choice':
        return MaterialPageRoute(builder: (_) => EpitechChoiceView());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return EmptyView();
          },
        );
    }
  }
}
