//import 'package:issue_blog/widget/markdown_widget_web.dart' if (dart.library.io) 'package:issue_blog/widget/markdown_widget_io.dart';
import 'package:flutter/material.dart';
import 'package:issue_blog/widget/markdown_widget_io.dart';

class MarkdownWidget extends StatelessWidget {
  const MarkdownWidget({Key key, @required this.markdown}) : super(key: key);

  final String markdown;

  @override
  Widget build(BuildContext context) {
    return getMarkdownView(context, markdown);
  }
}
