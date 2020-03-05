
* 一套代码支持 Android、iOS、Web、Desktop，[点击进行预览](http://issues.bingoogolapple.cn)



## 目录
* [使用方法](#使用方法)


通过 Issues 记录学习笔记的优点：

- [x] 在线编辑和预览，随时添加和提交（不用担心电脑坏了导致笔记丢失）
- [x] 当笔记里到嵌套图片时，支持粘贴屏幕截图和拖拽添加图片
- [x] 带有搜索和排序功能
- [x] 可通过 Label 来对 Issues 进行分类
- [x] 可以把每一个 Comment 作为一个小的知识点不停的追加到 Issue 里
- [x] 结合 GitHub Pages 绑定域名来搭建个人博客站点

## 效果图

Web - PC | Desktop |
| ------------ | ------------ |
| ![web-pc](https://user-images.githubusercontent.com/8949716/67616787-8de05d00-f80f-11e9-9ddf-e75c2f3d619d.png) | ![desktop](https://user-images.githubusercontent.com/8949716/67616799-a5b7e100-f80f-11e9-8079-2d9139fa9689.png) |

| Phone | Phone | Phone |
| ------------ | ------------- | ------------- |
| ![web-phone1](https://user-images.githubusercontent.com/8949716/67147761-6b5bba80-f2ca-11e9-9839-92225c06a3f9.jpeg) | ![web-phone2](https://user-images.githubusercontent.com/8949716/67147762-6f87d800-f2ca-11e9-9dcf-5ec8a32dab4a.jpeg) | ![web-phone3](https://user-images.githubusercontent.com/8949716/67147763-73b3f580-f2ca-11e9-8b52-e51cc10397c5.jpeg) |

## 使用方法

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
dart build_web_preview.dart
```
> 2.发布

```
拷贝「issue_blog/docs」目录里的所有文件到「GitHub Pages」的根目录下
并将「GitHub Pages」仓库 PUSH 到 GitHub 上
```

#### 绑定域名到 GitHub Pages

> 1.在「GitHub Pages」根目录下添加文件名为「CNAME」的文件，文件内容就是你的二级域名，例如我的是

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



## License

    Copyright 2016 bingoogolapple

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
