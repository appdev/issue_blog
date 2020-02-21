import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:issue_blog/widget/mirages_foot_wodget.dart';
import 'package:issue_blog/widget/mirages_head_widget.dart';
import 'package:issue_blog/widget/mirages_issue_list.dart';
import 'package:issue_blog/widget/mirages_post_title_widget.dart';

class WebHomeMiragesPage extends StatelessWidget {
  final List<Widget> content = List()
    ..add(MiragesPostTitle())
    ..add(MiragesIssueList())
    ..add(MiragesFoot());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:

//        Stack(
//          children: <Widget>[
//            ListView.builder(
//              itemBuilder: (context, index) => content[index],
//              itemCount: content.length,
//            ),
//            _buildStickyBar()
//          ],
//        )
            _buildStickyBar());
  }

  Widget _buildStickyBar() {
    return Stack(
      children: <Widget>[
        ListView.builder(
          itemBuilder: (context, index) => content[index],
          itemCount: content.length,
        ),
        Container(
          height: 81,
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
