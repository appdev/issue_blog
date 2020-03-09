import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:issue_blog/utils/ui_util.dart';
import 'package:issue_blog/widget/mirages_head_widget.dart';

class MiragesBlogBar {
  static buildBlogBar(Widget content, BuildContext context) {
    return Stack(
      children: <Widget>[
        content,
        Container(
          margin: EdgeInsets.fromLTRB(UIUtil.getWidth(context) <= 700 ? 15 : 0,
              UIUtil.getWidth(context) <= 700 ? 15 : 0, 0, 0),
          height:
              UIUtil.getWidth(context) >= 1600 ? 81 : (UIUtil.getWidth(context) <= 700 ? 35 : 72),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(UIUtil.getWidth(context) <= 700 ? 25 : 0),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 30,
                sigmaY: 30,
              ),
              child: Container(
                color: UIUtil.getWidth(context) <= 700 ? Colors.black38 : Colors.white10,
                child: MiragesHead(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
