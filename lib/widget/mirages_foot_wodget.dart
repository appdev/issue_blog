import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:issue_blog/utils/config.dart';
import 'package:issue_blog/utils/hex_color.dart';
import 'package:issue_blog/utils/url_util_web.dart';

class MiragesFoot extends StatelessWidget {
  const MiragesFoot({Key key, this.issue}) : super(key: key);

  final issue;

  //Copyright © 2020 LengYues'Blog • Powered by Typecho • Theme Mirages
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      color: Color(0xFFfafafa),
      alignment: Alignment.center,
      child: RichText(
          text: TextSpan(children: [
        TextSpan(
            text: "Copyright © 2020 ", style: TextStyle(fontSize: 13, color: HexColor("#333333"))),
        TextSpan(
            text: Config.BLOG,
            style: TextStyle(fontSize: 13, color: HexColor("#1abc9c")),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchURL(context, Config.web_url);
              }),
        TextSpan(
            text: " • Powered by Github Page • Theme ",
            style: TextStyle(fontSize: 13, color: HexColor("#333333"))),
        TextSpan(
            text: "Mirages",
            style: TextStyle(fontSize: 13, color: HexColor("#1abc9c")),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchURL(context, Config.github_home);
              }),
      ])),
    );
  }
}
