import 'package:flutter/material.dart';
import 'package:issue_blog/datatransfer/events.dart';
import 'package:issue_blog/page/blog_detail_page.dart';
import 'package:issue_blog/utils/base_state.dart';
import 'package:issue_blog/widget/issue_list.dart';

class BlogContent extends StatefulWidget {
  const BlogContent({Key key, @required this.showList, this.number = 0}) : super(key: key);
  final bool showList;
  final int number;

  @override
  _BlogContentStat createState() => _BlogContentStat()
    .._number = number
    .._showList = showList;
}

class _BlogContentStat extends BaseState<BlogContent> {
  bool _showList;
  int _number;

  @override
  void initState() {
    super.initState();
    addSubscription(streamBus.on<BlogContentChangeEvent>().listen((event) {
      print(event);
      setState(() {
        _showList = event.showList;
        _number = event.number;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return _showList ? IssueList() : BlogDetailPage(number: _number);
  }
}
