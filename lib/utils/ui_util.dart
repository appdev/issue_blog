import 'dart:collection';

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

  static var _map = new HashMap()
    //高 宽 字体大小
    ..[700] = const [16, 0, 168, 25, 13]
    ..[1260] = const [20, 688, 248, 25, 13]
    ..[1600] = const [20, 832, 248, 25, 13]
    ..[1700] = const [36, 860, 279, 28, 14];

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static List<int> getIssueItemWidth(BuildContext context) {
    var width = getWidth(context);
    if (width <= 700) {
      return _map[700];
    } else if (width <= 1260) {
      return _map[1260];
    } else if (width <= 1600) {
      return _map[1600];
    } else if (width <= 1700) {
      return _map[1700];
    }
  }
}
