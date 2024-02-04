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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("ddb initcalled");
    initLinks();
  }

  Future<void> initLinks() async {
    if (await DataMain().getCreatorLinks()){
      debugPrint("ddb geeting links");
      DataMain().getCreatorData();
      Map<String, dynamic> getData = DataMain().ret;
      youtubeMainUrl = "https://www.youtube.com/user/linustechtips";
      instamgramMainUrl = "https://www.instagram.com/linustech/";
      twitterMainUrl = "https://twitter.com/LinusTech";
      redditMainUrl = "https://www.reddit.com/r/LinusTechTips/";
      globalKey.currentState?.setState(() {});
      igGlobalKey.currentState?.setState(() {});
      twGlobalKey.currentState?.setState(() {});
      rdGlobalKey.currentState?.setState(() {});
      setState(() {
        //ytCreatorScreen = YoutubeCreatorScreen(key: globalKey);
        
      });
    }
    else {
      debugPrint("ddb not getting links");
      youtubeMainUrl = "https://www.youtube.com";
      instamgramMainUrl = "https://www.instagram.com/Instagram/";
      twitterMainUrl = "https://twitter.com/x";
      redditMainUrl = "https://www.reddit.com/";
       globalKey.currentState?.setState(() {});
      igGlobalKey.currentState?.setState(() {});
      twGlobalKey.currentState?.setState(() {});
      rdGlobalKey.currentState?.setState(() {});
      setState(() {

      });
    }
  }

  void onChangedDestination(int index){
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){  
    debugPrint("ddb first buildling");
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
        child: LayoutBuilder(
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
        ),
      )
    );
  }
}