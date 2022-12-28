import 'package:flutter/material.dart';

const Color bluishClr = Color(0xFF4e5ae8);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFFF4667);
const primaryClr = bluishClr;
const Color darkGreyClr = Color(0xFF121212);
const darkHeaderClr = Color(0xFF424242);

class Themes {
  static final light = ThemeData(
      backgroundColor: Colors.white,
      primaryColor: primaryClr,
      brightness: Brightness.light);

  static final dark = ThemeData(
      backgroundColor: darkHeaderClr,
      primaryColor: darkHeaderClr,
      brightness: Brightness.dark);
}
