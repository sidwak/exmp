import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

GlobalKey<_RedditFollowerScreen> rdFoGlobalKey = GlobalKey<_RedditFollowerScreen>();

class RedditFollowerScreen extends StatefulWidget{
  const RedditFollowerScreen({super.key});

  static String id = "instagramfollower_screen";

  @override
  State<RedditFollowerScreen> createState() => _RedditFollowerScreen();
}

String mainUrl = "https://www.reddit.com/r/LinusTechTips/";

class _RedditFollowerScreen extends State<RedditFollowerScreen>{

  void setLinkAndReload(String newLink){
    setState(() {
      mainUrl = newLink;
    });
  }

  WebViewController wvCntrl = WebViewController();

  @override
  Widget build(BuildContext context){
    wvCntrl = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.black)
    ..loadRequest(Uri.parse(mainUrl));
    return Scaffold(
      body: Container(
        width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          child: LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints constraints){
              double w = constraints.maxWidth;
              return WebViewWidget(
                controller: wvCntrl,
              );
            },
          )
      ),
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