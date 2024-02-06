import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final GlobalKey<_TwitterCreatorScreen> twGlobalKey = GlobalKey<_TwitterCreatorScreen>();

class TwitterCreatorScreen extends StatefulWidget{
  const TwitterCreatorScreen ({super.key});

  void setUrl(String toSet){
    twitterMainUrl = toSet;
  }

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

  void goBack () async {
    debugPrint("backbuttoncalled");
    if (await wvCntrl.canGoBack()) {
      await wvCntrl.goBack();
    } 
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("No back history item")),
      );
      return;
    }
  }

  void goForward () async {
    if (await wvCntrl.canGoForward()) {
      await wvCntrl.goForward();
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("No forward history item")),
      );
      return;
    }
  }
}