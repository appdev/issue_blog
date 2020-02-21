import 'package:flutter/material.dart';
import 'package:issue_blog/datatransfer/data_model.dart';
import 'package:issue_blog/net/github_api.dart';
import 'package:issue_blog/utils/config.dart';
import 'package:issue_blog/utils/route_util.dart';
import 'package:issue_blog/utils/ui_util.dart';
import 'package:issue_blog/widget/common_widget.dart';
import 'package:provider/provider.dart';

class MiragesHead extends StatefulWidget {
  const MiragesHead({Key key}) : super(key: key);

  @override
  _MiragesHeadState createState() => _MiragesHeadState();
}

class _MiragesHeadState extends State<MiragesHead> {
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
      var label = labelList;
//      label.addAll(labelList);
      labelListModel.labelList = label;
    }).catchError((error) {
      print('获取标签列表失败 $error');
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('获取标签列表失败')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LabelListModel>(builder: (context, labelListModel, _) {
      if (labelListModel.labelList == null) {
        return LoadingWidget();
      }
//      if (labelListModel.labelList.isEmpty) {
//        return EmptyWidget('没有分类');
//      }
      return _buildHeadBar(context);
    });
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
                    onTap: () => RouteUtil.routeToBlogIndex(context),
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
                  _buildClickText(() => {}, "友链"),
                  _buildClickText(() => {}, "关于")
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            )
//            Wrap(
//                spacing: 8,
//                runSpacing: 8,
//                verticalDirection: VerticalDirection.down,
//                alignment: WrapAlignment.start,
//                children: labelListModel.labelList.map((label) {
//                  return Consumer<CurrentLabelModel>(builder: (context, currentLabelModel, _) {
//                    return LabelItem(
//                      label: label,
//                      selected: label.name == currentLabelModel.currentLabel,
//                      onSelected: (selected) {
//                        currentLabelModel.currentLabel = selected ? label.name : null;
//                        streamBus.emit(LabelChangedEvent(currentLabelModel.currentLabel));
//                      },
//                      miniSize: false,
//                    );
//                  });
//                }).toList()),
          ],
        ),
      ),
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
              fontSize: 14,
              color: Colors.black,
              fontFamily:
                  "Mirages Custom','Merriweather','Open Sans','PingFang SC','Hiragino Sans GB','Microsoft Yahei','WenQuanYi Micro Hei','Segoe UI Emoji','Segoe UI Symbol',Helvetica,Arial,sans-serif"),
        ),
      ),
    );
  }
}
