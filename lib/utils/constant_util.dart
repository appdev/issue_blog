//文字颜色
import 'dart:math';
import 'dart:ui';

import 'package:issue_blog/utils/config.dart';
import 'package:issue_blog/utils/hex_color.dart';

class Constant {
  static String getTitlePic() {
    var size = Random().nextInt(Config.titlePPic.length);
//    print(size);
    return Config.titlePPic[size];
  }
}

Color lift_text_Color = HexColor('#4b595f');
