import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final GlobalKey<_InstagramCreatorScreen> igGlobalKey = GlobalKey<_InstagramCreatorScreen>();

class InstagramCreatorScreen extends StatefulWidget{
  const InstagramCreatorScreen({super.key});

  void setUrl(String toSet){
    instamgramMainUrl = toSet;
  }

  @override
  State<InstagramCreatorScreen> createState() => _InstagramCreatorScreen();
}

String instamgramMainUrl = "https://www.instagram.com/Instagram/";
Uri mainIgUri = Uri.parse(instamgramMainUrl);

class _InstagramCreatorScreen extends State<InstagramCreatorScreen>{

  void setLinkAndReload(String newLink){
    setState(() {
      instamgramMainUrl = newLink;
      Uri parseUrl;
      try {
        parseUrl = Uri.parse(instamgramMainUrl);
      }
      on Exception catch (e) {
        parseUrl = Uri.parse("https://www.instagram.com/Instagram/");
      }
      try {
        mainIgUri = parseUrl;
        wvCntrl.loadRequest(parseUrl);
      }
      on ArgumentError catch (e) {
        wvCntrl.loadRequest(Uri.parse("https://www.instagram.com/Instagram/"));
        mainIgUri = Uri.parse("https://www.instagram.com/Instagram/");
      }
    });
  }

  WebViewController wvCntrl = WebViewController();

  @override
  Widget build(BuildContext context){

    wvCntrl = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.red)
    ..loadRequest(mainIgUri);


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