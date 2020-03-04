import 'package:flutter/material.dart';
import 'package:issue_blog/datatransfer/data_model.dart';
import 'package:issue_blog/datatransfer/events.dart';
import 'package:issue_blog/net/github_api.dart';
import 'package:issue_blog/utils/config.dart';
import 'package:issue_blog/utils/route_util.dart';
import 'package:issue_blog/utils/ui_util.dart';
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
  CurrentLabelModel _currentLabelModel;

  @override
  void initState() {
    super.initState();
    _currentLabelModel = Provider.of<CurrentLabelModel>(context, listen: false);

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
    return _buildHeadBar(context);
  }

  Container _buildHeadBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withAlpha(150), boxShadow: [
        BoxShadow(
            color: Color(0xFFf4f4f4).withAlpha(150),
            offset: Offset(0, UIUtil.getWidth(context) >= 1600 ? 89 : 70))
      ]),
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
                      RouteUtil.routeToBlogIndex(context,null);
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
              child: Container(),
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
                currentLabelModel.currentLabel = selected ? label.name : null;
                streamBus.emit(LabelChangedEvent(currentLabelModel.currentLabel));
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
