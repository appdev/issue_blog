import 'package:flutter/material.dart';
import 'package:issue_blog/utils/config.dart';
import 'package:issue_blog/widget/mirages_blog_bar.dart';
import 'package:issue_blog/widget/mirages_foot_wodget.dart';
import 'package:issue_blog/widget/mirages_issue_list.dart';
import 'package:issue_blog/widget/mirages_post_title_widget.dart';

class WebHomeMiragesPage extends StatelessWidget {
  final String category;

  WebHomeMiragesPage({Key key, this.category});

  final List<Widget> content = List()
    ..add(MiragesPostTitle(title: Config.BLOG, userHitokoto: true, titlePic: Config.BLOG_PIC));

  @override
  Widget build(BuildContext context) {
    content.add(MiragesIssueList(category));
    content.add(MiragesFoot());
    return Scaffold(
        backgroundColor: Colors.white,
        body: MiragesBlogBar.buildBlogBar(
            ListView.builder(
              itemBuilder: (context, index) => content[index],
              itemCount: content.length,
            ),
            context));
  }
}
