import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exm_p/auth.dart';
import 'package:exm_p/screens/creator/creatorhome_screen.dart';
import 'package:exm_p/datamain.dart';

class CreatorSignupScreen extends StatelessWidget{
  CreatorSignupScreen({super.key});
  static String id = "creatorsignup_screen";

  late BuildContext mainCtx;

  String errorMessage = "null";

  //bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

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
            SnackBar(content: Text("User Singed Up"))
          );
          //DataMain().addCreatorAccount(_controllerEmail.text);
          Navigator.pushNamed(mainCtx, CreatorHomeScreen.id);
        }
      });
    }
    on FirebaseAuthException catch(e) {
      if (e.message != null){errorMessage = e.message!;}   
      ScaffoldMessenger.of(mainCtx).showSnackBar(
        SnackBar(content: Text(errorMessage))
      );
    }
  }

  void signUpButtonPressed(){
    createUserWithEmailAndPassword();
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
                    const Text("Sign up", 
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
                      margin: const EdgeInsets.only(top: 10),
                      height: 50,
                      width: 250,
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
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
                          signUpButtonPressed();
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.purpleAccent)
                        ),
                        child: const Text("Sign up", 
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                          )
                        ),
                      )
                    ),
                    Text("Creator")
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