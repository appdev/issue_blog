import 'package:flutter/material.dart';

class MiragesPostTitle extends StatefulWidget {
  const MiragesPostTitle({Key key}) : super(key: key);

  @override
  _MiragesPostTitleState createState() => _MiragesPostTitleState();
}

class _MiragesPostTitleState extends State<MiragesPostTitle> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 376,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage("https://static.apkdv.com/blog_cover/5b1a517dd5e69.jpg"),
            fit: BoxFit.cover),
      ),
    );
  }
}
