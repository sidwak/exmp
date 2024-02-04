import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InstagramFollowerScreen extends StatefulWidget{
  const InstagramFollowerScreen({super.key});

  static String id = "instagramfollower_screen";

  @override
  State<InstagramFollowerScreen> createState() => _InstagramFollowerScreen();
}

const String mainUrl = "https://www.instagram.com/linustech/";

class _InstagramFollowerScreen extends State<InstagramFollowerScreen>{

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