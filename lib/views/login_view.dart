import 'package:EpiChat/viewmodels/login_viewmodel.dart';
import 'package:flutter/material.dart';
import '../views/base_view.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        body: ListBody(),
      ),
    );
  }
}
