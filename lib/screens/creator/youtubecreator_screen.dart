import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final GlobalKey<_YoutubeCreatorScreen> globalKey = GlobalKey<_YoutubeCreatorScreen>();

class YoutubeCreatorScreen extends StatefulWidget{

  const YoutubeCreatorScreen({super.key});


  void setUrl(String toSet){
    youtubeMainUrl = toSet;
  }

  @override
  State<YoutubeCreatorScreen> createState() => _YoutubeCreatorScreen();
}

String youtubeMainUrl = "https://www.youtube.com";
Uri mainYtUri = Uri.parse(youtubeMainUrl);

class _YoutubeCreatorScreen extends State<YoutubeCreatorScreen>{

  void setLinkAndReload(String newLink){
    setState(() {
      youtubeMainUrl = newLink;
      Uri parseUrl;
      try {
        parseUrl = Uri.parse(youtubeMainUrl);
      }
      on Exception catch (e) {
        parseUrl = Uri.parse("https://www.youtube.com");
      }
      try {
        mainYtUri = parseUrl;
        wvCntrl.loadRequest(parseUrl);
      }
      on ArgumentError catch (e) {
        wvCntrl.loadRequest(Uri.parse("https://www.youtube.com"));
        mainYtUri = Uri.parse("https://www.youtube.com");
      }
    });
  }

  WebViewController wvCntrl = WebViewController();

  BuildContext? mainCtx;

  @override
  Widget build(BuildContext context){   

    wvCntrl = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.red)
    ..loadRequest(mainYtUri);

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