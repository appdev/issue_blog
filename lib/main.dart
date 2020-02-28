import 'package:flutter/material.dart';
import 'package:issue_blog/datatransfer/data_model.dart';
import 'package:issue_blog/page/web_home_mirages_page.dart';
import 'package:issue_blog/utils/config.dart';
import 'package:issue_blog/utils/platform_util.dart';
import 'package:issue_blog/utils/route_util.dart';
import 'package:provider/provider.dart';

void main() {
  init();
  runApp(BlogApp());
}

void init() {
  initTargetPlatform();
  RouteUtil.init();
//  setErrorPage();
}

void setErrorPage() {
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    print(flutterErrorDetails.toString());
    return Scaffold(
      body: Center(child: Text(Config.BLOG + " 开小差了,请重启 App！", style: TextStyle(fontSize: 20))),
    );
  };
}

class BlogApp extends StatefulWidget {
  @override
  _BlogAppState createState() => _BlogAppState();
}

class _BlogAppState extends State<BlogApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_) => PageModel()),
        ChangeNotifierProvider(builder: (_) => KeywordModel()),
        ChangeNotifierProvider(builder: (_) => UserInfoModel()),
        ChangeNotifierProvider(builder: (_) => CheckedMenuModel()),
        ChangeNotifierProvider(builder: (_) => CurrentLabelModel()),
        ChangeNotifierProvider(builder: (_) => LabelListModel()),
        ChangeNotifierProvider(builder: (_) => IssueListModel()),
        ChangeNotifierProvider(builder: (_) => AboutMeModel()),
        ChangeNotifierProvider(builder: (_) => HitokotoModel()),
      ],
      // 跳转到其他页面后如果不想展示返回按钮，可以把 MaterialApp 再作为他页面的根 Widget
      child: MaterialApp(
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          // 统一处理
          final String name = settings.name;
          final Function pageContentBuilder = RouteUtil.routes[name];
//          if (pageContentBuilder != null) {
          final Route route = MaterialPageRoute(
            builder: (context) {
              //将RouteSettings中的arguments参数取出来，通过构造函数传入
              return pageContentBuilder(context, arguments: settings.arguments);
            },
            settings: settings,
          );
          return route;
//          }
        },
        debugShowCheckedModeBanner: false,
        title: Config.gitHubUsername + "'s Blog",
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            backgroundColor: Colors.white,
            fontFamily:
                "Mirages Custom','Merriweather','Open Sans','PingFang SC','Hiragino Sans GB','Microsoft Yahei','WenQuanYi Micro Hei','Segoe UI Emoji','Segoe UI Symbol',Helvetica,Arial,sans-serif"),
        // Flutter 默认支持横屏和竖屏，可以通过 SystemChrome.setPreferredOrientations 设置支持的屏幕方向，不能再 main 方法中设置
        // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        // 获取屏幕方向-方式一 OrientationBuilder 感知屏幕旋转
        // 获取屏幕方向-方式二 MediaQuery.of(context).orientation
        home: Stack(children: [
          AdaptiveWebInitHashWidget(),
          OrientationBuilder(
            builder: (context, orientation) {
              return WebHomeMiragesPage();
//              if (UIUtil.isPhoneStyle(context)) {
//                return PhoneHomePage();
//              } else {
//                return WebHomePage();
//              }
            },
          )
        ]),
      ),
    );
  }
}
