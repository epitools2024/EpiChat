import 'package:flutter/material.dart';
import '../viewmodels/base_viewmodel.dart';
import '../views/base_view.dart';

class EmptyViewModel extends BaseViewModel {}

class EmptyView extends StatefulWidget {
  EmptyView({Key? key}) : super(key: key);

  @override
  _EmptyViewState createState() => _EmptyViewState();
}

class _EmptyViewState extends State<EmptyView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<EmptyViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(),
        body: ListBody(),
      ),
    );
  }
}
