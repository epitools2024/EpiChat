import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:EpiChat/widget/custom_widget.dart';
import 'package:line_icons/line_icons.dart';
import 'package:EpiChat/services/database.dart';

class ConversationScreen extends StatefulWidget {
  final String usermail;
  final String correspondentmail;
  final String correspondentname;
  final String chatId;

  ConversationScreen(
      {this.correspondentname,
      this.correspondentmail,
      this.usermail,
      this.chatId});

  @override
  ConversationScreenState createState() => ConversationScreenState();
}

class ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController _messageController = TextEditingController();
  DatabaseMethods data = new DatabaseMethods();
  Stream chatsStream;

  @override
  void initState() {
    super.initState();
    data.getConversationMessages(widget.chatId).then((value) {
      setState(() {
        chatsStream = value;
      });
    });
  }

  sendMessage() {
    Map<String, dynamic> message = {
      'content': _messageController.text,
      'sendBy': widget.usermail,
      'time': DateTime.now().millisecondsSinceEpoch,
    };
    if (_messageController.text.isNotEmpty) {
      data.addConversationMessage(widget.chatId, message);
      _messageController.clear();
    }
  }

  Widget messageList() {
    return StreamBuilder(
      stream: chatsStream,
      builder: (context, snapshot) {
        return (snapshot.hasData
            ? Column(children: [
                Container(
                    height: MediaQuery.of(context).size.height * (0.78),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        return (MessageTile(
                          content: snapshot.data.docs[index].data()["content"],
                          sender: snapshot.data.docs[index].data()["sendBy"] ==
                                  widget.usermail
                              ? "me"
                              : "correspondent",
                        ));
                      },
                    ))
              ])
            : CircularProgressIndicator());
      },
    );
  }

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
                "${widget.correspondentname}",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          )),
      body: SingleChildScrollView(
          child: Column(
        children: [
          messageList(),
          Align(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Card(
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
                          controller: _messageController,
                          decoration: InputDecoration.collapsed(
                              hintText: "Ecrivez ici !"),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send,
                          color: Theme.of(context).accentColor),
                      onPressed: () {
                        sendMessage();
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String content;
  final String sender;

  MessageTile({this.content, this.sender});

  Widget userMessageTile(BuildContext context) {
    return (Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      SizedBox(height: 2),
      Container(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * (0.49)),
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          "${this.content}",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      SizedBox(
        height: 10,
      )
    ]));
  }

  Widget correspondentMessageTile(BuildContext context) {
    return (Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(height: 2),
      Container(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * (0.49)),
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "${this.content}",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ),
      SizedBox(
        height: 10,
      )
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return (this.sender == 'me'
        ? userMessageTile(context)
        : correspondentMessageTile(context));
  }
}
