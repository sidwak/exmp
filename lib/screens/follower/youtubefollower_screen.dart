import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YoutubeFollowerScreen extends StatefulWidget{
  const YoutubeFollowerScreen({super.key});

  static String id = "youtubefollower_screen";

  @override
  State<YoutubeFollowerScreen> createState() => _YoutubeFollowerScreen();
}

const String mainUrl = "https://www.youtube.com/user/linustechtips";

class _YoutubeFollowerScreen extends State<YoutubeFollowerScreen>{

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