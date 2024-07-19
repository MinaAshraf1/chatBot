import 'package:chat_bot/core/utils/constant.dart';
import 'package:chat_bot/main.dart';
import 'package:flutter/material.dart';

abstract class Styles {
  static TextStyle testStyle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: prefs.getBool("darkMode") == true
        ? colorsDark['color2'] : colorsLight['color2'],
  );

  static TextStyle testStyle16 = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: prefs.getBool("darkMode") == true
          ? colorsDark['color5'] : colorsLight['color5']
  );

  static TextStyle testStyle18 = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: prefs.getBool("darkMode") == true
          ? colorsDark['color4'] : colorsLight['color4']
  );

  static const testStyle20 = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Color(0xffE3DFDE)
  );

  static const testStyle24 = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: Color(0xffE3DFDE)
  );

  static TextStyle testStyle40 = TextStyle(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      color: prefs.getBool("darkMode") == true
          ? colorsDark['color2'] : colorsLight['color2']
  );
}