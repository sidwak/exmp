import 'package:exm_p/datamain.dart';
import 'package:exm_p/screens/creator/instagramcreator_screen.dart';
import 'package:exm_p/screens/creator/redditcreator_screen.dart';
import 'package:exm_p/screens/creator/twittercreator_screen.dart';
import 'package:exm_p/screens/creator/youtubecreator_screen.dart';
import 'package:exm_p/widgets/snacky.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreatorAccountScreen extends StatefulWidget{
  const CreatorAccountScreen({super.key});

  @override
  State<CreatorAccountScreen> createState() => _CreatorAccountScreen();
}


class _CreatorAccountScreen extends State<CreatorAccountScreen>{

  late BuildContext mainCtx;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ytLinkController = TextEditingController();
  final TextEditingController _igLinkController = TextEditingController();
  final TextEditingController _twLinkController = TextEditingController();
  final TextEditingController _rdLinkController = TextEditingController();

  void updateLinksAndReload(){
    ScaffoldMessenger.of(mainCtx).showSnackBar(
      SnackyBar(toSet: "Links Updated")
    );
    globalKey.currentState?.setLinkAndReload(_ytLinkController.text);
    igGlobalKey.currentState?.setLinkAndReload(_igLinkController.text);
    twGlobalKey.currentState?.setLinkAndReload(_twLinkController.text);
    rdGlobalKey.currentState?.setLinkAndReload(_rdLinkController.text);
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
                    Text("Account Setup", 
                      style: GoogleFonts.nunito(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.inversePrimary
                      ),
                    ),
                    Container(
                      height: 45,
                      width: w * 0.70,
                      margin: const EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _nameController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          labelText: "User Name",
                          contentPadding: EdgeInsets.zero,
                          alignLabelWithHint: true,
                          labelStyle: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.background
                          ),
                          filled: true,
                          prefixIcon: const Icon(Icons.account_circle),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45.0),
                          )
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      width: w * 0.70,
                      margin: const EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _ytLinkController,
                        textAlignVertical: TextAlignVertical.center,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: "Youtube URL",
                          contentPadding: EdgeInsets.zero,
                          alignLabelWithHint: true,
                          labelStyle: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.background
                          ),
                          filled: true,
                          prefixIcon: const Icon(Icons.link),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45.0),
                          )
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      width: w * 0.70,
                      margin: const EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _igLinkController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          labelText: "Instagram URL",
                          contentPadding: EdgeInsets.zero,
                          alignLabelWithHint: true,
                          labelStyle: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.background
                          ),
                          filled: true,
                          prefixIcon: const Icon(Icons.link),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45.0),
                          )
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      width: w * 0.70,
                      margin: const EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _twLinkController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          labelText: "Twitter URL",
                          contentPadding: EdgeInsets.zero,
                          alignLabelWithHint: true,
                          labelStyle: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.background
                          ),
                          filled: true,
                          prefixIcon: const Icon(Icons.link),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45.0),
                          )
                        ),
                      ),
                    ),
                    Container(
                      height: 45,
                      width: w * 0.70,
                      margin: const EdgeInsets.only(top: 10),
                      child: TextField(
                        controller: _rdLinkController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          labelText: "Reddit URL",
                          contentPadding: EdgeInsets.zero,
                          alignLabelWithHint: true,
                          labelStyle: GoogleFonts.nunito(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: Theme.of(context).colorScheme.background
                          ),
                          filled: true,
                          prefixIcon: const Icon(Icons.link),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45.0),
                          )
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top:15),
                      width: 123,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          //Navigator.pushNamed(context, FollowerHomeScreen.id);
                          DataMain().addCreatorAccount(_nameController.text, _ytLinkController.text,
                          _igLinkController.text, _twLinkController.text, _rdLinkController.text);
                          updateLinksAndReload();
                        },
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll<Color>(Colors.purpleAccent)
                        ),
                        child: Text("Update", 
                          style: GoogleFonts.nunito(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.inversePrimary
                          ),
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