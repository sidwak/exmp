import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final GlobalKey<_RedditCreatorScreen> rdGlobalKey = GlobalKey<_RedditCreatorScreen>();

class RedditCreatorScreen extends StatefulWidget{
  const RedditCreatorScreen({super.key});

  @override
  State<RedditCreatorScreen> createState() => _RedditCreatorScreen();
}

String redditMainUrl = "https://www.reddit.com/r/LinusTechTips/";

class _RedditCreatorScreen extends State<RedditCreatorScreen>{
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
}