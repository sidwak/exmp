import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

final GlobalKey<_InstagramCreatorScreen> igGlobalKey = GlobalKey<_InstagramCreatorScreen>();

class InstagramCreatorScreen extends StatefulWidget{
  const InstagramCreatorScreen({super.key});

  @override
  State<InstagramCreatorScreen> createState() => _InstagramCreatorScreen();
}

String instamgramMainUrl = "https://www.instagram.com/linustech/";

class _InstagramCreatorScreen extends State<InstagramCreatorScreen>{

  WebViewController wvCntrl = WebViewController();

  @override
  Widget build(BuildContext context){
    wvCntrl = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.red)
    ..loadRequest(Uri.parse(instamgramMainUrl));

    return Scaffold(
      body: WebViewWidget(
        controller: wvCntrl,
      )
    );
  }

}