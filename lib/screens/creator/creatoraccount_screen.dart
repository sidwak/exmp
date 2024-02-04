import 'package:exm_p/datamain.dart';
import 'package:flutter/material.dart';

class CreatorAccountScreen extends StatefulWidget{
  const CreatorAccountScreen({super.key});

  @override
  State<CreatorAccountScreen> createState() => _CreatorAccountScreen();
}


class _CreatorAccountScreen extends State<CreatorAccountScreen>{

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ytLinkController = TextEditingController();
  final TextEditingController _igLinkController = TextEditingController();
  final TextEditingController _twLinkController = TextEditingController();
  final TextEditingController _rdLinkController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        child: LayoutBuilder(
          builder: (BuildContext ctx, BoxConstraints constraints){
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("Your Account Setup"),
                    Container(
                      //height: 50,
                      width: 250,
                      padding: EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "User Name",
                          filled: true,
                          prefixIcon: const Icon(Icons.verified_user),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )
                        ),
                      ),
                    ),
                    Container(
                      //height: 50,
                      width: 250,
                      padding: EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _ytLinkController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: "Youtube URL",
                          filled: true,
                          prefixIcon: const Icon(Icons.verified_user),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )
                        ),
                      ),
                    ),
                    Container(
                      //height: 50,
                      width: 250,
                      padding: EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _igLinkController,
                        decoration: InputDecoration(
                          labelText: "Instagram URL",
                          filled: true,
                          prefixIcon: const Icon(Icons.verified_user),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )
                        ),
                      ),
                    ),
                    Container(
                      //height: 50,
                      width: 250,
                      padding: EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _twLinkController,
                        decoration: InputDecoration(
                          labelText: "Twitter URL",
                          filled: true,
                          prefixIcon: const Icon(Icons.verified_user),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )
                        ),
                      ),
                    ),
                    Container(
                      //height: 50,
                      width: 250,
                      padding: EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _rdLinkController,
                        decoration: InputDecoration(
                          labelText: "Reddit URL",
                          filled: true,
                          prefixIcon: const Icon(Icons.verified_user),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top:10),
                      width: 120,
                      height: 40,
                      color: Colors.amber,
                      child: ElevatedButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, FollowerHomeScreen.id);
                          DataMain().addCreatorAccount(_nameController.text, _ytLinkController.text,
                          _igLinkController.text, _twLinkController.text, _rdLinkController.text);
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.purpleAccent)
                        ),
                        child: const Text("Update", 
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white
                          )
                        ),
                      )
                    )
                  ]
                )
              )
            );
          },
        )
      )
    );
  }
}