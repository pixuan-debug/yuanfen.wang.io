# 手动部署指南

## 概述

由于Git可能已安装但未添加到系统PATH中，我们将使用手动配置的方式完成部署。

## 步骤 1：配置Git路径

### 查找Git安装路径

请按照以下步骤查找Git的安装路径：

1. 打开文件资源管理器
2. 检查以下常见安装路径：
   - `C:\Program Files\Git\`
   - `C:\Program Files (x86)\Git\`
   - `C:\Users\[您的用户名]\AppData\Local\Programs\Git\`
3. 找到Git安装目录后，检查`bin`子目录下是否有`git.exe`文件
   - 例如：`C:\Program Files\Git\bin\git.exe`

### 配置Git路径到系统环境变量

1. 右键点击「此电脑」→「属性」→「高级系统设置」→「环境变量」
2. 在「系统变量」中找到「Path」，点击「编辑」
3. 点击「新建」，添加Git的`bin`目录路径
   - 例如：`C:\Program Files\Git\bin`
4. 点击「确定」保存更改
5. 重启命令提示符或PowerShell，使更改生效

### 验证配置

1. 打开新的命令提示符或PowerShell
2. 运行以下命令验证Git是否可用：
   ```
   git --version
   ```
3. 如果显示Git版本信息，则配置成功

## 步骤 2：初始化Git仓库

1. 打开命令提示符或PowerShell
2. 切换到项目目录：
   ```
   cd C:\Users\agenew\Desktop\1
   ```
3. 初始化Git仓库：
   ```
   git init
   ```
4. 配置Git用户信息：
   ```
   git config user.name "您的用户名"
   git config user.email "您的邮箱"
   ```

## 步骤 3：添加远程仓库

1. 登录GitHub，创建一个新的仓库
2. 复制仓库的URL（例如：https://github.com/用户名/仓库名.git）
3. 在命令行中添加远程仓库：
   ```
   git remote add origin https://github.com/用户名/仓库名.git
   ```
4. 验证远程仓库配置：
   ```
   git remote -v
   ```

## 步骤 4：提交和推送

1. 添加所有文件到暂存区：
   ```
   git add .
   ```
2. 提交更改：
   ```
   git commit -m "Initial commit"
   ```
3. 推送到GitHub：
   ```
   git push -u origin main
   ```
4. 首次推送时，会提示输入GitHub凭据，请输入您的用户名和密码（或个人访问令牌）

## 步骤 5：启用GitHub Pages

1. 登录GitHub，进入您的仓库页面
2. 点击「Settings」选项卡
3. 在左侧菜单中点击「Pages」
4. 在「Source」部分，选择「main」分支
5. 点击「Save」
6. 等待几分钟，您的网站将可访问，URL格式为：
   ```
   https://用户名.github.io/仓库名/
   ```

## 步骤 6：配置自动化部署

完成上述步骤后，您可以继续配置自动化部署：

1. 配置Git自动登录，避免每次推送都需要输入凭据
2. 配置Trae CN终端和快捷键
3. 使用`Ctrl+Shift+D`一键部署

详细配置请参考`AUTO_DEPLOY_CONFIG.md`文件。

## 常见问题解决

### 1. Git命令无法识别

- 确保已将Git的`bin`目录添加到系统PATH
- 确保重启了命令提示符或PowerShell
- 尝试使用Git的完整路径运行命令，例如：
  ```
  "C:\Program Files\Git\bin\git.exe" --version
  ```

### 2. 推送失败

- 确保远程仓库URL正确
- 确保您有仓库的推送权限
- 确保网络连接正常
- 尝试使用个人访问令牌代替密码

### 3. GitHub Pages无法访问

- 确保已正确启用GitHub Pages
- 等待几分钟，部署需要时间
- 检查仓库是否为公开仓库

## 后续帮助

如果您在部署过程中遇到任何问题，或者需要进一步的帮助，请随时告诉我。