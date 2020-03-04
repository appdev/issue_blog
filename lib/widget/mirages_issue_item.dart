import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:issue_blog/dto/label.dart';
import 'package:issue_blog/utils/date_util.dart';
import 'package:issue_blog/utils/route_util.dart';
import 'package:issue_blog/utils/ui_util.dart';

class MiragesIssueItem extends StatelessWidget {
  const MiragesIssueItem({Key key, this.issue}) : super(key: key);

  final issue;

  //1260 padding 20 688* 248
  //700 padding 16 height 168
  //1600 padding 20 832* 248
  //1700 padding 20 860* 279

  @override
  Widget build(BuildContext context) {
    var label = (issue['labels']).toString().isNotEmpty
        ? ("・" +
            Label.fromJsonList(issue['labels'])
                .map((e) => e.name)
                .toList()
                .toString()
                .replaceAll("[", "")
                .replaceAll("]", ""))
        : "";
    var sizeList = UIUtil.getIssueItemWidth(context);
    return Padding(
      padding: EdgeInsets.all(sizeList[0].toDouble()),
      child: InkWell(
        onTap: () => RouteUtil.routeToBlogMiragesDetail(context, issue),
        child: Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          width: sizeList[1] == 0 ? UIUtil.getWidth(context) : sizeList[1].toDouble(),
          height: sizeList[2].toDouble(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTitle(context),
              Text(
                DateUtil.formatDateStr(issue['created_at'], format: DataFormats.zh_y_mo_d) + label,
                style: TextStyle(color: Colors.white, fontSize: sizeList[4].toDouble()),
              )
            ],
          ),
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(issue["html_url"]), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return GestureDetector(
      onTap: () => RouteUtil.routeToBlogMiragesDetail(context, issue),
//              toolbarOptions: ToolbarOptions(copy: true, selectAll: true),
      child: Text(
        issue['title'],
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontSize: UIUtil.getIssueItemWidth(context)[3].toDouble()),
      ),
    );
  }
}
