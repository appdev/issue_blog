import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:issue_blog/dto/label.dart';
import 'package:issue_blog/net/github_api.dart';
import 'package:issue_blog/utils/base_state.dart';
import 'package:issue_blog/widget/comment_widget.dart';
import 'package:issue_blog/widget/mirages_blog_bar.dart';
import 'package:issue_blog/widget/mirages_foot_wodget.dart';
import 'package:issue_blog/widget/mirages_post_title_widget.dart';

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
    var label = (_issue['labels']).toString().isNotEmpty
        ? ("・" +
            Label.fromJsonList(_issue['labels'])
                .map((e) => e.name)
                .toList()
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", ""))
        : "";
    content.add(MiragesPostTitle(
        title: _issue["title"],
        subTitle:
            DateTime.tryParse(_issue['created_at']).toString().substring(0, "yyyy年MM月dd日".length) +
                label,
        userHitokoto: false,
        titlePic: _issue["html_url"]));
//    WidgetsBinding.instance.addPostFrameCallback((_) {
//      _number = ModalRoute.of(context).settings.arguments;
//      print('动态路由 ${ModalRoute.of(context).settings.name}');
//      _fetchIssue();
//    });
  }

//  _fetchIssue() {
//    GitHubApi.getIssue(_issuePost["number"]).then((issue) {
//      setState(() {
//        _issue = issue;
//        _fetchComments();
//      });
//    }).catchError((error) {
//      print('获取 issue 失败 $error');
//    });
//  }

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
//        appBar: AppBar(
//          elevation: 0,
//          title: Text(_issue == null ? '博客详情' : _issue['title']),
//        ),
            body: MiragesBlogBar.buildBlogBar(buildBodyWidget, context)),
        onWillPop: () {
          Navigator.pop(context);
          return new Future.value(false);
        });
  }

  Widget get buildBodyWidget {
    if (_issue == null) {
      return Center(child: CircularProgressIndicator());
    }
//    List<Widget> commentWidgetList = [Container()];
    content.add(CommentWidget(comment: _issue));
    if (_comments != null && _comments.isNotEmpty) {
      for (Map comment in _comments) {
        content.add(CommentWidget(comment: comment));
      }
    }

    content.add(MiragesFoot());
    return ListView.separated(
      itemBuilder: (context, position) {
        return content[position];
      },
      itemCount: content.length,
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.white,
          height: 25,
        );
      },
    );
  }
}
