import 'package:exm_p/screens/creator/creatorlogin_screen.dart';
import 'package:exm_p/screens/follower/followerlogin_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        width: double.infinity,
        height: double.infinity,  
        child: LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints){
            double w = constraints.maxWidth;
            double h = constraints.maxHeight;
            return Container(
              //margin: EdgeInsets.only(top: h * 0.25),
              alignment: Alignment.center,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container (
                      width: w * 0.60,
                      //color: Theme.of(context).colorScheme.inversePrimary,
                      height: w * 0.60,
                      child: Center(
                        child: Image.asset("assets/Images/twitch_logo.png")
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Text("Welcome,", 
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).colorScheme.inversePrimary
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 0),
                      child: Text("Login/Signup as", 
                        style: GoogleFonts.nunito(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).colorScheme.inversePrimary
                        ),
                      ),
                    ),
                    Container(
                      //color: Colors.amberAccent,
                      width: w * 0.45,
                      height: w * 0.45,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 12, right: 12, top: 18, bottom:9),
                              //padding: const EdgeInsets.only(top: 10, bottom: 5),
                              //padding: const EdgeInsets.only(top: 6),
                              //color: Colors.red,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, CreatorLoginScreen.id);
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.primary)
                                ),
                                child: Text(
                                  "Creator",
                                  style: GoogleFonts.nunito(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
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
                              //color: Colors.green,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: (){
                                  Navigator.pushNamed(context, FollowerLoginScreen.id);
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.primary)
                                ),
                                child: Text("Follower",
                                  style: GoogleFonts.nunito(
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold,
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
              )
            );
          }
        ),
      )
    );
  }
}