import 'package:exm_p/datamain.dart';
import 'package:exm_p/screens/follower/followeraccount_screen.dart';
import 'package:exm_p/screens/follower/instagramfollower_screen.dart';
import 'package:exm_p/screens/follower/redditfollower_screen.dart';
import 'package:exm_p/screens/follower/twitterfollower_screen.dart';
import 'package:exm_p/screens/follower/youtubefollower_screen.dart';
import 'package:exm_p/screens/main/mainlogin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut().then(
      (res){
        Navigator.pushReplacementNamed(context, MainLoginScreen.id);
      }
    );
  }

  var scafKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context){
    mainCtx = context;
    DataMain().getSearchData();
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: scafKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            child:Image.asset("assets/Images/twitch_logo.png"),
            onTap: (){
              scafKey.currentState?.openDrawer();
            },
          ),
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
        drawer: FutureBuilder(
          future: fodData,
          builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot){
            Widget children;
            if (snapshot.hasData){
              debugPrint("ddb ${snapshot.data}");
              followedData = snapshot.data!;
              children = Drawer(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    DrawerHeader(
                      margin: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                        "Following",
                        style: GoogleFonts.nunito(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary
                        ),
                      )
                      ),
                    ),
                    Container(
                      //color: Theme.of(context).colorScheme.background,
                      padding: EdgeInsets.zero,
                      margin: const EdgeInsets.only(top: 3),
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: followedData.length,
                        itemBuilder: (BuildContext context, int index){
                          final String toField = followedData[index]["name"];
                          return Container( 
                            margin: const EdgeInsets.fromLTRB(6, 3, 6, 3),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Colors.black,
                            ),
                            child: ListTile(
                              leading: const Icon(Icons.person),
                              title: Text(toField, 
                                style: GoogleFonts.nunito(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Theme.of(context).colorScheme.inversePrimary
                                ),
                              ),
                              onTap: () => onCreatorChanged(toField),
                              //tileColor: Colors.black,
                            )
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
                      height: double.maxFinite,
                      child: ListView.builder(
                        itemCount: 20,
                        itemBuilder: (BuildContext context, int index){
                          return const ListTile(
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
            backgroundColor: Theme.of(context).colorScheme.primary,
            destinations: <Widget>[
              GestureDetector(
                onTap: ()=> onChangedDestination(0),
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
          alignment: Alignment.center,
          child: LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints constraints){
              double w = constraints.maxWidth;
              double h = constraints.maxHeight;
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
      )
    );
  }
}