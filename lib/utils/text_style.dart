import 'package:flutter/material.dart';

import 'font_style.dart';

// regular TextStyle
TextStyle regularTextStyle({
  double fontSize = FontSizeUtils.s14,
  String fontFamily = FontFamilyUtils.defaultFont,
  FontWeight fontWeight = FontWeight.normal,
  Color? color = Colors.black,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}

// regular Bold TextStyle
TextStyle regularBoldTextStyle({
  double fontSize = FontSizeUtils.s14,
  String fontFamily = FontFamilyUtils.defaultFont,
  FontWeight fontWeight = FontWeight.bold,
  Color? color = Colors.black,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}

// regular TextStyle 1
TextStyle regularTextStyle1({
  double fontSize = FontSizeUtils.s20,
  String fontFamily = FontFamilyUtils.breeSerif,
  FontWeight fontWeight = FontWeight.normal,
  Color? color = Colors.black,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}

// regular Bold TextStyle 1
TextStyle regularBoldTextStyle1({
  double fontSize = FontSizeUtils.s20,
  String fontFamily = FontFamilyUtils.breeSerif,
  FontWeight fontWeight = FontWeight.bold,
  Color? color = Colors.black,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}

// regular Bold TextStyle 2
TextStyle regularBoldTextStyle2({
  double fontSize = FontSizeUtils.s24,
  String fontFamily = FontFamilyUtils.breeSerif,
  FontWeight fontWeight = FontWeight.bold,
  Color? color = Colors.black,
}) {
  return TextStyle(
    fontSize: fontSize,
    fontFamily: fontFamily,
    fontWeight: fontWeight,
    color: color,
  );
}
