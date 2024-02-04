import 'package:exm_p/screens/creator/creatorlogin_screen.dart';
import 'package:exm_p/screens/follower/followerlogin_screen.dart';
import 'package:flutter/material.dart';

class MainLoginScreen extends StatelessWidget {
  const MainLoginScreen({super.key});
  static String id = "mainlogin_screen";

  void onPressedCreatorBtn(){
    
  }
  void onPressedFollowerBtn(){

  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        //padding: const EdgeInsets.only(top: 100),
        margin: const EdgeInsets.only(top: 150),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container (
                color: Theme.of(context).colorScheme.inversePrimary,
                width: 150,
                height: 150,
                child: const Center(
                  child: Text("Logo here"),
                )
              ),
              const Text("Login/Sign Up as", 
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              Container(
                color: Colors.amberAccent,
                width: 150,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 12, right: 12, top: 18, bottom:9),
                        //padding: const EdgeInsets.only(top: 10, bottom: 5),
                        //padding: const EdgeInsets.only(top: 6),
                        color: Colors.red,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushNamed(context, CreatorLoginScreen.id);
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.purpleAccent)
                          ),
                          child: const Text("Creator",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                            ),
                          ),
                        ),
                      )
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 12, right: 12, top: 9, bottom:18),
                        //padding: const EdgeInsets.only(top: 5, bottom: 10),
                        //padding: const EdgeInsets.only(bottom: 6),
                        color: Colors.green,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.pushNamed(context, FollowerLoginScreen.id);
                          },
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(Colors.purpleAccent)
                          ),
                          child: const Text("Follower",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white
                            ),
                          ),
                        ),
                      )
                    )
                  ],
                ) 
              ),
            ],
          ),
        ),
      )
    );
  }
}