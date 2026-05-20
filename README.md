# Sogrey.github.io

[![](https://sogrey.github.io/img/logo/sogrey.github.io.svg)](https://sogrey.github.io/)

Sogrey's github pages

[点此预览](https://sogrey.github.io/)

---

## 源码开发

### 1. 克隆源码

```bash
git clone -b dev git@github.com:Sogrey/Sogrey.github.io.git
```

克隆 `dev` 分支的源码。

### 2. 安装依赖

推荐使用 pnpm：

```bash
pnpm install
```

或者使用 npm：

```bash
npm install
```

### 3. 本地预览

```bash
pnpm start
# 或
npm start
```

然后访问 http://localhost:4000

### 4. 部署

**现在使用 GitHub Actions 自动部署，无需手动操作！**

只需将代码推送到 `dev` 分支，GitHub Actions 会自动构建并部署到 GitHub Pages：

```bash
git add .
git commit -m "更新博客"
git push origin dev
```

---

## 自动部署说明

本项目已配置 GitHub Actions 工作流，实现自动部署：

- **触发条件**: 推送到 `dev` 分支时自动触发
- **构建环境**: Ubuntu + Node.js 20
- **部署目标**: GitHub Pages
- **构建步骤**:
  1. 检出代码
  2. 安装 Node.js 依赖
  3. 构建 Hexo 静态站点
  4. 复制额外文件（404页面、验证文件等）
  5. 部署到 GitHub Pages

### 手动触发部署

也可以在 GitHub 仓库页面手动触发部署：

1. 进入仓库的 **Actions** 标签页
2. 选择 **Deploy Hexo Blog to GitHub Pages** 工作流
3. 点击 **Run workflow** 按钮

---

## 项目结构

```
.
├── .github/workflows/    # GitHub Actions 配置
├── scaffolds/            # Hexo 文章模板
├── source/               # 博客源文件
│   ├── _posts/          # 文章目录
│   ├── about/           # 关于页面
│   ├── categories/      # 分类页面
│   ├── tags/            # 标签页面
│   └── img/             # 图片资源
├── themes/              # 主题目录
│   └── yelog/           # 当前使用的主题
├── _config.yml          # Hexo 主配置
├── package.json         # 项目依赖
└── README.md            # 本文件
```

---

## 技术栈

- [Hexo](https://hexo.io/) 7.x - 静态博客生成器
- [yelog](https://github.com/Sogrey/hexo-theme-yelog) 主题
- GitHub Actions - CI/CD 自动化部署
- GitHub Pages - 静态站点托管
