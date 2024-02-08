import 'package:flutter/material.dart';

class SnackyBar extends SnackBar{
  final String toSet;
  SnackyBar({super.key, required this.toSet}): super(
    content: Text(
      toSet, 
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white
      ),
    ),
    backgroundColor: const Color.fromARGB(255, 145, 70, 255),
    elevation: 6.0,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25)))
  );
}