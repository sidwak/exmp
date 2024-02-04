import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RedditFollowerScreen extends StatefulWidget{
  const RedditFollowerScreen({super.key});

  static String id = "instagramfollower_screen";

  @override
  State<RedditFollowerScreen> createState() => _RedditFollowerScreen();
}

const String mainUrl = "https://www.reddit.com/r/LinusTechTips/";

class _RedditFollowerScreen extends State<RedditFollowerScreen>{

  final WebViewController wvCntrl = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..setBackgroundColor(Colors.red)
  ..loadRequest(Uri.parse(mainUrl));

  @override
  Widget build(BuildContext context){
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
}