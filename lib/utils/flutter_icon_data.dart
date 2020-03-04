import 'package:flutter/material.dart';

/// It is used to generate IconData under different icon sets
class FlutterIconData extends IconData {
  const FlutterIconData(int codePoint, String fontFamily)
      : super(codePoint, fontFamily: fontFamily, fontPackage: "flutter_icons");

  const FlutterIconData.ionicons(int codePoint) : this(codePoint, "Ionicons");
}
