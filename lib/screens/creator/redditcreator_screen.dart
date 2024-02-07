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

String redditMainUrl = "https://www.reddit.com/";
Uri mainRdUri = Uri.parse(redditMainUrl);

class _RedditCreatorScreen extends State<RedditCreatorScreen>{

  void setLinkAndReload(String newLink){
    setState(() {
      redditMainUrl = newLink;
      Uri parseUrl;
      try {
        parseUrl = Uri.parse(redditMainUrl);
      }
      on Exception catch (e) {
        parseUrl = Uri.parse("https://www.reddit.com/");
      }
      try {
        mainRdUri = parseUrl;
        wvCntrl.loadRequest(parseUrl);
      }
      on ArgumentError catch (e) {
        wvCntrl.loadRequest(Uri.parse("https://www.reddit.com/"));
        mainRdUri = Uri.parse("https://www.reddit.com/");
      }
    });
  }

  WebViewController wvCntrl = WebViewController();

  @override
  Widget build(BuildContext context){

    wvCntrl = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.red)
    ..loadRequest(mainRdUri);

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