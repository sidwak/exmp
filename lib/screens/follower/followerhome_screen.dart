import 'package:exm_p/datamain.dart';
import 'package:exm_p/screens/follower/followeraccount_screen.dart';
import 'package:exm_p/screens/follower/instagramfollower_screen.dart';
import 'package:exm_p/screens/follower/redditfollower_screen.dart';
import 'package:exm_p/screens/follower/twitterfollower_screen.dart';
import 'package:exm_p/screens/follower/youtubefollower_screen.dart';
import 'package:flutter/material.dart';
//Do not import creator screens because global keys have same name

class FollowerHomeScreen extends StatefulWidget{
  const FollowerHomeScreen({super.key});

  static String id = "followerhome_screen";

  @override
  State<FollowerHomeScreen> createState() => _FollowerHomeScreen();
}

class _FollowerHomeScreen extends State<FollowerHomeScreen>{
  int currentPageIndex = 0;

  late BuildContext mainCtx;

  YoutubeFollowerScreen ytFollowerScreen = YoutubeFollowerScreen(key: ytFoGlobalKey);
  InstagramFollowerScreen igFollowerScreen = InstagramFollowerScreen(key: igFoGlobalKey);
  TwitterFollowerScreen twFollowerScreen = TwitterFollowerScreen(key: twFoGlobalKey);
  RedditFollowerScreen rdFollowerScreen = RedditFollowerScreen(key: rdFoGlobalKey);
  FollowerAccountScreen foAccountScreen = FollowerAccountScreen(key: foAcGlobalKey);

  void onChangedDestination(int index){
    setState(() {
      currentPageIndex = index;
    });
  }

  void onCreatorChanged(String creatorName){
    ScaffoldMessenger.of(mainCtx).showSnackBar(
      SnackBar(content: Text("Creator selected"))
    );
    debugPrint("ddb pulleddata ${DataMain.pulledSearchData}");
    for (Map<String, dynamic> each in DataMain.pulledSearchData){
      if (each["name"] == creatorName){
        debugPrint("ddb create link ${each["yt_link"]}");
        ytFoGlobalKey.currentState?.setLinkAndReload(each["yt_link"]);
        igFoGlobalKey.currentState?.setLinkAndReload(each["insta_link"]);
        twFoGlobalKey.currentState?.setLinkAndReload(each["twi_link"]);
        rdFoGlobalKey.currentState?.setLinkAndReload(each["red_link"]);
        break;
      }
    }
    
  }

  List<dynamic> followedData = [];
  final Future<List<dynamic>> fodData = Future<List<dynamic>>(
    () async => await DataMain().getFollowerFoData()
  );

  @override
  Widget build(BuildContext context){
    mainCtx = context;
    DataMain().getSearchData();
    return Scaffold(
      appBar: AppBar(title: const Text("Tameoto"),),
      drawer: FutureBuilder(
        future: fodData,
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
          Widget children;
          if (snapshot.hasData){
            followedData = snapshot.data!;
            children = Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue
                    ),
                    child: Text("Creators"),
                  ),
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    height: 500,
                    child: ListView.builder(
                      itemCount: followedData.length,
                      itemBuilder: (BuildContext context, int index){
                        final String toField = followedData[index]["name"];
                        return ListTile(
                          title: Text(toField),
                          onTap: () => onCreatorChanged(toField),
                        );
                      }
                    ),
                  )
                ],
              ) 
            );
          }
          else {
            children = Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.blue
                    ),
                    child: Text("Creators"),
                  ),
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    height: 500,
                    child: ListView.builder(
                      itemCount: 20,
                      itemBuilder: (BuildContext context, int index){
                        return ListTile(
                          title: Text('Loading Creator...'),
                          //onTap: () => onCreatorChanged(index+1),
                        );
                      }
                    ),
                  )
                ],
              ) 
            );
          }
          return children;
        }
      ),
      bottomNavigationBar: GestureDetector(
        onHorizontalDragEnd: (details){
          double sensitivity = 8;
          if (details.primaryVelocity! > sensitivity) {
              debugPrint("swiperight");
              if (ytFoGlobalKey.currentState == null){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("currentstateisnull")));
              }
              else {               
                if (currentPageIndex == 0){ytFoGlobalKey.currentState?.goBack();}
                else if(currentPageIndex == 1){igFoGlobalKey.currentState?.goBack();}
                else if (currentPageIndex == 2){twFoGlobalKey.currentState?.goBack();}
                else if (currentPageIndex == 3){rdFoGlobalKey.currentState?.goBack();}
              }
          } else if(details.primaryVelocity! < -sensitivity){
              debugPrint("swipeleft");
              if (ytFoGlobalKey.currentState == null){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("currentstateisnull")));
              }
              else {
                if (currentPageIndex == 0){ytFoGlobalKey.currentState?.goForward();}
                else if(currentPageIndex == 1){igFoGlobalKey.currentState?.goForward();}
                else if (currentPageIndex == 2){twFoGlobalKey.currentState?.goForward();}
                else if (currentPageIndex == 3){rdFoGlobalKey.currentState?.goForward();}
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
              onTap: ()=> onChangedDestination(0),
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
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints){
            double w = constraints.maxWidth;
            return Center(
              child: IndexedStack(
                index: currentPageIndex,
                children: <Widget>[
                    ytFollowerScreen,
                    igFollowerScreen,
                    twFollowerScreen,
                    rdFollowerScreen,
                    foAccountScreen
                  ],
              )
            );
          }
        )
      )
    );
  }
}