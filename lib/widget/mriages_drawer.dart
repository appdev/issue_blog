import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:issue_blog/datatransfer/data_model.dart';
import 'package:issue_blog/net/github_api.dart';
import 'package:issue_blog/utils/config.dart';
import 'package:issue_blog/utils/route_util.dart';
import 'package:issue_blog/utils/ui_util.dart';
import 'package:issue_blog/widget/common_widget.dart';
import 'package:issue_blog/widget/mirages_label_item.dart';
import 'package:provider/provider.dart';

class MiragesDrawer extends StatefulWidget {
  const MiragesDrawer({Key key}) : super(key: key);

  @override
  _MiragesDrawerState createState() => _MiragesDrawerState();
}

class _MiragesDrawerState extends State<MiragesDrawer> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchLabelList();
      _fetchUserInfo();
    });
  }

  _fetchLabelList() {
    LabelListModel labelListModel = Provider.of<LabelListModel>(context, listen: false);
    if (labelListModel.labelList != null) {
      return;
    }
    GitHubApi.getLabelList().then((labelList) {
      var label = labelList;
//      label.addAll(labelList);
      labelListModel.labelList = label;
    }).catchError((error) {
      print('获取标签列表失败 $error');
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('获取标签列表失败')));
    });
  }

  _fetchUserInfo() {
    UserInfoModel userInfoModel = Provider.of<UserInfoModel>(context, listen: false);
    if (userInfoModel.userInfo != null) {
      return;
    }

    GitHubApi.getUserInfo().then((userInfo) {
      userInfoModel.userInfo = userInfo;
    }).catchError((error) {
      print('获取个人信息失败 $error');
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('获取个人信息失败')));
    });
  }

  Widget _buildBlue() {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: UIUtil.getWidth(context) * 0.4),
          color: Colors.white10,
        ),
        Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 30,
              sigmaY: 30,
            ),
            child: buildListView(),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(right: UIUtil.getWidth(context) * 0.4),
          color: Colors.white38,
        ),
        Container(
          margin: EdgeInsets.only(right: UIUtil.getWidth(context) * 0.4),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 30,
                sigmaY: 30,
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(8, 40, 0, 40),
                child: buildListView(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildListView() {
    return Column(children: <Widget>[
      Consumer<UserInfoModel>(builder: (context, userInfoModel, _) {
        if (userInfoModel.userInfo == null) {
          return LoadingWidget();
        }
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: ((UIUtil.getWidth(context) * 0.6) - 120 - 16) / 2),
          child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(userInfoModel.userInfo.avatarUrl), fit: BoxFit.cover))),
        );
      }),
      SizedBox(height: 15),
      Center(child: buildPageText(context, Config.BLOG, () {})),
      SizedBox(height: 15),
      Center(
          child: buildPageText(context, "首页", () {
        RouteUtil.routeToIndex(context, "");
      })),
      SizedBox(height: 15),
      Center(child: buildPageText(context, "关于", () {})),
      SizedBox(height: 15),
      Consumer<LabelListModel>(builder: (context, labelListModel, _) {
        if (labelListModel.labelList == null) {
          return LoadingWidget();
        }
        if (labelListModel.labelList.isEmpty) {
          return EmptyWidget('没有分类');
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(60, 10, 20, 15),
          child: Container(
            width: (MediaQuery.of(context).size.width * 0.75),
            child: Wrap(
                spacing: 8,
                runSpacing: 8,
                verticalDirection: VerticalDirection.down,
                alignment: WrapAlignment.start,
                children: labelListModel.labelList.map((label) {
                  return Consumer<CurrentLabelModel>(builder: (context, currentLabelModel, _) {
                    return MiragesLabelItem(
                        label: label,
                        selected: label.name == currentLabelModel.currentLabel,
                        onSelected: (selected) {
                          Navigator.pop(context);
                          RouteUtil.routeToIndex(context, label.name);
                          currentLabelModel.currentLabel = selected ? label.name : "";
                        });
                  });
                }).toList()),
          ),
        );
      }),
    ]);
  }

  InkWell buildPageText(BuildContext context, String title, GestureTapCallback callback) => InkWell(
      onTap: () {
        callback;
        Navigator.pop(context);
      },
      child: Text(title, style: TextStyle(fontSize: 18, color: Colors.black)));
}
