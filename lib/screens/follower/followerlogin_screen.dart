import 'package:exm_p/screens/follower/followerhome_screen.dart';
import 'package:exm_p/screens/follower/followersignup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exm_p/auth.dart';

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
        password: _controllerPassword.text);
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null){
          ScaffoldMessenger.of(mainCtx).showSnackBar(
            SnackBar(
              content: Text("User Singed In"),
              )
          );
          Navigator.pushNamed(mainCtx, FollowerHomeScreen.id);
        }
      });
    }
    on FirebaseAuthException catch(e) {
      debugPrint(e.message);
      if (e.message != null){errorMessage = e.message!;}   
      ScaffoldMessenger.of(mainCtx).showSnackBar(
        SnackBar(content: Text(errorMessage))
      );
    }
  }

  void loginButtonPressed(){
    //_controllerEmail.text = "sidwak6@gmail.com";
    //_controllerPassword.text = "Siddheshwar@1";
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
            return Container(
              child: Center(              
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container (
                      color: Theme.of(context).colorScheme.inversePrimary,
                      width: 150,
                      height: 150,
                      child: const Center(child: Text("Logo here"))
                    ),
                    const Text("Login", 
                      style: TextStyle(
                        fontSize: 35,
                      ),
                    ),
                    Container (
                      //margin: const EdgeInsets.only(top: 36, bottom: 5, left: 36, right: 36),
                      //padding: const EdgeInsets.only(top: 36, bottom: 5, left: 36, right: 36),
                      height: 50,
                      width: 250,
                      child: TextField(
                        controller: _controllerEmail,
                        decoration: InputDecoration(
                          labelText: "User ID",
                          filled: true,
                          prefixIcon: const Icon(Icons.verified_user),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )
                        ),
                      ), 
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 50,
                      width: 250,
                      child: TextField(
                        controller: _controllerPassword,
                        decoration: InputDecoration(
                          labelText: "Password",
                          filled: true,
                          prefixIcon: const Icon(Icons.password),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0)
                          )
                        ),
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.only(top:10),
                      width: 120,
                      height: 40,
                      color: Colors.amber,
                      child: ElevatedButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, FollowerHomeScreen.id);
                          signInWithEmailAndPassword();
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.purpleAccent)
                        ),
                        child: const Text("Login", 
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                          )
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
                        child: Text("Sign Up"),
                      )
                    ),
                    Text("Follower")
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