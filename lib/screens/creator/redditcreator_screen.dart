import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final GlobalKey<_RedditCreatorScreen> rdGlobalKey = GlobalKey<_RedditCreatorScreen>();

class RedditCreatorScreen extends StatefulWidget{
  const RedditCreatorScreen({super.key});

  void setUrl(String toSet){
    redditMainUrl = toSet;
  }

  @override
  State<RedditCreatorScreen> createState() => _RedditCreatorScreen();
}

String redditMainUrl = "https://www.reddit.com/r/LinusTechTips/";

class _RedditCreatorScreen extends State<RedditCreatorScreen>{

  void setLinkAndReload(String newLink){
      setState(() {
        redditMainUrl = newLink;
      });
    }

  WebViewController wvCntrl = WebViewController();

  @override
  Widget build(BuildContext context){
    wvCntrl = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.red)
    ..loadRequest(Uri.parse(redditMainUrl));

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