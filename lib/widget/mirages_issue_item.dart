import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:issue_blog/dto/label.dart';
import 'package:issue_blog/utils/route_util.dart';
import 'package:issue_blog/utils/ui_util.dart';

class MiragesIssueItem extends StatelessWidget {
  const MiragesIssueItem({Key key, this.issue}) : super(key: key);

  final issue;

  //1260 padding 20 688* 248
  //700 padding 16 height 168
  //1600 padding 20 832* 248
  //1700 padding 20 860* 279
  static var url = "https://static.apkdv.com/blog_cover/message-in-a-bottle-3437294_1920.jpg";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(UIUtil.getIssueItemWidth(context)[0].toDouble()),
      child: InkWell(
        onTap: () => RouteUtil.routeToBlogDetail(context, issue['number']),
        child: Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          width: UIUtil.getIssueItemWidth(context)[1] == 0
              ? UIUtil.getWidth(context)
              : UIUtil.getIssueItemWidth(context)[1].toDouble(),
          height: UIUtil.getIssueItemWidth(context)[2].toDouble(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTitle(context),
              Text(DateTime.tryParse(issue['created_at'])
                  .toString()
                  .substring(0, "yyyy-MM-dd HH:mm".length))
            ],
          ),
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    var label = Label.fromJsonList(issue['labels']);
    return GestureDetector(
      onTap: () => RouteUtil.routeToBlogDetail(context, issue['number']),
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
