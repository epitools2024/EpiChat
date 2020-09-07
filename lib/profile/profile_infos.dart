import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:EpiChat/widget/custom_widget.dart';
import 'package:EpiChat/lib.dart' as lib;
import 'package:EpiChat/api/intra.dart' as intra;
import 'package:cloud_firestore/cloud_firestore.dart';

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

  void _initUserInfos() async {
    var login = await lib.getStringFromSharedPref('autologin');
    var mail = await lib.getStringFromSharedPref('email');
    var usrname = await lib.getStringFromSharedPref('username');
    print('Debug initUserInfos() (in profile_infos.dart):\n$mail\n$login');

    FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: "${mail.toString()}")
        .get()
        .then((value) {
      setState(() {
        nameSnapshot = value;
      });
    });
    setState(() {
      epitechMail = mail;
      autologin = login;
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
            radius: MediaQuery.of(context).size.width * (0.15),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "$name",
            style: TextStyle(
              color: Theme.of(context).accentColor,
              fontSize: 17,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "$infos",
            style: TextStyle(
              color: Colors.grey[500].withOpacity(0.6),
              fontSize: 12,
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
          ),
        ),
        Text("$label"),
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
                  await lib.setBoolValue('isEpitech', false);
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('questions', (route) => false);
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
                              if (snapshot.data == null ||
                                  nameSnapshot == null) {
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
                                          "${nameSnapshot.docs[0].data()["username"]}",
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
                        label: "Notes par modules",
                        ico: Icons.notes,
                      ),
                      CustomOptionButton(
                        label: "Projets actuels",
                        ico: Icons.work,
                      ),
                      CustomOptionButton(
                        label: "Partenaires",
                        ico: Icons.people,
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
