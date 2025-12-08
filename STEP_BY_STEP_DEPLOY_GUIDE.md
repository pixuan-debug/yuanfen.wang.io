# 一步一步教你部署网站（小白专用）

## 概述

这个指南将一步一步教你如何部署你的网站，你只需要按照步骤操作即可，非常简单！

## 前提条件

1. ✅ 已安装 Git（如果没有安装，请先安装）
2. ✅ 已创建 GitHub 账号
3. ✅ 已创建 GitHub 仓库

## 步骤 0：安装 Git（如果还没安装）

1. 打开浏览器，访问 Git 官网：https://gitforwindows.org/
2. 点击 "Download" 按钮下载 Git 安装包
3. 双击安装包，按照提示安装
4. **重要**：安装时一定要勾选 "Add Git to PATH" 选项
5. 其他选项使用默认值即可
6. 安装完成后，重启电脑

## 开始部署

### 步骤 1：打开命令行工具

1. 按下键盘上的 `Win + R` 键
2. 在弹出的对话框中输入 `cmd`
3. 点击 "确定"，打开命令提示符

### 步骤 2：进入项目目录

1. 在命令提示符中输入以下命令，然后按 Enter：
   ```
   cd C:\Users\agenew\Desktop\1
   ```

2. 检查是否进入了正确的目录：
   ```
   dir
   ```
   你应该能看到 `zodiac_match.html` 等文件

### 步骤 3：初始化 Git 仓库

1. 输入以下命令，初始化 Git 仓库：
   ```
   git init
   ```

2. 看到 "Initialized empty Git repository in..." 提示，说明初始化成功

### 步骤 4：设置 GitHub 信息

1. 输入以下命令，设置你的 GitHub 用户名（替换为你的用户名）：
   ```
   git config user.name "你的GitHub用户名"
   ```

2. 输入以下命令，设置你的 GitHub 邮箱（替换为你的邮箱）：
   ```
   git config user.email "你的GitHub邮箱"
   ```

### 步骤 5：配置 GitHub 仓库

1. 首先，在 GitHub 上创建一个新仓库：
   - 登录 GitHub
   - 点击右上角的 "+" 图标
   - 选择 "New repository"
   - 输入仓库名称，例如 "zodiac-match-tool"
   - 选择 "Public"
   - 点击 "Create repository"

2. 复制仓库 URL：
   - 在仓库页面，点击 "Code" 按钮
   - 复制 HTTPS URL，格式为：https://github.com/用户名/仓库名.git

3. 在命令提示符中，输入以下命令（替换为你的仓库 URL）：
   ```
   git remote add origin https://github.com/用户名/仓库名.git
   git branch -M main
   ```

### 步骤 6：提交代码

1. 添加所有文件到 Git：
   ```
   git add .
   ```

2. 提交代码：
   ```
   git commit -m "Initial deployment"
   ```

### 步骤 7：推送到 GitHub

1. 输入以下命令，推送到 GitHub：
   ```
   git push -u origin main
   ```

2. 首次推送会弹出 GitHub 登录窗口：
   - 输入你的 GitHub 用户名和密码
   - 如果启用了 2FA（双因素认证），需要输入个人访问令牌

3. 看到 "Branch 'main' set up to track remote branch 'main' from 'origin'." 提示，说明推送成功

### 步骤 8：启用 GitHub Pages

1. 登录 GitHub，进入你的仓库页面
2. 点击顶部的 "Settings" 选项卡
3. 在左侧菜单中点击 "Pages"
4. 在 "Source" 部分：
   - 选择 "Deploy from a branch"
   - 选择 "main" 分支
   - 选择 "/ (root)" 目录
   - 点击 "Save" 按钮

5. 等待几分钟，GitHub Pages 会部署你的网站
6. 部署完成后，你会看到网站的访问 URL，格式为：
   ```
   https://你的用户名.github.io/你的仓库名/
   ```

## 访问你的网站

1. 复制你的网站 URL
2. 打开浏览器，粘贴 URL 并访问
3. 你应该能看到你的网站了！

## 常见问题

### 问题 1：Git 命令无法识别

- **原因**：Git 没有添加到系统 PATH 中
- **解决方法**：重新安装 Git，确保勾选 "Add Git to PATH" 选项，安装完成后重启电脑

### 问题 2：推送失败，提示 "Authentication failed"

- **原因**：GitHub 账号密码错误，或者启用了 2FA
- **解决方法**：
  - 检查用户名和密码是否正确
  - 如果启用了 2FA，需要使用个人访问令牌代替密码
  - 如何创建个人访问令牌：
    1. 登录 GitHub
    2. 点击右上角头像 → Settings → Developer settings → Personal access tokens → Tokens (classic)
    3. 点击 "Generate new token" → "Generate new token (classic)"
    4. 勾选 "repo" 权限
    5. 点击 "Generate token"
    6. 复制令牌，推送时使用这个令牌作为密码

### 问题 3：GitHub Pages 显示 404

- **原因**：部署还没完成，或者配置有误
- **解决方法**：
  - 等待几分钟，GitHub Pages 需要时间部署
  - 检查 GitHub Pages 配置是否正确，确保选择了 main 分支
  - 检查仓库是否为公开仓库（私有仓库需要 GitHub Pro）

### 问题 4：推送失败，提示 "The requested URL returned error: 403"

- **原因**：没有仓库的推送权限
- **解决方法**：确保你是仓库的所有者，或者有推送权限

## 后续更新

每次修改代码后，你可以使用以下命令更新网站：

1. 打开命令行，进入项目目录
2. 输入以下命令：
   ```
   git add .
   git commit -m "Update"
   git push origin main
   ```
3. 等待几分钟，网站会自动更新

## 联系我们

如果遇到任何问题，欢迎联系我们寻求帮助！

祝你部署成功！ 🎉