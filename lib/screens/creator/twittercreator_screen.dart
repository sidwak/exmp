import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final GlobalKey<_TwitterCreatorScreen> twGlobalKey = GlobalKey<_TwitterCreatorScreen>();

class TwitterCreatorScreen extends StatefulWidget{
  const TwitterCreatorScreen ({super.key});

  @override
  State<TwitterCreatorScreen> createState() => _TwitterCreatorScreen();
}

String twitterMainUrl = "https://twitter.com/LinusTech";

class _TwitterCreatorScreen extends State<TwitterCreatorScreen>{
  WebViewController wvCntrl = WebViewController();

  @override
  Widget build(BuildContext context){
    wvCntrl = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.red)
    ..loadRequest(Uri.parse(twitterMainUrl));
    
    return Scaffold(
      body: WebViewWidget(
        controller: wvCntrl,
      )
    );
  }
}