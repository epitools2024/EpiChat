import 'package:EpiChat/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import '../views/base_view.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        body: ListBody(),
      ),
    );
  }
}
