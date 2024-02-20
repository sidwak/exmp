import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

GlobalKey<_TwitterCreatorScreen> twGlobalKey = GlobalKey<_TwitterCreatorScreen>();

class TwitterCreatorScreen extends StatefulWidget{
  const TwitterCreatorScreen ({super.key});

  void setUrl(String toSet){
    twitterMainUrl = toSet;
  }

  @override
  State<TwitterCreatorScreen> createState() => _TwitterCreatorScreen();
}

String twitterMainUrl = "https://twitter.com/x";
Uri mainTwUri = Uri.parse(twitterMainUrl);

class _TwitterCreatorScreen extends State<TwitterCreatorScreen>{
  WebViewController wvCntrl = WebViewController();

  void setLinkAndReload(String newLink){
    setState(() {
      twitterMainUrl = newLink;
      Uri parseUrl;
      try {
        parseUrl = Uri.parse(twitterMainUrl);
      }
      on Exception catch (e) {
        parseUrl = Uri.parse("https://twitter.com/x");
      }
      try {
        mainTwUri = parseUrl;
        wvCntrl.loadRequest(parseUrl);
      }
      on ArgumentError catch (e) {
        wvCntrl.loadRequest(Uri.parse("https://twitter.com/x"));
        mainTwUri = Uri.parse("https://twitter.com/x");
      }
    });
  }

  @override
  Widget build(BuildContext context){

    wvCntrl = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.black)
    ..loadRequest(mainTwUri);
    
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