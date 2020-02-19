import 'package:flutter/material.dart';
import 'package:issue_blog/datatransfer/data_model.dart';
import 'package:issue_blog/utils/hex_color.dart';
import 'package:issue_blog/widget/about_me_widget.dart';
import 'package:issue_blog/widget/blog_content.dart';
import 'package:issue_blog/widget/label_list.dart';
import 'package:issue_blog/widget/left_widget.dart';
import 'package:issue_blog/widget/page_widget.dart';
import 'package:issue_blog/widget/search_widget.dart';
import 'package:provider/provider.dart';

class WebHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Expanded(flex: 1, child: LeftWidget()),
          Container(
            width: 1,
            color: HexColor("#eeeeee"),
          ),
          Expanded(flex: 4, child: _buildRightWidget()),
        ],
      ),
    );
  }

  Widget _buildRightWidget() {
    return Consumer<CheckedMenuModel>(builder: (context, checkedMenuModel, child) {
      if (checkedMenuModel.isAboutMeChecked) {
        return AboutMePage();
      }
      return Column(
        children: [
          LabelList(),
          Divider(
            height: 1,
            color: HexColor("#eeeeee"),
          ),
          Container(
            height: 50,
            padding: EdgeInsets.fromLTRB(60, 0, 60, 0),
            color: HexColor("#f9fafc"),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "名称",
                          style: TextStyle(color: HexColor("#a3b4bc"), fontSize: 12),
                        ),
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "时间",
                        style: TextStyle(color: HexColor("#a3b4bc"), fontSize: 12),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            height: 1,
            color: HexColor("#eeeeee"),
          ),
          Expanded(child: BlogContent(showList: true)),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SearchWidget(),
                ),
                SizedBox(width: 20),
                PageWidget(),
              ],
            ),
          ),
        ],
      );
    });
  }
}
