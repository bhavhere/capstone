import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kbackground = Color(0xff2A3596);

dynamic ktitle = GoogleFonts.pacifico(color: Colors.green[600], fontSize: 70);
dynamic ktitleSmall =
    GoogleFonts.pacifico(color: Colors.green[600], fontSize: 40);

Decoration ktoggleDec = BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(7),
    boxShadow: const [
      BoxShadow(
          color: Color(0xff2A3596),
          blurRadius: 15,
          offset: Offset(4, 4),
          spreadRadius: 1),
      BoxShadow(
          color: Color.fromARGB(255, 31, 42, 136),
          offset: Offset(-4, -4),
          blurRadius: 15,
          spreadRadius: 1),
      BoxShadow(
          color: Color.fromARGB(255, 27, 38, 129),
          offset: Offset(-4, -4),
          blurRadius: 15,
          spreadRadius: 1)
    ]);

Decoration kcontainerDec = BoxDecoration(
    color: const Color(0xff2A3596),
    borderRadius: BorderRadius.circular(50),
    boxShadow: const [
      BoxShadow(
          color: Color.fromARGB(255, 31, 42, 136),
          blurRadius: 15,
          offset: Offset(4, 4),
          spreadRadius: 1),
      // BoxShadow(
      //     color: Color.fromARGB(255, 27, 38, 129),
      //     offset: Offset(-4, -4),
      //     blurRadius: 10,
      //     spreadRadius: 1)
    ]);

Decoration kcbuttonDec = BoxDecoration(
    color: const Color(0xff007200),
    borderRadius: BorderRadius.circular(10),
    boxShadow: const [
      BoxShadow(
          color: Color(0xff006400),
          blurRadius: 15,
          offset: Offset(4, 4),
          spreadRadius: 1),
      BoxShadow(
          color: Color(0xff006400),
          offset: Offset(-4, -4),
          blurRadius: 15,
          spreadRadius: 1)
    ]);
