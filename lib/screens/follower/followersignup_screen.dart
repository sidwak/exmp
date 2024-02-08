import 'package:exm_p/screens/follower/followerhome_screen.dart';
import 'package:exm_p/widgets/snacky.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exm_p/auth.dart';
import 'package:exm_p/datamain.dart';
import 'package:google_fonts/google_fonts.dart';

class FollowerSignupScreen extends StatelessWidget{
  FollowerSignupScreen({super.key});

  static String id = "followersignup_screen";

  late BuildContext mainCtx;

  String errorMessage = "null";

  //bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerConfPassword = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text
      );
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null){
          debugPrint("usersignedup");
          ScaffoldMessenger.of(mainCtx).showSnackBar(
            SnackyBar(toSet: "User Singed Up")
          );
          DataMain().addFollowerAccount();
          Navigator.pushNamed(mainCtx, FollowerHomeScreen.id);
        }
      });
    }
    on FirebaseAuthException catch(e) {
      if (e.message != null){errorMessage = e.message!;}   
      ScaffoldMessenger.of(mainCtx).showSnackBar(
        SnackyBar(toSet: errorMessage)
      );
    }
  }

  void signUpButtonPressed(){
    if (_controllerPassword.text == _controllerConfPassword.text){
      createUserWithEmailAndPassword();
    }
    else {
      ScaffoldMessenger.of(mainCtx).showSnackBar(
        SnackyBar(toSet: "Confirm Password Does Not Match")
      );
    }
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
                      child: Text("Sign up", 
                        style: GoogleFonts.nunito(
                          fontSize: 21,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).colorScheme.inversePrimary
                        ),
                      ),
                    ),
                    Container (
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
                          prefixIcon: const Icon(Icons.email),
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
                          labelText: "Password",
                          contentPadding: EdgeInsets.zero,
                          alignLabelWithHint: true,
                          labelStyle: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.background
                          ),
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45.0),
                          )
                        ),
                      )
                    ),
                    Container(
                      height: 45,
                      width: w * 0.60,
                      margin: const EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _controllerConfPassword,
                        obscureText: true,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.zero,
                          labelStyle: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.background
                          ),
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45.0),
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
                          //Navigator.pushNamed(context, CreatorHomeScreen.id);
                          createUserWithEmailAndPassword();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Theme.of(context).colorScheme.primary)
                        ),
                        child: Text("Signup", 
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
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
        )
      )
    );
  }
}