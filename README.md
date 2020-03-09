
* 一套代码支持 Android、iOS、Web、Desktop，[点击进行预览](https://appdev.github.io/)




## 效果图

Web - 首页 | 内容页 |
| ------------ | ------------ |
| ![web-index](Screenshot/2.png) | ![web-index](Screenshot/4.png) |

| Phone | Phone | Phone |
| ------------ | ------------- | ------------- |
| ![web-phone1](Screenshot/1.png) | ![web-phone2](Screenshot/3.png) | ![web-phone3](Screenshot/5.png) |

## 使用方法

#### 分类、评论

使用issue label作为分类标签
关于评论：
因为flutter web 现在还不能使用社会化评论 所以目前评论功能缺失。
考虑使用某个社会化评论接口来实现


#### 本地运行

> 1.安装依赖

```
flutter pub get
```
> 2.在浏览器中运行

```
flutter run -d chrome
```
> 3.修改个人配置「issue_blog/lib/utils/config.dart」

```dart
class Config {
  // 配置个人 GitHub 名称
  static final gitHubUsername = 'appdev';

  // 根据 GitHub 名称自动组装存放 issues 的仓库
  static final repo = '$gitHubUsername/$gitHubUsername.github.io';

  // 配置个人链接图片映射
  static final personalLinkMap = {
    'images/github.png': 'https://github.com/appdev',
    'images/git.png': ,
  };

}
```

#### 发布到 GitHub Pages

> 1.打包

```
flutter build web
```
> 2.发布

```
拷贝「./build/web」目录里的所有文件到「GitHub Pages」的根目录下
并将「GitHub Pages」仓库 PUSH 到 GitHub 上
```

#### 绑定域名到 GitHub Pages

> 1.在「GitHub Pages」根目录下添加文件名为「CNAME」的文件，文件内容就是你的二级域名

```
www.appdev.cn
```
> 2.登录你的域名控制台添加域名解析

```
「记录类型」选择「CNAME」
「主机记录」填「www」
「记录值」填「GitHub用户名.github.io」，例如我的是「appdev.github.io」
```

> 3.发布文章

直接在gitHubUsername.github.io 仓库的issue中写文章

### 存在的问题

 flutter web 不能像普通网页一样复制！！！！ 目前还没有好的解决办法


## License

    Copyright 2016 appdev

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
