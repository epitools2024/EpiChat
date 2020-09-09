import 'package:flutter/material.dart';
import 'package:EpiChat/widget/custom_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line_icons/line_icons.dart';
import 'package:EpiChat/services/database.dart';
import 'package:EpiChat/lib.dart' as lib;
import 'package:EpiChat/chat/conversation.dart';

class SearchTile extends StatelessWidget {
  final String username;
  final String usermail;
  final String correspondentname;
  final String correspondentmail;

  SearchTile({
    this.correspondentname,
    this.correspondentmail,
    this.username,
    this.usermail,
  });

  createAndStartConversation(String correspondentMail) {
    if (this.correspondentmail != this.username) {
      String chatId = getChatRoomId(this.usermail, this.correspondentmail);
      List<String> users = [this.usermail, this.correspondentmail];
      Map<String, dynamic> chatRoomData = {
        'users': users,
        'chatroomId': chatId,
      };
      DatabaseMethods().createChatRoom(chatId, chatRoomData);
    }
  }

  getChatRoomId(String usermail, String correspondentmail) {
    if (this.usermail.substring(0, 1).codeUnitAt(0) >
        this.correspondentmail.substring(0, 1).codeUnitAt(0)) {
      return "${this.correspondentmail}\_${this.usermail}";
    } else {
      return "${this.usermail}\_${this.correspondentmail}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Column(children: [
      ListTile(
        dense: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        title: Text(
          this.correspondentname == null ? "null" : this.correspondentname,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          this.correspondentmail == null ? "null" : this.correspondentmail,
        ),
        trailing: FlatButton(
          color: Theme.of(context).accentColor,
          onPressed: () {
            String chatId =
                getChatRoomId(this.usermail, this.correspondentmail);

            createAndStartConversation(this.correspondentmail);
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondanimation) {
                  return ConversationScreen(
                    chatId: chatId == null ? "Error" : chatId,
                    correspondentmail: this.correspondentmail,
                    usermail: this.usermail,
                    correspondentname: this.correspondentname,
                  );
                },
                transitionDuration: Duration(milliseconds: 200),
                transitionsBuilder:
                    (context, animation, anotherAnimation, child) {
                  return (SlideTransition(
                    position:
                        Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation),
                    child: child,
                  ));
                }));
          },
          child: Text(
            "Ecrirez",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      ),
      Divider(
        color: Colors.grey[300],
        height: 1,
      ),
    ]));
  }
}

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = new TextEditingController();
  QuerySnapshot searchSnapshot;
  DatabaseMethods database = new DatabaseMethods();
  var usermail;
  var username;

  @override
  void initState() {
    super.initState();
    _initSearch();
    _getUserLocalInfos();
  }

  _getUserLocalInfos() async {
    var tmp = await lib.getStringFromSharedPref('email');
    var tmp2 = await lib.getStringFromSharedPref('username');

    setState(() {
      usermail = tmp;
      username = tmp2;
    });
  }

  _initSearch() {
    bool data = searchController.text.contains("@");

    if (data) {
      database.getUserByEmail("${searchController.text}").then((value) {
        setState(() {
          print("${value.docs.length}");
          searchSnapshot = value;
        });
      });
    } else {
      database.getUserByUsername("${searchController.text}").then((value) {
        setState(() {
          print("${value.docs.length}");
          searchSnapshot = value;
        });
      });
    }
  }

  Widget _searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot.docs.length,
            itemBuilder: (context, index) {
              return SearchTile(
                correspondentname:
                    searchSnapshot.docs[index].data()["username"],
                correspondentmail: searchSnapshot.docs[index].data()["email"],
                usermail: usermail,
                username: username,
              );
            },
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(compenants: [
          IconButton(
            icon: Icon(
              LineIcons.chevron_circle_left,
              color: Theme.of(context).accentColor,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pop(context),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * (0.01),
          ),
          Center(
            child: Text(
              "Rechercher un utilisateur",
              style: TextStyle(
                fontSize: 21,
                color: Theme.of(context).accentColor,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
        ]),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Entrez le nom d'utilisateur ou l'email ici...",
                    ),
                  ),
                ),
                IconButton(
                  icon: Container(
                    height: 50,
                    width: 50,
                    child: Icon(
                      LineIcons.search,
                      color: Theme.of(context).accentColor,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(80),
                    ),
                  ),
                  onPressed: () {
                    _initSearch();
                  },
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey[500],
            height: 1,
          ),
          SingleChildScrollView(
            child: _searchList(),
          )
        ],
      ),
    ));
  }
}
