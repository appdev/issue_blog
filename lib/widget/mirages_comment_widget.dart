import 'package:flutter/material.dart';
import 'package:issue_blog/utils/config.dart';
import 'package:issue_blog/utils/date_util.dart';
import 'package:issue_blog/widget/markdown_widget.dart';
import 'package:transparent_image/transparent_image.dart';

class MiragesCommentWidget extends StatelessWidget {
  const MiragesCommentWidget({Key key, @required this.comment}) : super(key: key);

  final Map comment;

  @override
  Widget build(BuildContext context) {
    return showMenuByUser();
  }

  Widget showMenuByUser() {
    return comment['user']['login'] == Config.gitHubUsername
        ? Container(
            padding: EdgeInsets.all(1.5),
            color: Colors.white,
            child: MarkdownWidget(markdown: comment['body']))
        : buildPostContent();
  }

  Widget buildPostContent() {
    return Container(
      padding: EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color.fromARGB(255, 238, 238, 238), width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Container(
            child: ListTile(
              leading: ClipOval(
                  child: FadeInImage.memoryNetwork(
                      width: 40,
                      placeholder: kTransparentImage,
                      image: comment['user']['avatar_url'])),
              title: Text(comment['user']['login']),
              trailing: Text(
                  DateUtil.formatDateStr(comment['created_at'], format: DataFormats.zh_y_mo_d)),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 249, 250, 252),
              border: Border(bottom: BorderSide(color: Color.fromARGB(255, 238, 238, 238))),
            ),
          ),
          Padding(
            child: MarkdownWidget(markdown: comment['body']),
            padding: EdgeInsets.all(10),
          ),
        ],
      ),
    );
  }
}
