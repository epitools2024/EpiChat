import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'custom_app_bar.dart';

class WebViewLoad extends StatefulWidget {
  final String? title;
  final String url;
  WebViewLoad({required this.url, this.title});
  WebViewLoadUI createState() => WebViewLoadUI();
}

class WebViewLoadUI extends State<WebViewLoad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: CustomAppBar(
              components: [
                IconButton(
                  icon: Icon(
                    LineIcons.chevronCircleLeft,
                    color: Theme.of(context).accentColor,
                    size: MediaQuery.of(context).size.height * (0.04),
                  ),
                  onPressed: () => Navigator.of(context).pop(context),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * (0.2),
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
              ],
            )),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
