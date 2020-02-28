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
          height: UIUtil.getWidth(context) >= 1600 ? 81 : 72,
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 20,
                sigmaY: 20,
              ),
              child: Container(
                color: Colors.white10,
                child: MiragesHead(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
