import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final GlobalKey<_TwitterFollowerScreen> twFoGlobalKey = GlobalKey<_TwitterFollowerScreen>();

class TwitterFollowerScreen extends StatefulWidget{
  const TwitterFollowerScreen({super.key});

  static String id = "instagramfollower_screen";

  @override
  State<TwitterFollowerScreen> createState() => _TwitterFollowerScreen();
}

const String mainUrl = "https://twitter.com/LinusTech";

class _TwitterFollowerScreen extends State<TwitterFollowerScreen>{

  WebViewController wvCntrl = WebViewController();

  @override
  Widget build(BuildContext context){
    wvCntrl = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.red)
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