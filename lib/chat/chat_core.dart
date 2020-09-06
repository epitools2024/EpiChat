import 'package:flutter/material.dart';
import 'package:EpiChat/chat/search_view.dart';

class Chat extends StatefulWidget {
  Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.search,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => SearchView()));
          }),
    ));
  }
}
