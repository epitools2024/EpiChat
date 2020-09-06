import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewLoad extends StatefulWidget {
  final String title;
  final String url;
  WebViewLoad({@required this.url, this.title});
  WebViewLoadUI createState() => WebViewLoadUI();
}

class WebViewLoadUI extends State<WebViewLoad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Expanded(
                  child: SizedBox(),
                ),
                Center(
                  child: Text(
                    "${widget.title}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            )),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}

class CustomCenteredRow extends StatelessWidget {
  final List<Widget> children;

  CustomCenteredRow({@required this.children});

  @override
  Widget build(BuildContext context) {
    return (Row(
      children: [
        Expanded(
          child: SizedBox(),
        ),
        Row(
          children: children,
        ),
        Expanded(
          child: SizedBox(),
        ),
      ],
    ));
  }
}

class CustomCenteredColumn extends StatelessWidget {
  final List<Widget> children;

  CustomCenteredColumn({@required this.children});

  @override
  Widget build(BuildContext context) {
    return (Column(
      children: [
        Expanded(
          child: SizedBox(),
        ),
        Column(
          children: children,
        ),
        Expanded(
          child: SizedBox(),
        ),
      ],
    ));
  }
}

class CustomAppBar extends StatelessWidget {
  CustomAppBar({Key key, @required this.compenants}) : super(key: key);
  final List<Widget> compenants;

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey[500],
          spreadRadius: 1,
          blurRadius: 1,
        )
      ]),
      child: SafeArea(
        child: Row(
          children: this.compenants,
        ),
      ),
    );
  }
}

class CustomOptionButton extends StatelessWidget {
  final Function func;
  final String label;
  final IconData ico;
  CustomOptionButton({this.label, this.func, this.ico});

  @override
  Widget build(BuildContext context) {
    return (GestureDetector(
        onTap: func,
        child: Padding(
            padding: EdgeInsets.all(3),
            child: Container(
              height: MediaQuery.of(context).size.height * (0.065),
              width: MediaQuery.of(context).size.width * (0.95),
              child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 1,
                  ),
                  child: Row(children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * (0.03),
                    ),
                    Icon(this.ico),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * (0.05),
                    ),
                    Text(this.label,
                        style: TextStyle(
                          fontSize: 17,
                          color: Theme.of(context).accentColor,
                        ))
                  ])),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 0.01,
                      color: Colors.grey[350],
                    )
                  ]),
            ))));
  }
}
