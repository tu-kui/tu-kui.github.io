---
# 标题
title: 静态博客搭建备忘
# 副标题
description: 搭建这个博客踩了不少坑
#发布时间 必须精确到秒 否则不显示
date: 2022-09-25 12:00:11
# 文章头图
image: 
# 留空会默认使用CC BY-NC-SA 4.0
license:
# 隐藏
hidden: false
# 评论
comments: false
# 草稿
draft: false
# 分类
categories: ["折腾"]
# 标签 ["总结","免费","IDE"]
tags: ["备忘"]
# 最后更新时间
lastmod: 2022-09-25 19:12:22
---

## 选择Hugo的原因

选择Hugo主要是听说生成速度非常快（目前写的太少没啥特别感觉）。

也有一部分是因为它只需要二进制文件就可以生成，不需要安装额外的东西。

另外，构建的需要删除后再次构建，以免出问题（这是官网文档写着的）。

## 选择和安装主题以及自定义

### 选择主题选择的不仅仅是外观

在开始使用主题之前，我还没意识到选择主题不仅仅是选择喜欢的外观。

不同的主题自带的文档详细程度，有没有中文文档影响了主题的使用难度。

（对于我这种有一定折腾能力但不是相关从业程序员的人来说。）

花费了不少时间在搜索应该怎么使用我选择的主题上。

还好选择的不是什么小众主题，搜到了不少用户分享的有用内容。

### 安装主题的小细节

对于不是程序员的我来说，我真的对git完全不熟悉。

一开始看见主题安装说明写着没给站点使用git就使用 git clona 安装主题就这么做了，事后才发现不应该这样。

应该先在站点根目录使用执行 git init 命令。

然后使用 git submodule add 安装主题。

这对之后部署来说有好处。

配合不修改主题本身的自定义，可以在之后方便的更新主题。

### 自定义可以不修改主题本身

Hugo会优先读取站点根目录下的，这意味着可以不修改主题的情况下进行自定义。

也方便以后更新主题什么的。

### 补上Stack主题缺失的汉化

#### 其一

Stack主题底部的 Built with Hugo 和点进分类后看见的 PAGE 。

在站点根目录新建i18n\zh-cn.yaml。里面写入下面这段就可以汉化了。

```yaml
list:
    page:
        one: "{{ .Count }} 页"
        other: "{{ .Count }} 页"

footer:
    builtWith:
        other: 使用 {{ .Generator }} 搭建
```

#### 其二

Stack主题的exampleSite（示例站点）中左侧菜单中归档顶部显示categories（没有汉化文件）。

在站点根目录新建content\categories\\_index.md。里面写入下面这段就可以汉化了。

```
---
title: 分类
---
```

同理，点击标签进去看见的 tags 也可以这么做。

在站点根目录新建content\tags\\_index.md。里面写入下面这段就可以汉化了。

```
---
title: 标签
---
```

### 设置时区以避免文章不渲染

在站点根目录的config.yml里加上下面这段。

```yml
# 设置时区 避免文章不渲染
timeZone: "Asia/Shanghai"
```

### 美化

#### 全局使用自定义字体

Stack主题在中文下的默认字体效果不太行，于是搜索一番后搜到了怎么全局使用自定义字体。

实际上搜到了好几种做法，不过我感觉下面这个方法最省事。

我直接给出他的原文和链接，以方便阅读。

<https://blog.gezi.men/p/hugo-custom-global-font/>

---以下是出处原始内容---

这里采用的是思源宋体，可自行更换其他字体

* 字体样式：<https://fonts.googleapis.com/css2?family=Noto+Serif+SC:wght@400;700&display=swap>

* 字体名：Noto Serif SC，即上方链接中family=后的字符串，+替换为空格

在站点根目录新建文件 ./layouts/partials/head/custom.html，内容如下：

```html
<style>
  :root {
    --sys-font-family: "Noto Serif SC";
    --zh-font-family: "Noto Serif SC";
    --base-font-family: "Noto Serif SC";
    --code-font-family: "Noto Serif SC";
    --article-font-family: "Noto Serif SC";
  }
</style>

<script>
  (function () {
    const customFont = document.createElement("link");
    customFont.href =
      "https://fonts.googleapis.com/css2?family=Noto+Serif+SC:wght@400;700&display=swap";

    customFont.type = "text/css";
    customFont.rel = "stylesheet";

    document.head.appendChild(customFont);
  })();
</script>
```
---以上是出处原始内容---

#### 把头像区域居中

如果是昵称之类比较长的用户，可能感觉默认的视觉效果还不错。

但是对于我这种昵称等都很短的用户就看起来不太行了。

1. 在站点根目录新建assets\scss\partials。

2. 复制themes\hugo-theme-stack\assets\scss里的menu.scss和sidebar.scss。

3. 粘贴刚刚复制的到站点根目录的assets\scss\partials。

4. 修改站点根目录下assets\scss\partials\menu.scss。

下面那段是部分代码，只需要修改带注释的行，其他是原代码。

```scss
.social-menu {
    list-style: none;
    padding: 0;
    margin: 0 auto; // 社交图标居中
    display: flex;
    flex-direction: row;
    gap: 10px;

    svg {
        width: 24px;
        height: 24px;
        stroke: var(--body-text-color);
        stroke-width: 1.33;
    }
}
```

5. 修改站点根目录下assets\scss\partials\sidebar.scss。

下面那段是部分代码，只需要修改带注释的行，其他是原代码。

```scss
.sidebar header {
    z-index: 1;
    transition: box-shadow 0.5s ease;
    display: flex;
    flex-direction: column;
    gap: var(--sidebar-element-separation);

    @include respond(md) {
        padding: 0;
    }

    .site-avatar {
        position: relative;
        margin: 0 auto; // 站点头像居中
        width: var(--sidebar-avatar-size);
        height: var(--sidebar-avatar-size);
        flex-shrink: 0;

        .site-logo {
            width: 100%;
            height: 100%;
            border-radius: 100%;
            box-shadow: var(--shadow-l1);
        }

        .emoji {
            position: absolute;
            width: var(--emoji-size);
            height: var(--emoji-size);
            line-height: var(--emoji-size);
            border-radius: 100%;
            bottom: 0;
            right: 0;
            text-align: center;
            font-size: var(--emoji-font-size);
            background-color: var(--card-background);
            box-shadow: var(--shadow-l2);
        }
    }

    .site-meta {
        display: flex;
        flex-direction: column;
        gap: 10px;
        justify-content: center;
    }

    .site-name {
        color: var(--accent-color);
        margin: 0 auto; // 站点名称文本居中
        font-size: 1.6rem;

        @include respond(2xl) {
            font-size: 1.8rem;
        }
    }

    .site-description {
        color: var(--body-text-color);
        font-weight: normal;
        margin: 0 auto; // 站点描述文本居中
        font-size: 1.4rem;

        @include respond(2xl) {
            font-size: 1.6rem;
        }
    }
}
```

#### 让文章右边目录不显示莫名奇妙的序号

在站点根目录config.yml中参考下面这段里的注释设置。

```yml
markup:
    goldmark:
        renderer:
            ## Set to true if you have HTML content inside Markdown
            unsafe: false
    # 设置文章右边目录
    tableOfContents:
        # 目录标题结束级别
        endLevel: 4
        # 目录标题前是否使用序号
        ordered: false
        # 目录标题开始级别 2就已经和文章标题一样大了
        startLevel: 2
```

## 部署静态博客

### 把站点和构建的静态博客推送到同一个github储存库

我为了避免自定义的内容因为一些以外情况从本地消失，我决定把站点也一起推送到github储存库。

在站点根目录config.yml里加上下面这段内容。

```yml
# 构建静态的目录改为docs
# 这样可以把hugo生成的站点一起推送到同一个github储存库
# 设置GitHub Pages使用docs即可
publishDir: docs
```
在.gitignore里写上下面这行，用来排除站点根目录的resources文件夹。

```
/resources/
```
这个文件夹是Hugo本地查看静态网站效果生成的缓存文件夹，没必要推送到github储存库。

## 关于Git和GitHubDesktop

我把这两个都装了。

我认为某些使用命令简单，某些使用图形化界面简单。

## 一些有待解决的问题

怎么把文章标题改的更大？目前和##的标题一样大，有点不协调。