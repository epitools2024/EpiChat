import 'package:flutter/material.dart';
import 'package:EpiChat/widget/custom_widget.dart';

import 'package:line_icons/line_icons.dart';

class SearchView extends StatefulWidget {
  SearchView({Key key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  TextEditingController searchController = new TextEditingController();

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
                      hintText: "Entrez le nom à rechercher ici...",
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
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(80),
                    ),
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey[300],
            height: 10,
          ),
        ],
      ),
    ));
  }
}
