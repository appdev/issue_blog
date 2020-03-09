import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:issue_blog/dto/label.dart';
import 'package:issue_blog/net/github_api.dart';
import 'package:issue_blog/utils/base_state.dart';
import 'package:issue_blog/utils/date_util.dart';
import 'package:issue_blog/utils/ui_util.dart';
import 'package:issue_blog/widget/mirages_blog_bar.dart';
import 'package:issue_blog/widget/mirages_comment_widget.dart';
import 'package:issue_blog/widget/mirages_foot_wodget.dart';
import 'package:issue_blog/widget/mirages_post_title_widget.dart';
import 'package:issue_blog/widget/mriages_drawer.dart';

class WebBlogDetailMiragesPage extends StatefulWidget {
  final dynamic issue;

  WebBlogDetailMiragesPage({Key key, this.issue}) : super(key: key);

  @override
  _WebBlogDetailMiragesPageState createState() => _WebBlogDetailMiragesPageState().._issue = issue;
}

class _WebBlogDetailMiragesPageState extends BaseState<WebBlogDetailMiragesPage> {
  Map _issue;
  List _comments;

  @override
  void initState() {
    super.initState();

    if (_issue != null) {
      _fetchComments();
    }
  }

  _fetchComments() {
    if (_issue != null && this._issue['comments'] > 0) {
      GitHubApi.getComments(_issue['comments_url']).then((comments) {
        setState(() {
          _comments = comments;
        });
      }).catchError((error) {
        print('获取 comments 失败 $error');
      });
    }
  }

  List<Widget> content = List();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: MiragesBlogBar.buildBlogBar(buildBodyWidget, context),
          drawer: MiragesDrawer(),
        ),
        onWillPop: () {
          Navigator.pop(context);
          return new Future.value(false);
        });
  }

  Widget get buildBodyWidget {
    if (_issue == null) {
      return Center(child: CircularProgressIndicator());
    }
    var label = (_issue['labels']).toString().isNotEmpty
        ? ("・" +
            Label.fromJsonList(_issue['labels'])
                .map((e) => e.name)
                .toList()
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", ""))
        : "";
    content.clear();
    content.add(MiragesPostTitle(
        title: _issue["title"],
        subTitle:
            DateUtil.formatDateStr(_issue['created_at'], format: DataFormats.zh_y_mo_d) + label,
        userHitokoto: false,
        titlePic: _issue["html_url"]));
    content.add(_buildListWidget());
    content.add(SizedBox(
      height: 100,
    ));
    content.add(MiragesFoot());
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return content[index];
      },
      itemCount: content.length,
    );
  }

  Container _buildListWidget() {
    List<Widget> _commentWidget = [MiragesCommentWidget(comment: _issue)];
    if (_comments != null && _comments.isNotEmpty) {
      for (Map comment in _comments) {
        _commentWidget.add(MiragesCommentWidget(comment: comment));
      }
    }

    var width = (UIUtil.getWidth(context) -
            (UIUtil.getIssueItemWidth(context)[1] == 0
                ? UIUtil.getWidth(context)
                : UIUtil.getIssueItemWidth(context)[1].toDouble())) /
        2;

    return Container(
      padding: EdgeInsets.fromLTRB(width, 25, width, 25),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, position) {
          return _commentWidget[position];
        },
        itemCount: _commentWidget.length,
      ),
    );
  }
}
