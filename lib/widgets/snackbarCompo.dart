import 'package:flutter/material.dart';


String toWrite = "default";

class SnackBarCompo extends StatefulWidget{
  final String varToWrite;
  SnackBarCompo({super.key, required this.varToWrite}){
    toWrite = varToWrite;
  }

  @override
  State<SnackBarCompo> createState() => _SnackBarCompo();
}

class _SnackBarCompo extends State<SnackBarCompo>{
  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(toWrite),
      backgroundColor: Colors.blue.shade300,
      elevation: 6.0,
      behavior: SnackBarBehavior.floating,
    );   
  }
}