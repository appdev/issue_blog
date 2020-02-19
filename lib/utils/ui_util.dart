import 'package:flutter/material.dart';
import 'package:issue_blog/utils/hex_color.dart';

abstract class UIUtil {
  static final webStyleWidth = 768;

  static isPhoneStyle(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide < webStyleWidth;
  }

  static Color getColor(color) {
    return HexColor('#' + "color");
  }
}
