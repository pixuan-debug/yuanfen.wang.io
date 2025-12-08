# 命理正缘查询工具

一个基于HTML的命理正缘查询工具，支持多种部署方式。

## 功能特点

- 纯静态HTML实现，无需后端服务
- 支持多种部署方式
- 提供一键部署脚本
- 提供本地预览功能

## 快速开始

### 本地预览

#### 方法1：使用Python脚本（推荐）

1. 确保已安装Python 3.6+
2. 运行以下命令启动本地服务器：
   ```bash
   python local_server.py
   ```
3. 浏览器将自动打开 `http://localhost:8000/zodiac_match.html`

#### 方法2：直接打开HTML文件

双击 `zodiac_match.html` 文件直接在浏览器中打开。

### 一键部署

#### 准备工作

1. 安装Git（如果尚未安装）
   - Windows: 下载并安装 [Git for Windows](https://gitforwindows.org/)
   - macOS: 使用 Homebrew 安装 `brew install git`
   - Linux: 使用包管理器安装，如 `apt install git` 或 `yum install git`

2. 创建GitHub账户（如果尚未拥有）
   - 访问 [GitHub官网](https://github.com/) 注册账户

#### 一键部署到GitHub Pages

1. 在项目根目录双击运行 `deploy.bat`
2. 按照提示完成以下操作：
   - 输入GitHub用户名和邮箱（首次使用时）
   - 输入提交信息
   - 输入GitHub仓库URL（首次使用时）
3. 部署成功后，登录GitHub在仓库设置中启用GitHub Pages

## 部署方式

### 1. GitHub Pages（推荐）

使用提供的 `deploy.bat` 脚本一键部署到GitHub Pages。

### 2. Netlify

#### 方法：拖放上传

1. 访问 [Netlify官网](https://www.netlify.com/)
2. 登录或注册账户
3. 点击 "Add new site" → "Deploy manually"
4. 直接将项目文件夹拖放到浏览器中

### 3. Vercel

#### 方法：使用Vercel CLI

1. 安装Node.js
2. 安装Vercel CLI：
   ```bash
   npm i -g vercel
   ```
3. 登录Vercel：
   ```bash
   vercel login
   ```
4. 部署项目：
   ```bash
   vercel
   ```

### 4. 传统Web服务器

详细部署步骤请参考 `DEPLOYMENT_GUIDE.md` 文件。

## 项目结构

```
.
├── DEPLOYMENT_GUIDE.md  # 详细部署指南
├── README.md           # 项目说明文档
├── deploy.bat          # 一键部署脚本
├── local_server.py     # 本地预览脚本
├── zodiac_match.html   # 主页面
└── ...                 # 其他资源文件
```

## 技术栈

- HTML5
- CSS3
- JavaScript

## 浏览器支持

- Chrome (推荐)
- Firefox
- Safari
- Edge

## 许可证

MIT License
