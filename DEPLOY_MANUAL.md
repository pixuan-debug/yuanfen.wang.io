# 命理正缘查询工具 - 手动部署指南

如果一键部署脚本遇到问题，您可以按照以下步骤手动部署：

## 一、准备工作

### 1. 安装Git

#### 方法1：使用Git官方安装包（推荐）
1. 访问 [Git for Windows 官网](https://gitforwindows.org/)
2. 点击"Download"按钮下载最新版本
3. 运行安装程序，按照默认选项安装即可
4. 安装完成后，重启电脑或重启终端

#### 方法2：使用Chocolatey（需要管理员权限）
```powershell
choco install git -y
```

#### 方法3：使用Scoop
```powershell
scoop install git
```

### 2. 验证Git安装

打开新的终端窗口，运行以下命令验证Git是否安装成功：
```bash
git --version
```

如果显示Git版本信息，则安装成功。

### 3. 创建GitHub账户

1. 访问 [GitHub官网](https://github.com/)
2. 点击"Sign up"注册账户
3. 按照提示完成邮箱验证和账户设置

### 4. 创建GitHub仓库

1. 登录GitHub
2. 点击右上角的"+"图标，选择"New repository"
3. 输入仓库名称（如"zodiac-match-tool"）
4. 选择"Public"或"Private"（建议选择Public，以便使用GitHub Pages）
5. 不要勾选"Initialize this repository with a README"选项
6. 点击"Create repository"

## 二、手动部署步骤

### 1. 初始化本地Git仓库

打开终端，进入项目文件夹：

```bash
cd C:\Users\agenew\Desktop\1
```

初始化Git仓库：

```bash
git init
git add .
git commit -m "Initial commit"
```

### 2. 配置Git用户信息

```bash
git config user.name "您的GitHub用户名"
git config user.email "您的GitHub邮箱"
```

### 3. 连接到GitHub仓库

```bash
git remote add origin https://github.com/您的用户名/您的仓库名.git
git branch -M main
```

### 4. 推送代码到GitHub

```bash
git push -u origin main
```

系统会提示您输入GitHub用户名和密码（或个人访问令牌）。

### 5. 启用GitHub Pages

1. 登录GitHub，进入您的仓库页面
2. 点击"Settings"选项卡
3. 在左侧菜单中点击"Pages"
4. 在"Source"部分，选择"main"分支
5. 点击"Save"

### 6. 访问部署的网站

部署需要几分钟时间，完成后您可以通过以下URL访问您的网站：
```
https://您的用户名.github.io/您的仓库名/
```

## 三、本地预览

### 方法1：使用Python内置服务器

如果您已安装Python 3.6+，可以使用以下命令启动本地服务器：

```bash
python -m http.server 8000
```

然后在浏览器中访问：
```
http://localhost:8000/zodiac_match.html
```

### 方法2：直接打开HTML文件

双击 `zodiac_match.html` 文件，直接在浏览器中打开。

## 四、其他部署方式

### 1. Netlify（最简单）

1. 访问 [Netlify官网](https://www.netlify.com/)
2. 登录或注册账户
3. 点击"Add new site" → "Deploy manually"
4. 直接将项目文件夹拖放到浏览器中
5. 部署完成后，Netlify会提供一个免费的域名

### 2. Vercel

1. 访问 [Vercel官网](https://vercel.com/)
2. 登录或注册账户
3. 点击"New Project"
4. 选择"Import from Git Repository"
5. 选择您的GitHub仓库
6. 点击"Deploy"，无需任何配置

### 3. 传统Web服务器

如果您有自己的服务器，可以使用Nginx或Apache部署：

#### Nginx配置示例

```nginx
server {
    listen 80;
    server_name your-domain.com;
    
    root /var/www/zodiac-match-tool;
    index index.html zodiac_match.html;
    
    location / {
        try_files $uri $uri/ =404;
    }
}
```

## 五、常见问题解决

### 1. Git命令无法识别

- 确保Git已正确安装
- 重启终端或电脑
- 检查系统环境变量中是否包含Git的安装路径

### 2. 推送失败

- 检查GitHub仓库URL是否正确
- 确保您有仓库的推送权限
- 检查网络连接
- 尝试使用个人访问令牌代替密码

### 3. GitHub Pages无法访问

- 确保已正确启用GitHub Pages
- 等待几分钟，部署需要时间
- 检查仓库是否为公开仓库
- 检查分支是否正确

## 六、联系方式

如果您在部署过程中遇到问题，可以：

1. 查看GitHub官方文档
2. 在GitHub社区提问
3. 参考项目中的 `DEPLOYMENT_GUIDE.md` 文件

祝您部署成功！
