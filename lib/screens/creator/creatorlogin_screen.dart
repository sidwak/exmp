import 'package:exm_p/datamain.dart';
import 'package:exm_p/screens/creator/creatorhome_screen.dart';
import 'package:exm_p/screens/creator/creatorsignup_screen.dart';
import 'package:exm_p/widgets/snacky.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exm_p/auth.dart';
import 'package:google_fonts/google_fonts.dart';

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
        password: _controllerPassword.text).then((value){
          ScaffoldMessenger.of(mainCtx).showSnackBar(
            SnackyBar(toSet: "User Singed In")
          );
          DataMain().setNewUser(FirebaseAuth.instance.currentUser!);
          Navigator.pushReplacementNamed(mainCtx, CreatorHomeScreen.id);        
        });
      // FirebaseAuth.instance.authStateChanges().listen((User? user) {
      //   if (user != null){
      //     ScaffoldMessenger.of(mainCtx).showSnackBar(
      //       SnackyBar(toSet: "User Singed In")
      //     );
      //     DataMain().setNewUser(user);
      //     Navigator.pushReplacementNamed(mainCtx, CreatorHomeScreen.id);
      //   }
      // });
    }
    on FirebaseAuthException catch(e) {
      debugPrint("ddb $e.message");
      if (e.message != null){errorMessage = e.message!;}   
      ScaffoldMessenger.of(mainCtx).showSnackBar(
        SnackyBar(toSet: errorMessage)
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
    // _controllerEmail.text = "sidwak6@gmail.com";
    // _controllerPassword.text = "Siddheshwar@1";
    signInWithEmailAndPassword();
    //Navigator.pushNamed(mainCtx, CreatorHomeScreen.id);
  }

  @override
  Widget build(BuildContext context){
    mainCtx = context;
    return Scaffold(
      //resizeToAvoidBottomInset: false,   
      body: Container(     
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
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
                      //padding: const EdgeInsets.all(3),
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
                      margin: const EdgeInsets.only(top: 10),
                      height: 45,
                      width: w * 0.60,
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
                      //color: Colors.amber,
                      child: ElevatedButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, CreatorHomeScreen.id);
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
                        Navigator.pushNamed(context, CreatorSignupScreen.id);
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
                    //Text("Creator")         
                  ],
                ),
              )
            );
          }
        )
      )
    );
  }
}