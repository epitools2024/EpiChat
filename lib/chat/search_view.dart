import 'package:flutter/material.dart';
import 'package:EpiChat/widget/custom_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:line_icons/line_icons.dart';

class SearchTile extends StatelessWidget {
  final String username;
  final String usermail;

  SearchTile({this.username, this.usermail});

  @override
  Widget build(BuildContext context) {
    return (Column(children: [
      ListTile(
        dense: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        title: Text(
          this.username == null ? "null" : this.username,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        subtitle: Text(
          this.usermail == null ? "null" : this.usermail,
        ),
        trailing: FlatButton(
          color: Theme.of(context).accentColor,
          onPressed: () {},
          child: Text(
            "Ecrire",
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

  @override
  void initState() {
    super.initState();
    _initSearch();
  }

  _initSearch() {
    bool data = searchController.text.contains("@");

    if (data) {
      FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: "${searchController.text}")
          .get()
          .then((value) {
        setState(() {
          print("${value.docs.length}");
          searchSnapshot = value;
        });
      });
    } else {
      FirebaseFirestore.instance
          .collection("users")
          .where("username", isEqualTo: "${searchController.text}")
          .get()
          .then((value) {
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
                username: searchSnapshot.docs[index].data()["username"],
                usermail: searchSnapshot.docs[index].data()["email"],
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
