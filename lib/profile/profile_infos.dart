import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:EpiChat/widget/custom_widget.dart';
import 'package:EpiChat/lib.dart' as lib;
import 'package:EpiChat/api/intra.dart' as intra;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:EpiChat/services/auth.dart';

class ProfileInfos extends StatefulWidget {
  ProfileInfos({Key key}) : super(key: key);
  @override
  _ProfileInfosState createState() => _ProfileInfosState();
}

class _ProfileInfosState extends State<ProfileInfos> {
  double gpa = 0.0;
  int year = 1;
  int credit;
  String epitechMail, autologin;
  GlobalKey _key;
  bool _isLoading = false;
  String username;
  QuerySnapshot nameSnapshot;
  AuthMethods auth = new AuthMethods();

  void _initUserInfos() async {
    var login = await lib.getStringFromSharedPref('autologin');
    var mail = await lib.getStringFromSharedPref('email');
    var usrname = await lib.getStringFromSharedPref('username');

    setState(() {
      epitechMail = mail;
      autologin = login;
      username = usrname;
    });
  }

  @override
  void initState() {
    super.initState();
    _initUserInfos();
  }

  Widget _profileWidget(String urlToPP, String name, String infos) {
    return (Container(
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              urlToPP,
              scale: 4,
            ),
            radius: MediaQuery.of(context).size.width * (0.156),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "$name",
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: MediaQuery.of(context).size.height * (0.03),
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "$infos",
            style: TextStyle(
              color: Colors.grey[500].withOpacity(0.6),
              fontSize: MediaQuery.of(context).size.height * (0.02),
            ),
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    ));
  }

  Widget _infosCard(String infos, String label) {
    return (Expanded(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        Text(
          "$infos",
          style: TextStyle(
            fontFamily: "Rubik",
            color: Theme.of(context).accentColor,
            fontSize: MediaQuery.of(context).size.height * (0.02),
          ),
        ),
        Text(
          "$label",
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * (0.02),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ]),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 0.01,
              color: Colors.grey[200],
            )
          ]),
    )));
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(MediaQuery.of(context).size.width * (0.4),
        MediaQuery.of(context).size.width * (0.4));
    TextStyle labelStyle = TextStyle(
      color: Theme.of(context).accentColor,
      fontSize: 15,
      fontFamily: 'Nunito',
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w600,
    );
    TextStyle valueStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w600,
    );

    return (Scaffold(
        key: _key,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            compenants: [
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
                  "Infos et reglages",
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
              IconButton(
                icon: Icon(Icons.logout, color: Theme.of(context).accentColor),
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  /*await auth.signOut();
                  await lib.setBoolValue('isEpitech', false);
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('questions', (route) => false);*/
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Alert Dialog"),
                          content: Text("Dialog Content"),
                          actions: [
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Wrap(),
                            ),
                          ],
                        );
                      });
                },
              ),
            ],
          ),
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * (0.4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: 0.01,
                                color: Colors.grey[350],
                              )
                            ]),
                        child: Center(
                          child: FutureBuilder(
                            future: (autologin != null && epitechMail != null)
                                ? intra.getInfos(autologin, epitechMail)
                                : null,
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return (CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              } else {
                                int goalValue =
                                    int.parse(snapshot.data.studentyear) * 60;
                                return (Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              (0.01)),
                                  child: Container(
                                    child: Column(children: [
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      _profileWidget(
                                          'https://randomuser.me/api/portraits/men/4.jpg',
                                          "$username",
                                          "$epitechMail"),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      !snapshot.data.isAdmin
                                          ? Row(
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                _infosCard(
                                                    "${snapshot.data.credits}/$goalValue",
                                                    "Crédits"),
                                                SizedBox(
                                                  width: 7,
                                                ),
                                                _infosCard(
                                                    "${snapshot.data.gpa}",
                                                    "GPA"),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                _infosCard(
                                                    "${snapshot.data.studentyear}e",
                                                    "Année"),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                _infosCard(
                                                    "${snapshot.data.cycle}",
                                                    "Cycle"),
                                                SizedBox(
                                                  width: 7,
                                                ),
                                              ],
                                            )
                                          : SizedBox(),
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                    ]),
                                  ),
                                ));
                              }
                            },
                          ),
                        ))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * (0.02),
                ),
                SingleChildScrollView(
                    child: Align(
                        child: Wrap(
                            direction: Axis.vertical,
                            spacing: 1,
                            children: [
                      CustomOptionButton(
                          label: "my.epitech.eu",
                          ico: Icons.public,
                          func: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => WebViewLoad(
                                        url: "https://my.epitech.eu/",
                                        title: "my.epitech.eu",
                                      )))),
                      CustomOptionButton(
                          label: "Roslyn Timeline",
                          ico: LineIcons.paper_plane,
                          func: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => WebViewLoad(
                                        url: "https://roslyn.epi.codes/",
                                        title: "Timeline",
                                      )))),
                      CustomOptionButton(
                        label: "Notes par modules",
                        ico: Icons.notes,
                      ),
                      CustomOptionButton(
                        label: "Projets actuels",
                        ico: Icons.work,
                      ),
                      CustomOptionButton(
                        label: "Infos",
                        ico: LineIcons.info_circle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ])))
              ])));
  }
}
