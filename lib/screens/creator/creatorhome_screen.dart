import 'package:exm_p/datamain.dart';
import 'package:exm_p/screens/creator/creatoraccount_screen.dart';
import 'package:exm_p/screens/creator/instagramcreator_screen.dart';
import 'package:exm_p/screens/creator/redditcreator_screen.dart';
import 'package:exm_p/screens/creator/twittercreator_screen.dart';
import 'package:flutter/material.dart';
import 'package:exm_p/screens/creator/youtubecreator_screen.dart';


class CreatorHomeScreen extends StatefulWidget{
  const CreatorHomeScreen({super.key});

  static String id = "creatorhome_screen";

  @override
  State<CreatorHomeScreen> createState() => _CreatorHomeScreen();
}

class _CreatorHomeScreen extends State<CreatorHomeScreen>{
  int currentPageIndex = 0;

  YoutubeCreatorScreen ytCreatorScreen = YoutubeCreatorScreen(key: globalKey);
  InstagramCreatorScreen igCreatorScreen = InstagramCreatorScreen(key: igGlobalKey,);
  TwitterCreatorScreen twCreatorScreen = TwitterCreatorScreen(key: twGlobalKey);
  RedditCreatorScreen rdCreatorScreen = RedditCreatorScreen(key: rdGlobalKey,);
  CreatorAccountScreen accountScreen = CreatorAccountScreen();
  //Widget ytScreenWidget = YoutubeCreatorScreen(key: globalKey);
 
  void onChangedDestination(int index){
    setState(() {
      currentPageIndex = index;
    });
  }

  final Future<Map<String, dynamic>> linksData = Future<Map<String, dynamic>>(
    () async => await DataMain().getCreatorData(),
  );

  @override
  Widget build(BuildContext context){  
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onHorizontalDragEnd: (details){
          double sensitivity = 8;
          if (details.primaryVelocity! > sensitivity) {
              debugPrint("swiperight");
              if (globalKey.currentState == null){
                //debugPrint("currentstateisnull");
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("currentstateisnull")));
              }
              else {
                if (currentPageIndex == 0){globalKey.currentState?.goBack();}
                else if(currentPageIndex == 1){igGlobalKey.currentState?.goBack();}
                else if (currentPageIndex == 2){twGlobalKey.currentState?.goBack();}
                else if (currentPageIndex == 3){rdGlobalKey.currentState?.goBack();}
              }
          } else if(details.primaryVelocity! < -sensitivity){
              debugPrint("swipeleft");
              if (globalKey.currentState == null){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("currentstateisnull")));
              }
              else {
                if (currentPageIndex == 0){globalKey.currentState?.goForward();}
                else if(currentPageIndex == 1){igGlobalKey.currentState?.goForward();}
                else if (currentPageIndex == 2){twGlobalKey.currentState?.goForward();}
                else if (currentPageIndex == 3){rdGlobalKey.currentState?.goForward();}
              }
          }
        },
        child: NavigationBar(
          onDestinationSelected: (int index){
            setState(() {
              currentPageIndex = index;
              //debugPrint(currentPageIndex.toString());
            });
          },
          height: 50,
          indicatorColor: Colors.amber,
          selectedIndex: currentPageIndex,
          destinations: <Widget>[
            GestureDetector(
              onTap: ()=>onChangedDestination(0),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.video_file),
                  Text("Youtube")
                ],
              ),
            ), 
            GestureDetector(
              onTap: ()=>onChangedDestination(1),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.photo),
                  Text("Instagram")
                ],
              ),
            ), 
            GestureDetector(
              onTap: ()=>onChangedDestination(2),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.notifications),
                  Text("Twitter")
                ],
              ),
            ),
            GestureDetector(
              onTap: ()=>onChangedDestination(3),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.reddit),
                  Text("Reddit")
                ],
              ),
            ),
            GestureDetector(
              onTap: ()=>onChangedDestination(4),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.verified_user),
                  Text("Account")
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.greenAccent,
        alignment: Alignment.center,
        child: FutureBuilder<Map<String, dynamic>>(
          future: linksData,
          builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            Widget children;
            if (snapshot.hasData){
              debugPrint("ddb snapshot ${snapshot.data}");
              ytCreatorScreen.setUrl(snapshot.data?["yt_link"]);
              igCreatorScreen.setUrl(snapshot.data?["insta_link"]);
              twCreatorScreen.setUrl(snapshot.data?["twi_link"]);
              rdCreatorScreen.setUrl(snapshot.data?["red_link"]);
              children = LayoutBuilder(
                builder: (BuildContext ctx, BoxConstraints constraints){
                  return Center(
                    child: IndexedStack(
                      index: currentPageIndex,
                      children: <Widget>[
                        ytCreatorScreen,
                        igCreatorScreen,
                        twCreatorScreen,
                        rdCreatorScreen,
                        accountScreen
                      ],
                    )
                  );
                },
              );
            }
            else {
              children = const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                        SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Loading...'),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: children,
            );
          },
        )
      )
    );
  }
}