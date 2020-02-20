import 'package:flutter/material.dart';
import 'package:issue_blog/datatransfer/events.dart';
import 'package:issue_blog/utils/base_state.dart';
import 'package:issue_blog/utils/hex_color.dart';

class WebTitleStatus extends StatefulWidget {
  const WebTitleStatus({Key key}) : super(key: key);

  @override
  _WebTitleState createState() => _WebTitleState();
}

class _WebTitleState extends BaseState<WebTitleStatus> {
  String _postTitle = "";

  @override
  void initState() {
    super.initState();
    addSubscription(streamBus.on<BlogContentChangeEvent>().listen((event) {
      print(event);
      setState(() {
        _postTitle = event.postTitle;
      });
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Row(
                children: <Widget>[
                  Text(
                    _postTitle.isEmpty ? "名称" : _postTitle,
                    style: TextStyle(
                        color: _postTitle.isEmpty ? HexColor("#a3b4bc") : HexColor("#4b595f"),
                        fontSize: _postTitle.isEmpty ? 12 : 22),
                  ),
                ],
              )),
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                _postTitle.isEmpty
                    ? Text(
                        "时间",
                        style: TextStyle(color: HexColor("#a3b4bc"), fontSize: 12),
                      )
                    : InkWell(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.keyboard_backspace, color: HexColor("#4b595f")),
                            Text("返回", style: TextStyle(color: HexColor("#4b595f"), fontSize: 14))
                          ],
                        ),
                        onTap: () => streamBus.emit(BlogContentChangeEvent(
                          showList: true,
                        )),
                      )
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 249, 250, 252),
        border: Border(
            bottom: BorderSide(color: Color.fromARGB(255, 238, 238, 238)),
            top: BorderSide(color: Color.fromARGB(255, 238, 238, 238))),
      ),
    );
  }
}
