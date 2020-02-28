class Config {
  // 配置个人 GitHub 名称
  static final gitHubUsername = 'bingoogolapple';

  // 根据 GitHub 名称自动组装存放 issues 的仓库
  static final repo = '$gitHubUsername/$gitHubUsername.github.io';

  // 配置个人链接图片映射
  static final personalLinkMap = {
    'assets/images/github.png': 'https://github.com/$gitHubUsername',
    'assets/images/git.png': 'https://git-scm.com/',
  };

  //blog 名称
//  static String BLOG = gitHubUsername + "'s Blog";
  static String BLOG = "LengYue's Blog";

  //GitHub home
  static const String github_home = "https://github.com/appdev";

  //自己博客的url
  static const String web_url = "https://apkdv.com";

  static const List<String> titlePPic = [
    "https://anseong.cc/usr/uploads/2019/04/1653621579.jpg",
    "https://c0smx.lajiya.cn/archives/934/0.jpg",
    "https://cdn.fyun.org/blog/typecho/christian-wiediger-c3ZWXOv1Ndc-unsplash.jpg",
    "https://cdn.fyun.org/blog/typecho/nasa-53884-unsplash.jpg",
    "https://static.apkdv.com/blog_cover/5b1a517dd5e69.jpg",
    "https://static.apkdv.com/blog_cover/message-in-a-bottle-3437294_1920.jpg"
  ];
  //博客首页背景图
  static const String BLOG_PIC = "https://static.apkdv.com/blog_cover/5b1a517dd5e69.jpg";
}
