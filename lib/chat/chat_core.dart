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
    var tmp = await lib.getStringFromSharedPref('email');
    await data.getChatRooms(tmp).then((value) {
      chatRoomsStream = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUsermail();
  }

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRoomsStream,
      builder: (context, snapshot) {
        return (snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.lenght,
                itemBuilder: (context, index) {
                  return (ChatRoomsTile(
                    name: snapshot.data.docs[index].data()["users"][1],
                    lastMessage: "Mon argent bro ?",
                    nbrUnreadMessage: 0,
                    lastMessageHour: "11:20",
                  ));
                },
              )
            : CircularProgressIndicator());
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
            child: Wrap(
              direction: Axis.vertical,
              spacing: 5,
              children: [
                SizedBox(
                  height: 5,
                ),
                ChatRoomsTile(
                  photoURL: 'https://randomuser.me/api/portraits/men/17.jpg',
                  name: "Jean Claude",
                  lastMessage: "Mon argent bro ?",
                  nbrUnreadMessage: 0,
                  lastMessageHour: "11:20",
                ),
                ChatRoomsTile(
                  photoURL: 'https://randomuser.me/api/portraits/men/18.jpg',
                  name: "Baba Tiguè",
                  lastMessage: "Je cherche ta soeur.. Impoli !",
                  nbrUnreadMessage: 100,
                  lastMessageHour: "11:20",
                ),
                ChatRoomsTile(
                  photoURL: 'https://randomuser.me/api/portraits/men/19.jpg',
                  name: "Fofo Mano",
                  lastMessage: "Arrête la weeb. C'est pas bien.",
                  nbrUnreadMessage: 2,
                  lastMessageHour: "11:20",
                ),
                ChatRoomsTile(
                  photoURL: 'https://randomuser.me/api/portraits/men/20.jpg',
                  name: "Boss",
                  lastMessage: fullMessage,
                  nbrUnreadMessage: 1,
                  lastMessageHour: "14:01",
                ),
                ChatRoomsTile(
                  photoURL: 'https://randomuser.me/api/portraits/women/17.jpg',
                  name: "Andrea",
                  lastMessage: "Sodabi combien ?",
                  nbrUnreadMessage: 5,
                  lastMessageHour: "12:20",
                ),
                ChatRoomsTile(
                  photoURL: 'https://randomuser.me/api/portraits/women/1.jpg',
                  name: "Kpocle",
                  lastMessage: "Miss U Bae...",
                  nbrUnreadMessage: 5,
                  lastMessageHour: "04:10",
                ),
                ChatRoomsTile(
                  photoURL: 'https://randomuser.me/api/portraits/men/50.jpg',
                  name: "Brizzy",
                  lastMessage: "Je suis vraiment énerver contre toi",
                  nbrUnreadMessage: 5,
                  lastMessageHour: "20:50",
                ),
                ChatRoomsTile(
                  photoURL: 'https://randomuser.me/api/portraits/women/28.jpg',
                  name: "Tanti Claudia",
                  lastMessage: "Bébé tu es où ?",
                  nbrUnreadMessage: 5,
                  lastMessageHour: "8:37",
                ),
                ChatRoomsTile(
                  photoURL: 'https://randomuser.me/api/portraits/men/65.jpg',
                  name: "Jean Claude",
                  lastMessage: "COCHON !",
                  nbrUnreadMessage: 1,
                  lastMessageHour: "19:16",
                ),
              ],
            ))));
  }
}
