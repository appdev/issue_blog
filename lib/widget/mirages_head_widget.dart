import 'package:flutter/material.dart';
import 'package:issue_blog/datatransfer/data_model.dart';
import 'package:issue_blog/net/github_api.dart';
import 'package:issue_blog/utils/config.dart';
import 'package:issue_blog/utils/route_util.dart';
import 'package:issue_blog/utils/ui_util.dart';
import 'package:issue_blog/utils/url_util_web.dart';
import 'package:issue_blog/widget/mirages_label_item.dart';
import 'package:issue_blog/widget/pop_route.dart';
import 'package:provider/provider.dart';

class MiragesHead extends StatefulWidget {
  const MiragesHead({Key key}) : super(key: key);

  @override
  _MiragesHeadState createState() => _MiragesHeadState();
}

class _MiragesHeadState extends State<MiragesHead> {
  GlobalKey popKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchLabelList();
    });
  }

  _fetchLabelList() {
    LabelListModel labelListModel = Provider.of<LabelListModel>(context, listen: false);
    if (labelListModel.labelList != null) {
      return;
    }
    GitHubApi.getLabelList().then((labelList) {
      labelListModel.labelList = labelList;
    }).catchError((error) {
      print('获取标签列表失败 $error');
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('获取标签列表失败')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return UIUtil.getWidth(context) <= 700 ? _buildHeadMenu() : _buildHeadBar(context);
  }

  Widget _buildHeadMenu() {
    return ButtonTheme(
      minWidth: 50,
      buttonColor: Colors.black38,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
        onPressed: () => Scaffold.of(context).openDrawer(),
        child: Text(
          "MENU",
          style: TextStyle(color: Colors.white, fontSize: 13),
        ),
      ),
    );
  }

  Container _buildHeadBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white10),
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: UIUtil.getWidth(context) >= 1600 ? 18 : 16),
      height: UIUtil.getWidth(context) >= 1600 ? 81 : 72,
      child: Container(
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      //重置标签
                      RouteUtil.routeToIndex(context, null);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 18, 8),
                      child: Text(
                        Config.BLOG,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily:
                                "Mirages Custom','Merriweather','Open Sans','PingFang SC','Hiragino Sans GB','Microsoft Yahei','WenQuanYi Micro Hei','Segoe UI Emoji','Segoe UI Symbol',Helvetica,Arial,sans-serif"),
                      ),
                    ),
                  ),
                  Consumer<LabelListModel>(builder: (context, labelListModel, _) {
                    return ButtonTheme(
                      minWidth: 65.0,
                      child: FlatButton(
                        onPressed: () => {
                          PopupWindow.showPopWindow(
                              context, popKey, PopDirection.bottom, _showMenu(labelListModel), 5)
                        },
                        padding: EdgeInsets.all(0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "分类",
                              key: popKey,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black.withAlpha(229),
                                  fontWeight: FontWeight.w400,
                                  fontFamily:
                                      "Mirages Custom','Merriweather','Open Sans','PingFang SC','Hiragino Sans GB','Microsoft Yahei','WenQuanYi Micro Hei','Segoe UI Emoji','Segoe UI Symbol',Helvetica,Arial,sans-serif"),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              size: 24,
                              color: Colors.black.withAlpha(159),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                  _buildClickText(() => {}, "友链"),
                  _buildClickText(() => {}, "关于"),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                        onPressed: () {
                          launchURL(context, "https://github.com/appdev/issue_blog");
                        },
                        padding: EdgeInsets.all(8),
                        child: ImageIcon(
                          AssetImage("assets/images/github.png"),
                          color: Colors.black12,
                        ),
                        shape: CircleBorder())
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _showMenu(LabelListModel labelListModel) {
    return Card(
      color: Colors.white,
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: column(labelListModel),
      ),
    );
  }

  Column column(LabelListModel labelListModel) {
    return Column(
      children: labelListModel.labelList.map((label) {
        return Consumer<CurrentLabelModel>(builder: (context, currentLabelModel, _) {
          return MiragesLabelItem(
              label: label,
              selected: label.name == currentLabelModel.currentLabel,
              onSelected: (selected) {
                Navigator.pop(context);
                RouteUtil.routeToIndex(context, label.name);
                currentLabelModel.currentLabel = selected ? label.name : "";
//                streamBus.emit(LabelChangedEvent(currentLabelModel.currentLabel));
              });
        });
      }).toList(),
    );
  }

  Widget _buildClickText(GestureTapCallback callback, String text) {
    return InkWell(
      onTap: callback,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 16,
              color: Colors.black.withAlpha(229),
              fontFamily:
                  "Mirages Custom','Merriweather','Open Sans','PingFang SC','Hiragino Sans GB','Microsoft Yahei','WenQuanYi Micro Hei','Segoe UI Emoji','Segoe UI Symbol',Helvetica,Arial,sans-serif"),
        ),
      ),
    );
  }
}
