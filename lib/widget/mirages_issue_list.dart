import 'dart:async';

import 'package:flutter/material.dart';
import 'package:issue_blog/datatransfer/data_model.dart';
import 'package:issue_blog/datatransfer/events.dart';
import 'package:issue_blog/net/github_api.dart';
import 'package:issue_blog/utils/base_state.dart';
import 'package:issue_blog/utils/constant_util.dart';
import 'package:issue_blog/utils/hex_color.dart';
import 'package:issue_blog/utils/ui_util.dart';
import 'package:issue_blog/widget/common_widget.dart';
import 'package:issue_blog/widget/mirages_issue_item.dart';
import 'package:provider/provider.dart';

class MiragesIssueList extends StatefulWidget {
  MiragesIssueList(this.category);

  final String category;

  @override
  _IssueListState createState() => _IssueListState();
}

class _IssueListState extends BaseState<MiragesIssueList> {
  bool _isLoadingMore = false;
  bool _hasMore = true;
  PageModel _pageModel;
  int _page = 1;

  KeywordModel _keywordModel;
  String _keyword = '';

  IssueListModel _issueListModel;

  @override
  void initState() {
    super.initState();
    addSubscription(streamBus.on<PageChangedEvent>().listen((event) {
      if (_page == event.page) {
        return;
      }
      _page = event.page;
      _fetchIssueList();
    }));

    addSubscription(streamBus.on<KeywordChangedEvent>().listen((event) {
      if (_keyword == event.keyword) {
        return;
      }
      _keyword = event.keyword;
      _pullToRefresh();
    }));

    addSubscription(streamBus.on<LabelChangedEvent>().listen((event) {
      _keyword = '';
      _page = 1;
      _fetchIssueList();
    }));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 恢复 keyword 数据
      _keywordModel = Provider.of<KeywordModel>(context, listen: false);
      _keyword = _keywordModel.keyword;

      // 恢复 page 数据
      _pageModel = Provider.of<PageModel>(context, listen: false);
      _page = _pageModel.page;

      // 恢复 issueList
      _issueListModel = Provider.of<IssueListModel>(context, listen: false);
      if (_issueListModel.issueList != null) {
        return;
      }
      _fetchIssueList();
    });
  }

  void _nextPage() {
    //单页模式。不需要加载更多
    _isLoadingMore = false;
    setState(() {});
    // 加载更多更新页码
    _page++;
    _pageModel.page = _page;
    _fetchIssueList();
  }

  void _upPage() {
    //单页模式。不需要加载更多
    _isLoadingMore = false;
    setState(() {});
    // 加载更多更新页码
    if (_page == 1) {
      _pullToRefresh();
    } else {
      _page--;
      _fetchIssueList();
    }
    _pageModel.page = _page;
  }

  Future<Null> _fetchIssueList() {
    return GitHubApi.getIssueList(
            widget.category == null ? "" : widget.category, _keyword, _page, 10)
        .then((data) {
      //向data中插入图片
//      if (data != null) {
//        data = data.map((e) => e["html_url"] = Constant.getTitlePic()).toList();
//      }
//      if (_isLoadingMore) {
//        _issueListModel.addMoreIssueList(data);
//      } else {
//        _issueListModel.issueList = data;
//      }
      _issueListModel.issueList = data;
      //判断还有没有更多数据
      _hasMore = _issueListModel.issueList.length >= 10;
      //对已经保存的数据进行整理
      if (_issueListModel.issueList != null && _issueListModel.issueList.isNotEmpty) {
        _issueListModel.issueList.forEach((element) {
          if (element["html_url"] == null || element["html_url"] == "") {}
          element["html_url"] = Constant.getTitlePic();
        });
      }
    }).catchError((error) {
      if (_page != 1) {
        _page--;
      }
      print('获取博客列表失败 $error');
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('获取博客列表失败')));
    }).whenComplete(() {
      _isLoadingMore = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<IssueListModel>(builder: (context, issueListModel, _) {
      if (issueListModel.issueList == null) {
        return LoadingWidget();
      }
      if (issueListModel.issueList.isEmpty) {
        return EmptyWidget('没有博客');
      }
      List<Widget> issueList = new List();
      if (issueListModel.issueList.isEmpty) {
        issueList.add(_buildLoadMoreWidget());
      } else {
        issueList.clear();
        issueList.addAll(issueListModel.issueList.map((e) => MiragesIssueItem(issue: e)));
      }
      return Column(
        children: <Widget>[Column(children: issueList), _buildNextBtn()],
      );
    });
  }

  Widget _buildLoadMoreWidget() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Opacity(
        opacity: _isLoadingMore ? 1.0 : 0.0,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<Null> _pullToRefresh() async {
    // 下拉刷新时更新当前页码
    _page = 1;
    _pageModel.page = _page;
    return await _fetchIssueList();
  }

  Widget _buildNextBtn() {
    return Container(
      width: UIUtil.getIssueItemWidth(context)[1] == 0
          ? UIUtil.getWidth(context)
          : UIUtil.getIssueItemWidth(context)[1].toDouble(),
      padding: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Offstage(
            offstage: _page == 1,
            child: SizedBox(
              width: 134,
              height: 41,
              child: FlatButton(
                  onPressed: _upPage,
                  child: Text("上一页"),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: HexColor("#333333"),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          Expanded(
            child: SizedBox.shrink(),
          ),
          Offstage(
            offstage: !_hasMore,
            child: SizedBox(
              width: 134,
              height: 41,
              child: FlatButton(
                  onPressed: _nextPage,
                  child: Text("下一页"),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: HexColor("#333333"),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20))),
            ),
          )
        ],
      ),
    );
  }
}
