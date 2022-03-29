import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webpage extends StatelessWidget{
  final String url;

  Webpage(this.url);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:WebView(
          initialUrl: url,
        ),
    );
  }
}