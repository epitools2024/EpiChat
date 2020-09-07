import 'package:EpiChat/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart' as URLLauncher;
import 'package:EpiChat/lib.dart' as lib;
import 'package:http/http.dart' as http;
import 'package:EpiChat/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _autologin = TextEditingController();
  final _globalForm = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _signIn = true;
  bool _autoValidate = false;
  bool _isLoading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential result;
  User user;
  DatabaseMethods data;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _autologin.dispose();
    super.dispose();
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

  Future<void> _lauchURL(String url) async {
    url = Uri.encodeFull(url);
    if (await URLLauncher.canLaunch(url))
      await URLLauncher.launch(url);
    else
      throw 'Could not launch $url';
  }

  void _submitSignInForm(BuildContext context) async {
    final form = _globalForm.currentState;
    http.Response response = await http
        .get(Uri.encodeFull('${_autologin.text}/user/${_email.text}/'));

    if (!form.validate() || response.statusCode != 200) {
      _autoValidate = true;
      lib.showDialog(context, _scaffoldKey,
          "Il semble que soit votre email ou votre autologin ne soit pas valide soit que vous l'avez mal écrit !\nPensez à revoir votre connexion aussi !");
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        result = await auth.signInWithEmailAndPassword(
            email: _email.text, password: _autologin.text);
        user = result.user;
        await lib.setStringValue('firebase_uid', "${user.uid}");
      } on FirebaseAuthException catch (e) {
        print("${e.code}");
      }
      await lib.setStringValue('email', _email.text);
      await lib.setStringValue('autologin', _autologin.text);
      await lib.setBoolValue('isEpitech', true);
      Navigator.of(context).popAndPushNamed("home");
    }
  }

  void _submitSignUpForm(BuildContext context) async {
    final form = _globalForm.currentState;
    http.Response response = await http
        .get(Uri.encodeFull('${_autologin.text}/user/${_email.text}/'));

    if (!form.validate() || response.statusCode != 200) {
      _autoValidate = true;
      lib.showDialog(context, _scaffoldKey,
          "Il semble que soit votre email ou votre autologin ne soit pas valide soit que vous l'avez mal écrit !\nPensez à revoir votre connexion aussi !");
    } else {
      setState(() {
        _isLoading = true;
      });
      try {
        result = await auth.createUserWithEmailAndPassword(
            email: _email.text, password: _autologin.text);
        user = result.user;
        await lib.setStringValue('firebase_uid', "${user.uid}");
      } on FirebaseAuthException catch (e) {
        print("${e.code}");
      }
      Map<String, dynamic> userInfos = {
        'username': _name.text,
        'email': _email.text,
        'bio': "Je suis ${_name.text}."
      };
      await FirebaseFirestore.instance
          .collection('users')
          .doc()
          .set(userInfos)
          .catchError((e) {
        print("$e");
      });
      await lib.setStringValue('username', _name.text);
      await lib.setStringValue('email', _email.text);
      await lib.setStringValue('autologin', _autologin.text);
      await lib.setBoolValue('isEpitech', true);
      Navigator.of(context).popAndPushNamed("home");
    }
  }

  Widget signIn(BuildContext context, double containerHeight) {
    return (Column(
      children: [
        SizedBox(
          height: containerHeight * (0.2),
        ),
        Image.asset(
          'assets/png/EPITECH.png',
          scale: MediaQuery.of(context).size.width * (0.012),
        ),
        SizedBox(
          height: containerHeight * (0.08),
        ),
        Material(
          child: TextFormField(
            controller: _email,
            style: TextStyle(
              fontSize: 15,
            ),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              filled: true,
              icon: Icon(Icons.mail, color: Theme.of(context).accentColor),
              labelText: '{E}mail*',
              hintText: 'Entrez votre email ici Epitech ici !',
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
            icon: Icon(Icons.data_usage, color: Theme.of(context).accentColor),
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
              _lauchURL('https://intra.epitech.eu/admin/autolog');
            },
            child: Text(
              "Tu peux avoir ton autologin ici !",
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
            _submitSignInForm(context);
          },
          focusColor: Colors.white,
          color: Theme.of(context).accentColor,
          child: Text('Se connecter',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              )),
        ),
        SizedBox(
          height: containerHeight * (0.04),
        ),
        Align(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _signIn = false;
              });
            },
            child: Text(
              "Creer un compte EpiChat ?",
              style: TextStyle(
                color: Theme.of(context).accentColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    ));
  }

  Widget signUp(BuildContext context, double containerHeight) {
    return (Column(children: [
      SizedBox(
        height: containerHeight * (0.14),
      ),
      Image.asset(
        'assets/png/EPITECH.png',
        scale: MediaQuery.of(context).size.width * (0.012),
      ),
      SizedBox(
        height: containerHeight * (0.08),
      ),
      Material(
        child: TextFormField(
          controller: _name,
          style: TextStyle(
            fontSize: 15,
          ),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            filled: true,
            icon: Icon(LineIcons.user, color: Theme.of(context).accentColor),
            labelText: 'Nom*',
            hintText: "Entrez votre nom d'utilisateur ici !",
          ),
        ),
      ),
      SizedBox(
        height: containerHeight * (0.025),
      ),
      Material(
        child: TextFormField(
          controller: _email,
          style: TextStyle(
            fontSize: 15,
          ),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            filled: true,
            icon: Icon(Icons.mail, color: Theme.of(context).accentColor),
            labelText: '{E}mail*',
            hintText: 'Entrez votre email ici Epitech ici !',
          ),
          validator: (value) => _checkMail(value),
        ),
      ),
      SizedBox(
        height: containerHeight * (0.025),
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
          icon: Icon(Icons.data_usage, color: Theme.of(context).accentColor),
          labelText: 'Autologin*',
          hintText: 'Entrez votre autologin ici !',
        ),
        validator: (value) => _checkAutologin(value),
      )),
      SizedBox(
        height: containerHeight * (0.03),
      ),
      Align(
        child: GestureDetector(
          onTap: () {
            _lauchURL('https://intra.epitech.eu/admin/autolog');
          },
          child: Text(
            "Tu peux avoir ton autologin ici !",
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
          _submitSignUpForm(context);
        },
        focusColor: Colors.white,
        color: Theme.of(context).accentColor,
        child: Text("S'inscrire",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
      ),
      SizedBox(
        height: containerHeight * (0.02),
      ),
      Align(
        child: GestureDetector(
          onTap: () {
            setState(() {
              _signIn = true;
            });
          },
          child: Text(
            "Connectez vous !",
            style: TextStyle(
              color: Theme.of(context).accentColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ),
    ]));
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
          _isLoading
              ? Align(
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.white))
              : Align(
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
                        Container(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Form(
                                key: _globalForm,
                                autovalidate: _autoValidate,
                                child: Column(
                                  children: [
                                    _signIn
                                        ? signIn(context, containerHeight)
                                        : signUp(context, containerHeight),
                                  ],
                                )))
                      ],
                    ),
                  )),
                ))
        ])));
  }
}
