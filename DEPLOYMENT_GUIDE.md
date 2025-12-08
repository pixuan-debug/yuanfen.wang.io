# 命理正缘查询工具部署指南

根据对项目的分析，您的命理正缘查询工具是一个纯静态网站，只包含HTML文件。以下是几种常见的静态网站部署方案：

## 1. GitHub Pages

**优点：**
- 完全免费
- 与GitHub版本控制无缝集成
- 支持自定义域名
- 自动HTTPS

**缺点：**
- 构建过程相对简单，高级功能较少
- 定制化部署配置有限

## 2. Netlify

**优点：**
- 免费计划足够个人项目使用
- 自动部署（连接GitHub仓库后）
- 内置CDN加速
- 自动HTTPS
- 支持自定义域名
- 表单处理、函数计算等高级功能

**缺点：**
- 高级功能需要付费

## 3. Vercel

**优点：**
- 免费计划支持个人和小团队使用
- 超快速部署和全球CDN
- 自动HTTPS和自定义域名
- 开发体验优秀
- 内置分析和监控工具

**缺点：**
- 高级功能需要付费

## 4. 传统Web服务器（如Nginx、Apache）

**优点：**
- 完全的控制权
- 可定制化程度高
- 可与其他服务集成

**缺点：**
- 需要自行管理服务器
- 需要配置HTTPS
- 需要自行处理CDN等优化
- 有服务器成本

## 5. 云存储静态网站托管

**优点：**
- 成本低
- 高可用性
- 易于扩展

**缺点：**
- 部分功能可能需要额外配置

## 详细部署步骤

### GitHub Pages 部署步骤

#### 准备工作
1. 安装 Git（如果尚未安装）
   - Windows: 下载并安装 [Git for Windows](https://gitforwindows.org/)
   - macOS: 使用 Homebrew 安装 `brew install git` 或下载 [官方安装包](https://git-scm.com/download/mac)
   - Linux: 使用包管理器安装，如 `apt install git` 或 `yum install git`

2. 创建 GitHub 账户（如果尚未拥有）
   - 访问 [GitHub官网](https://github.com/) 注册账户

#### 部署步骤

1. **初始化 Git 仓库**
   
   在项目文件夹中打开命令行（CMD/PowerShell/Terminal），执行以下命令：
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   ```

2. **在 GitHub 创建新仓库**
   
   - 登录 GitHub 账户
   - 点击右上角的 "+" 图标，选择 "New repository"
   - 输入仓库名称（如 "zodiac-match-tool"）
   - 选择公开或私有仓库
   - 不要勾选 "Initialize this repository with a README" 选项
   - 点击 "Create repository"

3. **连接本地仓库到 GitHub**
   
   在命令行中执行（替换 `your-username` 和 `repository-name` 为实际值）：
   ```bash
   git remote add origin https://github.com/your-username/repository-name.git
   git branch -M main
   git push -u origin main
   ```

4. **启用 GitHub Pages**
   
   - 进入 GitHub 上的仓库页面
   - 点击 "Settings" 选项卡
   - 在左侧菜单中点击 "Pages"
   - 在 "Source" 部分，选择 "main" 分支
   - 点击 "Save"

5. **访问部署的网站**
   
   - 部署需要几分钟时间
   - 部署成功后，GitHub Pages 设置页面会显示您的网站 URL
   - 通常格式为：`https://your-username.github.io/repository-name/`

#### 自定义域名设置（可选）

1. **在域名注册商处添加 DNS 记录**
   
   - A 记录指向：185.199.108.153, 185.199.109.153, 185.199.110.153, 185.199.111.153
   - 或 CNAME 记录指向：`your-username.github.io`

2. **在 GitHub Pages 设置中配置自定义域名**
   
   - 进入 GitHub 仓库的 Pages 设置页面
   - 在 "Custom domain" 部分输入您的域名
   - 点击 "Save"
   - 勾选 "Enforce HTTPS" 选项以启用 HTTPS

### Netlify 部署步骤

Netlify提供了非常简便的静态网站部署方式，支持从GitHub导入或直接拖放上传文件。

#### 方法一：从 GitHub 导入（推荐）

1. **创建 GitHub 仓库**
   
   按照前面 GitHub Pages 部分的步骤，先将项目上传到 GitHub。

2. **创建 Netlify 账户**
   
   - 访问 [Netlify官网](https://www.netlify.com/)
   - 点击 "Sign up" 创建账户
   - 可以使用 GitHub 账户直接登录

3. **导入项目**
   
   - 登录后，点击 "New site from Git"
   - 选择 "GitHub"
   - 授权 Netlify 访问您的 GitHub 账户
   - 选择要部署的仓库

4. **配置部署设置**
   
   - 构建命令：留空（因为是纯静态网站）
   - 发布目录：`/`（根目录）
   - 点击 "Deploy site"

5. **访问部署的网站**
   
   - Netlify 会自动开始部署
   - 部署完成后，您可以在 Netlify 控制台看到部署状态和网站 URL
   - 通常格式为：`https://your-site-name.netlify.app/`

#### 方法二：拖放上传

1. **创建 Netlify 账户**
   
   按照上述步骤创建 Netlify 账户。

2. **拖放上传**
   
   - 登录后，在 Netlify 控制面板点击 "Add new site" → "Deploy manually"
   - 直接将包含项目文件的文件夹拖放到浏览器中
   - 或者点击 "Choose files" 选择文件夹

3. **部署完成**
   
   - Netlify 会自动部署您的网站
   - 部署完成后，您可以获得一个自动生成的 URL

#### 自定义域名设置

1. **在 Netlify 中添加自定义域名**
   
   - 进入您的站点设置
   - 点击 "Domain settings"
   - 点击 "Add custom domain"
   - 输入您的域名
   - 点击 "Save"

2. **在域名注册商处配置 DNS 记录**
   
   - 按照 Netlify 提供的 DNS 配置指南操作
   - 通常需要添加 CNAME 记录指向您的 Netlify 子域名
   - 或添加 A 记录指向 Netlify 的 IP 地址（104.198.14.52）

3. **启用 HTTPS**
   
   - Netlify 会自动为您的自定义域名生成 SSL 证书
   - 在域名设置中确认 HTTPS 已启用

#### 持续部署

- 当您选择从 GitHub 导入时，Netlify 会自动设置持续部署
- 每次推送到 GitHub 仓库的 main 分支时，Netlify 会自动重新构建和部署您的网站

### Vercel 部署步骤

Vercel是一个专注于现代前端应用的部署平台，提供简单快速的部署体验和全球CDN。

#### 方法一：从 GitHub 导入（推荐）

1. **创建 GitHub 仓库**
   
   按照前面 GitHub Pages 部分的步骤，先将项目上传到 GitHub。

2. **创建 Vercel 账户**
   
   - 访问 [Vercel官网](https://vercel.com/)
   - 点击 "Sign Up" 创建账户
   - 可以使用 GitHub、GitLab 或 Bitbucket 账户直接登录

3. **导入项目**
   
   - 登录后，点击 "New Project"
   - 选择 "Import from Git Repository"
   - 选择 "GitHub" 并授权 Vercel 访问您的 GitHub 账户
   - 选择要部署的仓库

4. **配置项目设置**
   
   - 项目名称：可以保留默认名称或自定义
   - Framework Preset：选择 "Other"（因为是纯静态网站）
   - Build Command：留空
   - Output Directory：留空
   - 点击 "Deploy"

5. **访问部署的网站**
   
   - Vercel 会自动开始部署过程
   - 部署完成后，您可以在 Vercel 控制台看到部署状态和网站 URL
   - 通常格式为：`https://your-project-name.vercel.app/`

#### 方法二：使用 Vercel CLI

1. **安装 Vercel CLI**
   
   打开命令行，执行：
   ```bash
   npm i -g vercel
   ```
   （需要先安装 Node.js）

2. **登录 Vercel**
   
   ```bash
   vercel login
   ```
   按照提示完成登录。

3. **部署项目**
   
   在项目文件夹中执行：
   ```bash
   vercel
   ```
   按照提示进行配置：
   - 选择或创建团队
   - 确认项目名称
   - 确认根目录为 "./"
   - 确认要上传的文件
   - 选择 "No" 表示不覆盖设置
   - 部署完成后，会显示临时 URL

#### 自定义域名设置

1. **在 Vercel 中添加自定义域名**
   
   - 进入您的项目设置
   - 点击 "Domains"
   - 输入您的域名，点击 "Add"
   - Vercel 会提供 DNS 配置指南

2. **在域名注册商处配置 DNS 记录**
   
   - 按照 Vercel 提供的 DNS 配置指南操作
   - 通常需要添加 A 记录指向 Vercel 的 IP 地址（76.76.21.21 和 76.76.21.22）
   - 或添加 CNAME 记录指向您的 Vercel 子域名

3. **启用 HTTPS**
   
   - Vercel 会自动为您的自定义域名生成 SSL 证书
   - 通常几分钟内即可完成配置

#### 持续部署

- 当您选择从 GitHub 导入时，Vercel 会自动设置持续部署
- 每次推送到 GitHub 仓库时，Vercel 会自动重新构建和部署您的网站
- 您还可以在 Vercel 控制台查看所有部署历史和预览链接

### 传统Web服务器部署步骤（以Nginx为例）

如果您希望拥有完全的控制权，可以选择使用传统的Web服务器来部署静态网站。以下是使用Nginx的详细步骤。

#### 准备工作

1. **获取服务器**
   
   - 可以从云服务提供商（如阿里云、腾讯云、AWS、Azure、Google Cloud等）购买虚拟服务器
   - 推荐选择Linux系统（如Ubuntu、CentOS等）

2. **连接到服务器**
   
   - 使用SSH工具连接到您的服务器
   - Windows: 可以使用PuTTY、Windows Terminal或PowerShell
   - macOS/Linux: 直接使用Terminal
   
   ```bash
   ssh username@your-server-ip
   ```

#### 安装Nginx

##### Ubuntu/Debian系统

```bash
# 更新包列表
sudo apt update

# 安装Nginx
sudo apt install nginx -y

# 启动Nginx服务
sudo systemctl start nginx

# 设置Nginx开机自启
sudo systemctl enable nginx
```

##### CentOS/RHEL系统

```bash
# 安装EPEL仓库
sudo yum install epel-release -y

# 安装Nginx
sudo yum install nginx -y

# 启动Nginx服务
sudo systemctl start nginx

# 设置Nginx开机自启
sudo systemctl enable nginx
```

#### 部署网站文件

1. **创建网站根目录**
   
   ```bash
   sudo mkdir -p /var/www/zodiac-match-tool
   ```

2. **上传网站文件**
   
   使用SCP命令将本地文件上传到服务器：
   
   ```bash
   # 在本地计算机上执行
   scp -r index.html zodiac_match.html username@your-server-ip:/var/www/zodiac-match-tool/
   ```

3. **设置文件权限**
   
   ```bash
   sudo chown -R www-data:www-data /var/www/zodiac-match-tool
   sudo chmod -R 755 /var/www/zodiac-match-tool
   ```

#### 配置Nginx虚拟主机

1. **创建Nginx配置文件**
   
   ```bash
   sudo nano /etc/nginx/sites-available/zodiac-match-tool
   ```

2. **添加以下配置内容**
   
   ```nginx
   server {
       listen 80;
       server_name your-domain.com www.your-domain.com;
       
       root /var/www/zodiac-match-tool;
       index index.html zodiac_match.html;
       
       location / {
           try_files $uri $uri/ =404;
       }
   }
   ```
   
   注意：将`your-domain.com`替换为您的实际域名，如果没有域名，可以使用服务器IP。

3. **启用配置**
   
   ```bash
   sudo ln -s /etc/nginx/sites-available/zodiac-match-tool /etc/nginx/sites-enabled/
   ```

4. **测试配置语法**
   
   ```bash
   sudo nginx -t
   ```

5. **重新加载Nginx**
   
   ```bash
   sudo systemctl reload nginx
   ```

#### 配置防火墙

1. **允许HTTP流量**
   
   对于Ubuntu的UFW防火墙：
   ```bash
   sudo ufw allow 'Nginx HTTP'
   ```
   
   对于CentOS的firewalld：
   ```bash
   sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload
   ```

#### 配置HTTPS（使用Let's Encrypt）

1. **安装Certbot**
   
   Ubuntu/Debian:
   ```bash
   sudo apt install certbot python3-certbot-nginx -y
   ```
   
   CentOS/RHEL:
   ```bash
   sudo yum install certbot python3-certbot-nginx -y
   ```

2. **获取SSL证书**
   
   ```bash
   sudo certbot --nginx -d your-domain.com -d www.your-domain.com
   ```
   
   按照提示完成配置。

3. **自动续期设置**
   
   Let's Encrypt证书有效期为90天，可以设置自动续期：
   ```bash
   sudo systemctl enable certbot.timer
   ```

#### 部署维护

1. **更新网站文件**
   
   当需要更新网站内容时，只需上传新文件到服务器的网站目录：
   ```bash
   scp -r *.html username@your-server-ip:/var/www/zodiac-match-tool/
   ```

2. **监控Nginx服务**
   
   检查Nginx服务状态：
   ```bash
   sudo systemctl status nginx
   ```
   
   查看访问日志：
   ```bash
   sudo tail -f /var/log/nginx/access.log
   ```
   
   查看错误日志：
   ```bash
   sudo tail -f /var/log/nginx/error.log
   ```