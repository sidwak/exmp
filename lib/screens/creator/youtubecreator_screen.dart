import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final GlobalKey<_YoutubeCreatorScreen> globalKey = GlobalKey<_YoutubeCreatorScreen>();

class YoutubeCreatorScreen extends StatefulWidget{
  
  const YoutubeCreatorScreen({super.key});

  @override
  State<YoutubeCreatorScreen> createState() => _YoutubeCreatorScreen();
}

String youtubeMainUrl = "https://www.youtube.com/user/linustechtips";

class _YoutubeCreatorScreen extends State<YoutubeCreatorScreen>{

  WebViewController wvCntrl = WebViewController();

  BuildContext? mainCtx;

  @override
  Widget build(BuildContext context){
    wvCntrl = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.red)
    ..loadRequest(Uri.parse(youtubeMainUrl));

    mainCtx = context;
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