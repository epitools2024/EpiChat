import 'package:flutter/material.dart';
import 'package:EpiChat/marvin/chatbot_view.dart';

class MarvinJr extends StatefulWidget {
  MarvinJr({Key key, this.isEpitech}) : super(key: key);
  bool isEpitech;
  @override
  _MarvinJrState createState() => _MarvinJrState();
}

class _MarvinJrState extends State<MarvinJr> {
  @override
  Widget build(BuildContext context) {
    return (SingleChildScrollView(
        child: Center(
            child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * (0.1),
                    ),
                    Image.asset(
                      'assets/png/cute_bot.gif',
                      scale: 3,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Bonjour à toi.\nJe suis Nao Marvin Jr.\n',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.height * (0.029),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChatBot(isEpitech: widget.isEpitech))),
                        focusColor: Colors.white,
                        color: Theme.of(context).accentColor,
                        child: Container(
                            child: Text('Commençons !',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                )))),
                  ],
                )))));
  }
}
