import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final GlobalKey<_YoutubeFollowerScreen> ytFoGlobalKey = GlobalKey<_YoutubeFollowerScreen>();

class YoutubeFollowerScreen extends StatefulWidget{
  const YoutubeFollowerScreen({super.key});

  static String id = "youtubefollower_screen";

  @override
  State<YoutubeFollowerScreen> createState() => _YoutubeFollowerScreen();
}

String mainUrl = "https://www.youtube.com/user/linustechtips";

class _YoutubeFollowerScreen extends State<YoutubeFollowerScreen>{

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
        SnackBar(
            content: Text("No back history item"),
            backgroundColor: Colors.blue.shade300,
            elevation: 6.0,
            behavior: SnackBarBehavior.floating,
        ),
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