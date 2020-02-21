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
  static String BLOG = gitHubUsername + "'s Blog";

  //GitHub home
  static const String github_home = "https://github.com/appdev";
  //自己博客的url
  static const String web_url = "https://apkdv.com";
}
