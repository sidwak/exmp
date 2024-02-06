import 'package:flutter/material.dart';

class SnackyBar extends SnackBar{
  String toSet;
  SnackyBar({super.key, required this.toSet}): super(
    content: Text(
      toSet, 
      textAlign: TextAlign.center,
    ),
    backgroundColor: Colors.blue.shade300,
    elevation: 6.0,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25)))
  );
}