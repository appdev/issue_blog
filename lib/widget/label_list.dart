import 'package:flutter/material.dart';
import 'package:issue_blog/datatransfer/data_model.dart';
import 'package:issue_blog/datatransfer/events.dart';
import 'package:issue_blog/net/github_api.dart';
import 'package:issue_blog/widget/common_widget.dart';
import 'package:issue_blog/widget/label_item.dart';
import 'package:provider/provider.dart';

class LabelList extends StatefulWidget {
  const LabelList({Key key}) : super(key: key);

  @override
  _LabelListState createState() => _LabelListState();
}

class _LabelListState extends State<LabelList> {
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
                  return LabelItem(
                    label: label,
                    selected: label.name == currentLabelModel.currentLabel,
                    onSelected: (selected) {
                      currentLabelModel.currentLabel = selected ? label.name : null;
                      streamBus.emit(LabelChangedEvent(currentLabelModel.currentLabel));
                    },
                    miniSize: false,
                  );
                });
              }).toList()),
        ),
      );
    });
  }
}
