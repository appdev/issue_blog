import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:issue_blog/page/blog_detail_page.dart';
import 'package:issue_blog/page/web_blog_detail_mirages_page.dart';
import 'package:issue_blog/page/web_home_mirages_page.dart';
import 'package:issue_blog/utils/url_util.dart';

abstract class RouteUtil {
  static final _router = Router();
  static String _initHashRoute;

// 定义路由信息
  static final Map<String, Function> routes = {
    '/post': (context, {issue}) => WebBlogDetailMiragesPage(issue: issue)
  };

  static init() {
    //blog details
    _router.define('/blog/:number', handler: Handler(handlerFunc: (context, params) {
      return BlogDetailPage(number: int.parse(params['number'][0]));
    }), transitionType: TransitionType.cupertino);
    //blog Mirages details
    _router.define('/post/:issue', handler: Handler(handlerFunc: (context, params) {
      return WebBlogDetailMiragesPage(issue: params['issue'][0]);
    }), transitionType: TransitionType.cupertino);

    _router.define('/', handler: Handler(handlerFunc: (context, params) {
      return WebHomeMiragesPage();
    }), transitionType: TransitionType.cupertino);

    final String urlHash = getUrlHash();
    if (urlHash == null || urlHash.isEmpty || urlHash == '/') {
      return;
    }
    _initHashRoute = urlHash;
  }

  // 跳转到浏览器路由 hash
  static handleGoInitHashRoute(BuildContext context) {
    if (_initHashRoute == null) {
      return;
    }
    _router.navigateTo(context, _initHashRoute);
    _initHashRoute = null;
  }

  static routeToBlogDetail(context, number) {
    _router.navigateTo(context, '/blog/$number');
  }

  static routeToBlogMiragesDetail(context, issue) {
//    Navigator.pushNamed(context, '/post', arguments: {"issue": issue});
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new WebBlogDetailMiragesPage(issue: issue),
      ),
    );
//    _router.navigateTo(context, '/post/$issue');
  }

  static routeToBlogIndex(context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (BuildContext context) => WebHomeMiragesPage()),
      (Route<dynamic> route) => false,
    );
  }

//  static pushWithSwipeBackTransition(BuildContext context, Widget page) {
//    // 使用 CupertinoPageRoute 支持滑动返回
//    Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
//      return page;
//    }));
//  }
//
//  // 自带的不支持路径参数
//  static pushNamed(BuildContext context, String routeName, {Object arguments}) {
//    Navigator.pushNamed(context, routeName, arguments: arguments);
//  }
//
//  static pushWithFadeTransition(BuildContext context, Widget page) {
//    Navigator.of(context).push(PageRouteBuilder(
//        opaque: false,
//        pageBuilder: (BuildContext context, _, __) {
//          return page;
//        },
//        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
//          return _transition(animation, child);
//        }));
//  }
//
//  static FadeTransition _transition(Animation<double> animation, Widget child) {
//    return FadeTransition(
//      opacity: animation,
//      child: FadeTransition(
//        opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
//        child: child,
//      ),
//    );
//  }
}

// Navigator.push 时的 context 参数不能是首屏 Widget 的 context
class AdaptiveWebInitHashWidget extends StatefulWidget {
  @override
  _AdaptiveWebInitHashWidgetState createState() => _AdaptiveWebInitHashWidgetState();
}

class _AdaptiveWebInitHashWidgetState extends State<AdaptiveWebInitHashWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      RouteUtil.handleGoInitHashRoute(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
