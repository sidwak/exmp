import 'package:exm_p/screens/creator/creatorhome_screen.dart';
import 'package:exm_p/screens/creator/creatorsignup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exm_p/auth.dart';

class CreatorLoginScreen extends StatelessWidget {
  CreatorLoginScreen({super.key});
  static String id = "creatorlogin_screen";

  /* final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  } */

  late BuildContext mainCtx;

  String errorMessage = "null";

  //bool isLogin = true;

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
          Navigator.pushNamed(mainCtx, CreatorHomeScreen.id);
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

  /* Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text);
    }
    on FirebaseAuthException catch(e) {
      if (e.message != null){errorMessage = e.message!;}   
      ScaffoldMessenger.of(mainCtx).showSnackBar(
        SnackBar(content: Text(errorMessage))
      );
    }
  } */

  void loginButtonPressed(){
    //_controllerEmail.text = "sidwak6@gmail.com";
    //_controllerPassword.text = "Siddheshwar@1";
    signInWithEmailAndPassword();
    //Navigator.pushNamed(mainCtx, CreatorHomeScreen.id);
  }

  @override
  Widget build(BuildContext context){
    mainCtx = context;
    return Scaffold(
      body: Container(
        //padding: const EdgeInsets.only(top: 100),
        //margin: const EdgeInsets.only(top: 100),
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
                    //Navigator.pushNamed(context, CreatorHomeScreen.id);
                    loginButtonPressed();
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
                  Navigator.pushNamed(context, CreatorSignupScreen.id);
                },
                child: Container(     
                  //width: 100,
                  //height: 100,
                  //color: Colors.lightBlue,           
                  child: Text("Sign Up"),
                )
              ),   
              Text("Creator")         
            ],
          ),
        ),
      )
    );
  }
}