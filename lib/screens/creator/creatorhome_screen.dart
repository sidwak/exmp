import 'package:exm_p/datamain.dart';
import 'package:exm_p/screens/creator/creatoraccount_screen.dart';
import 'package:exm_p/screens/creator/instagramcreator_screen.dart';
import 'package:exm_p/screens/creator/redditcreator_screen.dart';
import 'package:exm_p/screens/creator/twittercreator_screen.dart';
import 'package:exm_p/screens/main/mainlogin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:exm_p/screens/creator/youtubecreator_screen.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class CreatorHomeScreen extends StatefulWidget{
  const CreatorHomeScreen({super.key});

  static String id = "creatorhome_screen";

  @override
  State<CreatorHomeScreen> createState() => _CreatorHomeScreen();
}

class _CreatorHomeScreen extends State<CreatorHomeScreen>{
  int currentPageIndex = 0;

  late BuildContext mainCtx;

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

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut().then(
      (res){
        Navigator.pushReplacementNamed(context, MainLoginScreen.id);
      }
    );  
  }

  @override
  Widget build(BuildContext context){  
    mainCtx = context;
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          automaticallyImplyLeading: false,
          leading: Image.asset("assets/Images/twitch_logo.png"),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black

          ),
          title: Text(
            "Tameoto",
            style: GoogleFonts.nunito(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary
            ),
          ),
          titleSpacing: 0,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                _signOut();
              },
            ),
          ],
        ),
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
            backgroundColor: Theme.of(context).colorScheme.primary,
            destinations: <Widget>[
              GestureDetector(
                onTap: ()=>onChangedDestination(0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[                  
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: currentPageIndex==0 ? BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(7.0))
                      ) : null,
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: Image.asset("assets/Images/ytlogo3.png"),
                      ),
                    )
                  ],
                ),
              ), 
              GestureDetector(
                onTap: ()=>onChangedDestination(1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[                 
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: currentPageIndex==1 ? BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(7.0))
                      ) : null,
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: Image.asset("assets/Images/instalogo3.png"),
                      ),
                    )
                  ],
                ),
              ), 
              GestureDetector(
                onTap: ()=>onChangedDestination(2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: currentPageIndex==2 ? BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(7.0))
                      ) : null,
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: Image.asset("assets/Images/twilogo3.png"),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: ()=>onChangedDestination(3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: currentPageIndex==3 ? BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(7.0))
                      ) : null,
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: Image.asset("assets/Images/redditlogo2.png"),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: ()=>onChangedDestination(4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: currentPageIndex==4 ? BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: const BorderRadius.all(Radius.circular(7.0))
                      ) : null,
                      child: SizedBox(
                        height: 35,
                        width: 35,
                        child: Image.asset("assets/Images/accountlogo2.png"),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black,
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
      )
    );
  }
}