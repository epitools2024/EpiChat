
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as URLLauncher;
import 'package:EpiChat/lib.dart' as lib;
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _autologin = TextEditingController();
  final _globalForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autoValidate = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _lauchURL(String url) async {
    url = Uri.encodeFull(url);
    if (await URLLauncher.canLaunch(url))
      await URLLauncher.launch(url);
    else
      throw 'Could not launch $url';
  }

  _checkMail(String mail) {
    if (mail.isEmpty) {
      return "Ne doit pas être vide !";
    } else if (mail.split("@").length != 2) {
      return "prenon.nom@epitech.eu";
    } else if (mail.split("@").elementAt(1) != "epitech.eu") {
      return "prenon.nom@epitech.eu";
    } else if (mail.split('.').length != 3) {
      return "prenon.nom@epitech.eu";
    } else {
      return null;
    }
  }

  _checkAutologin(String autolink) {
    if (!(autolink.contains('-') && autolink.contains('https:')))
      return "https://intra.epitech.eu/auth-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
    else if (autolink.split('-').length != 2) {
      return "https://intra.epitech.eu/auth-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
    } else if (autolink.split('-').elementAt(0) !=
        "https://intra.epitech.eu/auth") {
      return "https://intra.epitech.eu/auth-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
    } else {
      return null;
    }
  }

  _submitForm(BuildContext context) async {
    final form = _globalForm.currentState;
    var response = await http
        .get(Uri.encodeFull('${_autologin.text}/user/${_email.text}/'));

    if (!form.validate() || response.statusCode != 200) {
      _autoValidate = true;
      _showDialog(context,
          "Il semble que soit votre email n'est pas valide soit que vous l'avez mal écrit !");
    } else {
      lib.setStringValue('autologin', _autologin.text);
      lib.setStringValue('email', _email.text);
      lib.setBoolValue('isEpitech', true);
      _showDialog(context, "Super 💙! Tout a été enregistré !");
      Navigator.of(context).popAndPushNamed("home");
    }
  }

  _showDialog(BuildContext context, String msg) {
    final snackBar = SnackBar(content: Text(msg));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    var containerHeight = MediaQuery.of(context).size.height * (0.8);
    var containerWidth = MediaQuery.of(context).size.width * (0.9);

    return (Scaffold(
        key: _scaffoldKey,
        body: Stack(children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).accentColor,
                    Colors.blue[300],
                  ]),
              color: Theme.of(context).accentColor,
            ),
          ),
          Align(
              child: SingleChildScrollView(
            child: Align(
                child: Container(
              height: containerHeight,
              width: containerWidth,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 2,
                      color: Colors.grey[500],
                    )
                  ]),
              child: Column(
                children: [
                  SizedBox(
                    height: containerHeight * (0.2),
                  ),
                  Image.asset(
                    'assets/png/EPITECH.png',
                    scale: MediaQuery.of(context).size.width * (0.012),
                  ),
                  SizedBox(
                    height: containerHeight * (0.1),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                          key: _globalForm,
                          autovalidate: _autoValidate,
                          child: Column(
                            children: [
                              Material(
                                child: TextFormField(
                                  controller: _email,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    icon: Icon(Icons.mail,
                                        color: Theme.of(context).accentColor),
                                    labelText: '{E}mail*',
                                    hintText:
                                        'Entrez votre email ici Epitech ici !',
                                  ),
                                  validator: (value) => _checkMail(value),
                                ),
                              ),
                              SizedBox(
                                height: containerHeight * (0.05),
                              ),
                              Material(
                                  child: TextFormField(
                                controller: _autologin,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  filled: true,
                                  icon: Icon(Icons.data_usage,
                                      color: Theme.of(context).accentColor),
                                  labelText: 'Autologin*',
                                  hintText: 'Entrez votre autologin ici !',
                                ),
                                validator: (value) => _checkAutologin(value),
                              )),
                              SizedBox(
                                height: containerHeight * (0.05),
                              ),
                              Align(
                                child: GestureDetector(
                                  onTap: () {
                                    _lauchURL(
                                        'https://intra.epitech.eu/admin/autolog');
                                  },
                                  child: Text(
                                    "Tu peux avoir ton autolink ici !",
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: containerHeight * (0.04),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  _submitForm(context);
                                },
                                focusColor: Colors.white,
                                color: Theme.of(context).accentColor,
                                child: Text('Envoyer ',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          )))
                ],
              ),
            )),
          ))
        ])));
  }
}
