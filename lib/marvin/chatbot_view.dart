import 'package:flutter/material.dart';
import 'package:EpiChat/api/dialogflow/dialogflow_v2.dart';
import 'package:EpiChat/widget/custom_widget.dart';
import 'package:line_icons/line_icons.dart';
import 'package:EpiChat/marvin/sms.dart';

class NaoAppBar extends StatelessWidget {
  final bool isEpitech;

  NaoAppBar({this.isEpitech});

  @override
  Widget build(BuildContext context) {
    return (CustomAppBar(
      compenants: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * (0.001)),
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  isEpitech ? 'home' : 'home2',
                  (Route<dynamic> route) => false),
              icon: Icon(
                LineIcons.chevron_circle_left,
                size: MediaQuery.of(context).size.height * (0.05),
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(),
        ),
        Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * (0.19)),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Nao Marvin Jr",
                style: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 20,
                  color: Theme.of(context).accentColor,
                ),
              ),
            )),
        Expanded(
          child: SizedBox(),
        ),
      ],
    ));
  }
}

class ChatBot extends StatefulWidget {
  ChatBot({Key key, this.isEpitech}) : super(key: key);
  final bool isEpitech;
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final TextEditingController _controller = TextEditingController();
  List<Widget> messageList = [
    Sms('bot', "Je te suis à vos préoccupations sur Epitech 👽!"),
  ];

  Future<void> agentResponse(query) async {
    _controller.clear();
    AuthGoogle authGoogle = await AuthGoogle(
            fileJson: "assets/json/naomarvinjr-kf9q-57c489811c16.json")
        .build();
    Dialogflow dialogFlow =
        Dialogflow(authGoogle: authGoogle, language: Language.french);
    AIResponse response = await dialogFlow.detectIntent(query);
    Sms message = Sms(
        'bot',
        response.getMessage() ??
            CardDialogflow(response.getListMessage()[0]).title);
    setState(() {
      messageList.insert(0, message);
    });
  }

  Future<void> _sendingTexto(String texto) async {
    Sms usrSms = Sms('user', texto);

    setState(() {
      if (_controller.text == 'kClear')
        messageList.clear();
      else
        messageList.insert(0, usrSms);
    });
    agentResponse(texto.isEmpty ? "Reessayer svp !" : texto);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: NaoAppBar(isEpitech: widget.isEpitech),
      ),
      body: Column(
        children: [
          Flexible(
              child: ListView.builder(
            padding: EdgeInsets.all(8.0),
            reverse: true, //To keep the latest messages at the bottom
            itemBuilder: (_, int index) => messageList[index],
            itemCount: messageList.length,
          )),
          Card(
            margin: EdgeInsets.all(10),
            color: Colors.grey[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            child: Row(
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _controller,
                      decoration:
                          InputDecoration.collapsed(hintText: "Ecrivez ici !"),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Theme.of(context).accentColor),
                  onPressed: () => _sendingTexto(_controller.text),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
