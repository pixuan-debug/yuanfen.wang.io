# Trae CN 一键部署配置指南

## 概述

本指南将帮助您在 Trae CN 开发工具中配置和使用一键部署功能，实现接近"一键部署"的效果。

## 前提条件

1. 已安装 Trae CN 开发工具
2. 项目已包含部署脚本（如 `deploy.bat`）
3. 已安装 Git（用于 GitHub Pages 部署）
4. 已创建 GitHub 账户和仓库

## 现有部署脚本

### 检查现有脚本

项目中已包含以下部署相关文件：

- `deploy.bat` - Windows 批处理部署脚本
- `local_server.py` - 本地预览服务器
- `simple_server.ps1` - PowerShell 本地服务器
- `README.md` - 项目说明文档
- `DEPLOYMENT_GUIDE.md` - 详细部署指南
- `DEPLOY_MANUAL.md` - 手动部署说明

### 部署脚本功能

现有 `deploy.bat` 脚本可以：

1. 检查 Git 安装情况
2. 初始化 Git 仓库
3. 设置 Git 用户信息
4. 添加文件到暂存区
5. 提交更改
6. 配置远程仓库
7. 推送到 GitHub
8. 提供 GitHub Pages 启用说明

## 在 Trae CN 中使用部署脚本

### 方法 1：直接运行批处理脚本

1. 打开 Trae CN 终端
2. 切换到项目目录
3. 运行以下命令：
   ```
   cmd /c deploy.bat
   ```

### 方法 2：使用 PowerShell 脚本

1. 打开 Trae CN 终端
2. 切换到项目目录
3. 运行以下命令：
   ```
   powershell -ExecutionPolicy Bypass -File deploy_english.ps1
   ```

### 方法 3：创建自定义命令

1. 打开 Trae CN 设置
2. 进入 "Terminal" -> "Integrated" -> "Profiles: Windows"
3. 添加新的终端配置文件
4. 设置命令为：
   ```
   powershell -ExecutionPolicy Bypass -File "c:\Users\agenew\Desktop\1\deploy_english.ps1"
   ```
5. 保存配置
6. 在终端下拉菜单中选择该配置文件即可快速部署

## 配置自动化部署

### 1. 设置 Git 自动登录

为了实现真正的一键部署，建议配置 Git 自动登录：

1. 使用 GitHub CLI 或 Git Credential Manager
2. 或配置 SSH 密钥：
   ```
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```
3. 将公钥添加到 GitHub 账户

### 2. 创建简化版部署脚本

创建一个简化版的部署脚本，跳过交互式输入：

```powershell
# Simple Deployment Script
git add .
git commit -m "Auto deploy from Trae CN"
git push origin main
Write-Host "Deployment completed!" -ForegroundColor Green
```

### 3. 设置快捷键

在 Trae CN 中设置快捷键，一键触发部署：

1. 打开 Trae CN 设置
2. 进入 "Keyboard Shortcuts"
3. 搜索 "workbench.action.terminal.sendSequence"
4. 添加新的快捷键，例如 `Ctrl+Shift+D`
5. 设置命令为：
   ```json
   {
       "command": "workbench.action.terminal.sendSequence",
       "args": {
           "text": "powershell -ExecutionPolicy Bypass -File \"c:\\Users\\agenew\\Desktop\\1\\deploy_english.ps1\"\u000D"
       }
   }
   ```

## 本地预览功能

### 使用 Python 本地服务器

```
python local_server.py
```

### 使用 PowerShell 本地服务器

```
powershell -ExecutionPolicy Bypass -File simple_server.ps1
```

## 部署到其他平台

### Netlify

1. 访问 [Netlify](https://www.netlify.com/)
2. 登录并创建新项目
3. 选择 "Deploy manually"
4. 拖放项目文件夹到浏览器

### Vercel

```
npm i -g vercel
vercel login
vercel
```

### 传统 Web 服务器

参考 `DEPLOYMENT_GUIDE.md` 文件中的详细说明。

## 常见问题

### 1. 脚本无法运行

- 确保已安装 Git
- 确保执行策略已正确设置
- 尝试使用完整路径运行脚本

### 2. 推送失败

- 检查 GitHub 仓库 URL 是否正确
- 确保已配置正确的 Git 凭据
- 检查网络连接

### 3. GitHub Pages 无法访问

- 确保已正确启用 GitHub Pages
- 等待几分钟，部署需要时间
- 检查仓库是否为公开仓库

## 结语

通过以上配置，您可以在 Trae CN 开发工具中实现接近"一键部署"的效果。根据您的需求选择合适的部署方式，并根据实际情况调整脚本和配置。

如果您在使用过程中遇到问题，建议参考项目中的详细部署文档或咨询 Trae CN 支持。