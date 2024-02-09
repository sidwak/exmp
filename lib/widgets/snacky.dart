import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SnackyBar extends SnackBar{
  final String toSet;
  SnackyBar({super.key, required this.toSet}): super(
    content: Text(
      toSet, 
      textAlign: TextAlign.center,
      style: GoogleFonts.nunito(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: Colors.white
      ),
    ),
    backgroundColor: const Color.fromARGB(255, 145, 70, 255),
    elevation: 6.0,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25)))
  );
}