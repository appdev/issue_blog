import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:issue_blog/widget/label_list.dart';
import 'package:issue_blog/widget/mirages_issue_list.dart';

class WebHomeMiragesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: <Widget>[
//            _buildStickyBar(),
            SliverList(
                delegate: SliverChildBuilderDelegate(
              (context, index) => index == 0 ? LabelList() : MiragesIssueList(),
              childCount: 2,
            ))
//            SliverFillRemaining(child: _buildRightWidget()),
          ],
        ));
  }

  Widget _buildRightWidget() {
    return Column(
      children: [
        LabelList(),
        Expanded(child: MiragesIssueList()),
//        Padding(
//          padding: EdgeInsets.all(10),
//          child: Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: [
//              Expanded(
//                child: SearchWidget(),
//              ),
////              SizedBox(width: 20),
////              PageWidget(),
//            ],
//          ),
//        ),
      ],
    );
  }
}

Widget _buildStickyBar() {
  return SliverPersistentHeader(
      pinned: true, //是否固定在顶部
      floating: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 80, //收起的高度
        maxHeight: 80, //展开的最大高度
        child: Stack(
          children: <Widget>[
            Container(
              height: 80,
            ),
            BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: new Container(
                height: 80,
                color: Colors.white.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ));
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
