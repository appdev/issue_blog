//文字颜色
import 'dart:math';
import 'dart:ui';

import 'package:issue_blog/utils/config.dart';
import 'package:issue_blog/utils/hex_color.dart';
import 'package:issue_blog/utils/string_utils.dart';

class Constant {
  static var _oldTitlePic;

  static String getTitlePic() {
    var size = Random().nextInt(Config.titlePPic.length);
    if (!StringUtil.isEmpty(_oldTitlePic) && _oldTitlePic == Config.titlePPic[size]) {
      return getTitlePic();
    } else {
      _oldTitlePic = Config.titlePPic[size];
      return _oldTitlePic;
    }
  }
}

Color lift_text_Color = HexColor('#4b595f');
