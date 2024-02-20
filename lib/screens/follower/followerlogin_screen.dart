import 'package:exm_p/datamain.dart';
import 'package:exm_p/screens/follower/followerhome_screen.dart';
import 'package:exm_p/screens/follower/followersignup_screen.dart';
import 'package:exm_p/widgets/snacky.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exm_p/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowerLoginScreen extends StatelessWidget{
  FollowerLoginScreen({super.key});
  static String id = "followerlogin_screen";

  String errorMessage="error";

  late BuildContext mainCtx;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text).then((value){
          ScaffoldMessenger.of(mainCtx).showSnackBar(
            SnackyBar(toSet: "User Singed In")
          );
          DataMain().setNewUser(FirebaseAuth.instance.currentUser!);
          Navigator.pushReplacementNamed(mainCtx, FollowerHomeScreen.id);
        });
      // FirebaseAuth.instance.authStateChanges().listen((User? user) {
      //   if (user != null){
      //     ScaffoldMessenger.of(mainCtx).showSnackBar(
      //       SnackyBar(toSet: "User Singed In")
      //     );
      //     DataMain().setNewUser(user);
      //     Navigator.pushReplacementNamed(mainCtx, FollowerHomeScreen.id);
      //   }
      // }
      //);
    }
    on FirebaseAuthException catch(e) {
      debugPrint(e.message);
      if (e.message != null){errorMessage = e.message!;}   
      ScaffoldMessenger.of(mainCtx).showSnackBar(
        SnackyBar(toSet: errorMessage)
      );
    }
  }

  void loginButtonPressed(){
    // _controllerEmail.text = "sidwak4@gmail.com";
    // _controllerPassword.text = "siddhu";
    signInWithEmailAndPassword();
  }

  @override
  Widget build(BuildContext context){
    mainCtx = context;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints){
            double w = constraints.maxWidth;
            double h = constraints.maxHeight;
            return Container(
              child: Center(              
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container (
                      width: w * 0.6,
                      //color: Theme.of(context).colorScheme.inversePrimary,
                      height: w * 0.6,
                      child: Center(
                        child: Image.asset("assets/Images/twitch_logo.png")
                      )
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Text("Login", 
                          style: GoogleFonts.nunito(
                            fontSize: 21,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.inversePrimary
                          ),
                        ),
                    ),
                    Container (
                      //margin: const EdgeInsets.only(top: 36, bottom: 5, left: 36, right: 36),
                      //padding: const EdgeInsets.only(top: 36, bottom: 5, left: 36, right: 36),
                      height: 45,
                      width: w * 0.60,
                      margin: const EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _controllerEmail,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          labelText: "User ID",
                          contentPadding: EdgeInsets.zero,
                          alignLabelWithHint: true,
                          labelStyle: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.background
                          ),
                          filled: true,
                          prefixIcon: const Icon(Icons.mail),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45.0),
                          )
                        ),
                      ), 
                    ),
                    Container(
                      height: 45,
                      width: w * 0.60,
                      margin: const EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _controllerPassword,
                        obscureText: true,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.zero,
                          labelText: "Password",
                          labelStyle: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.background
                          ),
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45.0)
                          ) 
                        ),
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.only(top:15),
                      width: 110,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, FollowerHomeScreen.id);
                          //signInWithEmailAndPassword();
                          loginButtonPressed();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.primary)
                        ),
                        child: Text("Login", 
                          style: GoogleFonts.nunito(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inversePrimary
                          ),
                        ),
                      )
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, FollowerSignupScreen.id);
                      },
                      child: Container(     
                        //width: 100,
                        //height: 100,
                        //color: Colors.lightBlue,           
                        margin: const EdgeInsets.only(top: 5),        
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.inversePrimary
                          ),
                        ),
                      )
                    ),
                    //Text("Follower")
                  ],
                )
              )
            );
          },
        ),
      )
    );
  }
}