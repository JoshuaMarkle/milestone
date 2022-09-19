import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Group of Colors
const snowman = Color(0xfffbfbfb);
const whitey = Color(0xfff7f7f7);
const karl = Color(0xffedeced);
const clooney = Color(0xffc1bec1);
const gandalf = Color(0xff979197);
const teflon = Color(0xff554d56);

const midnight = Color(0xff171717);
const offBlack = Color(0xff202020);
const nero = Color(0xff282828);
const eclipse = Color(0xff363636);
const charcoal = Color(0xff3d3d3d);
const storm = Color(0xff666666);
const smoke = Color(0xff999999);
const gainsboro = Color(0xffdedede);

const red = Color(0xffff5768);
const yellow = Color(0xffffb347);
const blue = Color(0xff55aaff);
const purple = Color(0xffa29bfe);

final List<Color> accentColors = [
  red,
  yellow,
  blue,
  purple
];

/// Theme Data (Initialize Light Theme)
Color black = teflon;
Color gray = clooney;
Color lightGray = karl;
Color white = snowman;
Color specialWhite = snowman;

Color accent = blue;
Color transparentTint = Colors.black.withOpacity(0.3);

void setTheme(bool isDark) {
  black = isDark ? gainsboro : teflon;
  gray = isDark ? smoke : clooney;
  lightGray = isDark ? eclipse : karl;
  white = isDark ? offBlack : snowman;

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: white,
    systemNavigationBarDividerColor: lightGray,
  ));
}

 List<BoxShadow> boxShadow = [
     BoxShadow(
       color: Colors.black.withOpacity(0.1),
       spreadRadius: 0,
       blurRadius: 10,
       offset: const Offset(0, 3),
     )
 ];
