import 'package:flutter/material.dart';
import 'package:issue_blog/datatransfer/data_model.dart';
import 'package:issue_blog/net/github_api.dart';
import 'package:issue_blog/utils/ui_util.dart';
import 'package:provider/provider.dart';

class MiragesPostTitle extends StatefulWidget {
  final String title;
  final String subTitle;
  final bool userHitokoto;
  final String titlePic;

  MiragesPostTitle({this.title, this.subTitle, this.userHitokoto, this.titlePic});

  @override
  _MiragesPostTitleState createState() => _MiragesPostTitleState();
}

class _MiragesPostTitleState extends State<MiragesPostTitle> {
  HitokotoModel _hitokotoModel;

  @override
  void initState() {
    super.initState();
    //回复一言
    _hitokotoModel = Provider.of<HitokotoModel>(context, listen: false);
    if (_hitokotoModel.hitokotoData == null && widget.userHitokoto) {
      _fetchHitokoto();
    }
  }

  _fetchHitokoto() {
    return GitHubApi.getHitokoto().then((data) {
      if (data != null) {
        _hitokotoModel.hitokotoData = data;
      }
    }).catchError((error) {
      print('获取一言失败');
      _hitokotoModel.hitokotoData = "皆是孤芳，即是孤芳，但求自赏便罢！";
      Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('获取一言失败')));
    }).whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.userHitokoto ? 357 : 458,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: UIUtil.getWidth(context) >= 1600 ? 81 : 72),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildTitle(context),
          SizedBox(
            height: 12,
          ),
          widget.userHitokoto ? buildHitokotoWidget() : buildText(widget.subTitle)
        ],
      ),
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(widget.titlePic), fit: BoxFit.cover),
      ),
    );
  }

  Consumer<HitokotoModel> buildHitokotoWidget() {
    return Consumer<HitokotoModel>(builder: (context, hitokotoModel, _) {
      return buildText(hitokotoModel.hitokotoData == null ? "" : hitokotoModel.hitokotoData);
    });
  }

  Text buildText(String str) {
    return Text(
      str,
      style: TextStyle(color: Colors.white, fontSize: 15),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      widget.title,
      overflow: TextOverflow.ellipsis,
      softWrap: true,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w300,
          fontSize: UIUtil.getWidth(context) > 700 ? 40 : 28),
    );
  }
}
