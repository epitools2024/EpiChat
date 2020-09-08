import 'package:flutter/material.dart';
import 'package:EpiChat/widget/custom_widget.dart';
import 'package:line_icons/line_icons.dart';

class ConversationScreen extends StatefulWidget {
  final String correspondentName;
  final String chatId;

  ConversationScreen({this.correspondentName, this.chatId});

  @override
  ConversationScreenState createState() => ConversationScreenState();
}

class ConversationScreenState extends State<ConversationScreen> {
  List<Widget> messageList = [];

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            compenants: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * (0.001)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      LineIcons.chevron_circle_left,
                      size: MediaQuery.of(context).size.height * (0.05),
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * (0.05),
              ),
              Text(
                "${widget.correspondentName}",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          )),
      body: Column(
        children: [
          Flexible(
              child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            reverse: true, //To keep the latest messages at the bottom
            itemBuilder: (_, int index) => messageList[index],
            itemCount: messageList.length,
          )),
          Card(
            margin: EdgeInsets.all(10),
            color: Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      controller: _controller,
                      decoration:
                          InputDecoration.collapsed(hintText: "Ecrivez ici !"),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Theme.of(context).accentColor),
                  onPressed: () {
                    _controller.clear();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
