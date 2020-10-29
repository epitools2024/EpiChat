import 'package:flutter/material.dart';
import 'package:EpiChat/chat/search_view.dart';
import 'package:EpiChat/services/database.dart';
import 'package:EpiChat/lib.dart' as lib;

class ChatRoomsTile extends StatelessWidget {
  String photoURL;
  String name;
  String lastMessage;
  int nbrUnreadMessage;
  String lastMessageHour;

  ChatRoomsTile(
      {this.photoURL,
      this.name,
      this.lastMessage,
      this.lastMessageHour,
      this.nbrUnreadMessage});

  String formatter(String msg) {
    String result;

    if (msg.length > 26) {
      result = msg.substring(0, 26) + '...';
      return (result);
    } else
      return (msg);
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        color: Colors.grey[150],
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  height: 78,
                  width: 78,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  top: 4,
                  left: 4,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png',
                    ),
                    backgroundColor: Theme.of(context).accentColor,
                    radius: 35,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * (0.55),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: this.name + '\n\n',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                      text: formatter(this.lastMessage),
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.6),
                          fontWeight: FontWeight.normal,
                          fontSize: 15)),
                ]),
              ),
            ),
            Column(
              children: [
                Text(
                  this.lastMessageHour,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 27,
                  width: 27,
                  decoration: BoxDecoration(
                    color: !(this.nbrUnreadMessage == 0)
                        ? Theme.of(context).accentColor
                        : Colors.transparent,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                      padding: EdgeInsets.all(2),
                      child: Center(
                        child: !(this.nbrUnreadMessage == 0)
                            ? Text(
                                this.nbrUnreadMessage.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                            : null,
                      )),
                ),
              ],
            )
          ],
        )));
  }
}

class Chat extends StatefulWidget {
  Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream chatRoomsStream;
  String fullMessage = "Salut bro comment te portes tu ?";
  DatabaseMethods data = new DatabaseMethods();
  var usermail;

  _getUsermail() async {
    var mail = await lib.getStringFromSharedPref('email');
    await data.getChatRooms(mail).then((value) {
      setState(() {
        chatRoomsStream = value;
      });
    });
  }

  @override
  void initState() {
    _getUsermail();
    super.initState();
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return (snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return (Container(
                    child: Text(
                      snapshot.data.docs[index].data()["users"][0],
                    ),
                  ));
                },
              )
            : Align(
                child: CircularProgressIndicator(),
              ));
      },
    );
  }

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
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: chatRoomsList(),
          ),
        )));
  }
}
