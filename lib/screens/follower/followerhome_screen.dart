import 'package:exm_p/screens/follower/followeraccount_screen.dart';
import 'package:exm_p/screens/follower/instagramfollower_screen.dart';
import 'package:exm_p/screens/follower/redditfollower_screen.dart';
import 'package:exm_p/screens/follower/twitterfollower_screen.dart';
import 'package:exm_p/screens/follower/youtubefollower_screen.dart';
import 'package:flutter/material.dart';

class FollowerHomeScreen extends StatefulWidget{
  const FollowerHomeScreen({super.key});

  static String id = "followerhome_screen";

  @override
  State<FollowerHomeScreen> createState() => _FollowerHomeScreen();
}

class _FollowerHomeScreen extends State<FollowerHomeScreen>{
  int currentPageIndex = 0;

  late BuildContext mainCtx;

  void onChangedDestination(int index){
    setState(() {
      currentPageIndex = index;
    });
  }

  void onCreatorChanged(int index){
    ScaffoldMessenger.of(mainCtx).showSnackBar(
      SnackBar(content: Text("Creator ${index} selected"))
    );
  }

  @override
  Widget build(BuildContext context){
    mainCtx = context;
    return Scaffold(
      appBar: AppBar(title: Text("Content App"),),
      drawer: Drawer(
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
                    title: Text('Creator ${index+1}'),
                    onTap: () => onCreatorChanged(index+1),
                  );
                }
              ),
            )
          ],
        )
        /* ListView.builder(
                itemCount: 8,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Text('Creator ${index+1}'),
                  );
                }
              ) */
         /* Column(
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue
              ),
              child: Text("Creators")
            ),
            Container(
              height: 500,
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    title: Text('Creator ${index+1}'),
                  );
                }
              )
            )
          ],
        ) */ 
      ),
      bottomNavigationBar: NavigationBar(
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints){
            double w = constraints.maxWidth;
            return Container(
              child: Center(
                child: <Widget>[
                    YoutubeFollowerScreen(),
                    InstagramFollowerScreen(),
                    TwitterFollowerScreen(),
                    RedditFollowerScreen(),
                    FollowerAccountScreen()
                  ][currentPageIndex],
              )
            );
          }
        )
      )
    );
  }
}