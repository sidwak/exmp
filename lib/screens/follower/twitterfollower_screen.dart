import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TwitterFollowerScreen extends StatefulWidget{
  const TwitterFollowerScreen({super.key});

  static String id = "instagramfollower_screen";

  @override
  State<TwitterFollowerScreen> createState() => _TwitterFollowerScreen();
}

const String mainUrl = "https://twitter.com/LinusTech";

class _TwitterFollowerScreen extends State<TwitterFollowerScreen>{

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