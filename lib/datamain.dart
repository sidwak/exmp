import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

FirebaseFirestore instance = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;
User user = auth.currentUser!;

class DataMain{
  void addCreatorAccount (String name, String ytLink, String instaLink, String twiLink, String 
  redLink) async {
    CollectionReference ref = instance.collection("creators");
    final nameEmail = user.email?.split('@');
    await ref.doc(nameEmail?[0]).set({
      "email": user.email,
      "name": name,
      "email_name": nameEmail?[0],
      "yt_link": ytLink,
      "insta_link": instaLink,
      "twi_link": twiLink,
      "red_link": redLink
    });
  }

  void addFollowerAccount () async {
    final name = user.email?.split('@');
    List<String> followers = ["null", "null"];
    CollectionReference ref = instance.collection("followers");
    await ref.doc(name?[0]).set({
      "email": user.email,
      "name": name?[0],
      "following" : followers
    });
  }

  //  BELOW VARS BELONGS TO BELOW FUNCTION  
  List<Map<String, dynamic>> searchData = [];
  void getSearchData() async{
    CollectionReference ref = instance.collection("creators");
    searchData = [];
    await ref.get().then(
      (snapshot) {
        for (var docSnapshot in snapshot.docs){
          final data = docSnapshot.data() as Map<String, dynamic>;
          searchData.add(data);
        }
      } 
    );
  }

  Future<bool> getCreatorLinks() async {
    final nameEmail = user.email?.split('@');
    DocumentReference ref = instance.collection("creators").doc(nameEmail?[0]);
    bool exists = false;
    await ref.get().then((value) => {
      if (value.exists){
        debugPrint("ddb document exits"),
        exists = true,
        debugPrint("ddb $exists"),
        //getCreatorData()
      }
      else {
        debugPrint("ddb document does not exits"),
        exists = false,
      }
    });
    return exists;
  }

  //  BELOW VARS BELONGS TO BELOW FUNCTION  
  Map<String, dynamic> ret = {};
  void getCreatorData () async {
    final nameEmail = user.email?.split('@');
    final docRef = instance.collection("creators").doc(nameEmail?[0]);
    await docRef.get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        ret = data;
        debugPrint("ddb " + ret.toString());
      },
      onError: (e) => debugPrint("ddb Error getting document: $e"),
    );
    debugPrint("ddb "+ret.toString());
  }
}