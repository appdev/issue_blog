import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:issue_blog/datatransfer/data_model.dart';
import 'package:issue_blog/datatransfer/events.dart';
import 'package:issue_blog/dto/label.dart';
import 'package:issue_blog/utils/hex_color.dart';
import 'package:issue_blog/utils/route_util.dart';
import 'package:issue_blog/utils/ui_util.dart';
import 'package:issue_blog/widget/label_item.dart';
import 'package:provider/provider.dart';

class IssueItem extends StatelessWidget {
  const IssueItem({Key key, this.issue}) : super(key: key);

  final issue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        title: _buildTitle(context),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 60),
          child: Text(DateTime.tryParse(issue['created_at'])
              .toString()
              .substring(0, "yyyy-MM-dd HH:mm".length)),
        ),
        onTap: () => junpToPostDetails(context),
      ),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFeeeeee))),
      ),
    );
  }

  void junpToPostDetails(BuildContext context) {
    return UIUtil.isPhoneStyle(context)
        ? RouteUtil.routeToBlogDetail(context, issue['number'])
        : streamBus.emit(BlogContentChangeEvent(false, issue['number']));
  }

  Widget _buildTitle(BuildContext context) {
    // Web 还不支持选择复制，Android、iOS 可以，但点击空白区域时，拷贝、全选浮窗不会自动消失
//    if (kIsWeb) {
//      return GestureDetector(
//        child: Text(issue['title']),
////        onTap: () => RouteUtil.pushWithSwipeBackTransition(context, BlogDetailPage(number: issue['number'])),
////        onTap: () => Navigator.pushNamed(context, '/blog', arguments: issue['number']),
//        onTap: () => RouteUtil.routeToBlogDetail(context, issue['number']),
//      );
//    }
    var label = Label.fromJsonList(issue['labels']);
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
          flex: 0,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(60, 0, 40, 0),
            child: InkWell(
              onTap: () => junpToPostDetails(context),
//              toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
              child: Text(
                issue['title'],
//                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(color: HexColor("#4b595f"), fontSize: 15),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Offstage(
              offstage: UIUtil.isPhoneStyle(context),
              child: Wrap(
                  spacing: -10,
                  runSpacing: 1,
                  verticalDirection: VerticalDirection.down,
                  alignment: WrapAlignment.start,
                  children: label.map((label) {
                    return Consumer<CurrentLabelModel>(builder: (context, currentLabelModel, _) {
                      return LabelItem(
                          label: label,
                          selected: label.name == currentLabelModel.currentLabel,
                          onSelected: (selected) {
                            currentLabelModel.currentLabel = selected ? label.name : null;
                            streamBus.emit(LabelChangedEvent(currentLabelModel.currentLabel));
                          },
                          miniSize: true);
                    });
                  }).toList()),
            ),
          ),
        )
      ],
    );
  }
}
