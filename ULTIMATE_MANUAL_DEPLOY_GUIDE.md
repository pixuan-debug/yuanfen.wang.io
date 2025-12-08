# 终极手动部署指南

## 概述

本指南将提供完全手动的部署步骤，不依赖于脚本自动检测，适合Git已安装但无法被自动检测到的情况。

## 前提条件

1. ✅ 已安装 Git（即使无法被自动检测到）
2. ✅ 已创建 GitHub 账户
3. ✅ 已创建 GitHub 仓库
4. ✅ 已安装 Trae CN 开发工具

## 步骤 1：找到 Git 安装路径

### 方法 1：通过控制面板查找

1. 打开「控制面板」→「程序和功能」
2. 在列表中找到「Git」
3. 右键点击 →「更改」
4. 在安装向导中点击「Next」，直到看到「Destination Folder」
5. 记录下 Git 的安装路径，例如：`C:\Program Files\Git\`

### 方法 2：通过文件资源管理器查找

1. 打开文件资源管理器
2. 检查以下常见路径：
   - `C:\Program Files\Git\`
   - `C:\Program Files (x86)\Git\`
   - `C:\Users\[您的用户名]\AppData\Local\Programs\Git\`
3. 找到 Git 安装目录后，进入 `bin` 子目录，确认存在 `git.exe` 文件

### 方法 3：通过 Windows 搜索查找

1. 点击 Windows 开始按钮
2. 搜索「Git Bash」
3. 右键点击搜索结果 →「打开文件位置」
4. 在打开的文件夹中，找到「Git Bash」快捷方式
5. 右键点击 →「属性」
6. 在「目标」字段中，找到 `git-bash.exe` 的路径，例如：`C:\Program Files\Git\git-bash.exe`
7. 去掉 `git-bash.exe` 部分，得到 Git 安装路径：`C:\Program Files\Git\`

## 步骤 2：确认 Git 可执行文件路径

Git 可执行文件的完整路径通常为：

```
[Git安装路径]\bin\git.exe
```

例如：
```
C:\Program Files\Git\bin\git.exe
```

## 步骤 3：手动执行部署命令

### 打开 Trae CN 终端

1. 打开 Trae CN
2. 点击顶部菜单「Terminal」→「New Terminal」
3. 确保终端的当前目录为：`C:\Users\agenew\Desktop\1`
   - 如果不是，请执行：`cd C:\Users\agenew\Desktop\1`

### 执行 Git 命令

**请将以下命令中的 `[GIT_PATH]` 替换为您实际的 Git 可执行文件路径！**

#### 1. 初始化 Git 仓库（如果尚未初始化）

```powershell
"[GIT_PATH]" init
```

例如：
```powershell
"C:\Program Files\Git\bin\git.exe" init
```

#### 2. 配置 Git 用户信息

```powershell
"[GIT_PATH]" config user.name "您的GitHub用户名"
"[GIT_PATH]" config user.email "您的GitHub邮箱"
```

例如：
```powershell
"C:\Program Files\Git\bin\git.exe" config user.name "myusername"
"C:\Program Files\Git\bin\git.exe" config user.email "myemail@example.com"
```

#### 3. 添加远程仓库

```powershell
"[GIT_PATH]" remote add origin https://github.com/您的用户名/您的仓库名.git
"[GIT_PATH]" branch -M main
```

例如：
```powershell
"C:\Program Files\Git\bin\git.exe" remote add origin https://github.com/myusername/zodiac-match.git
"C:\Program Files\Git\bin\git.exe" branch -M main
```

#### 4. 添加并提交更改

```powershell
"[GIT_PATH]" add .
"[GIT_PATH]" commit -m "Initial deployment"
```

例如：
```powershell
"C:\Program Files\Git\bin\git.exe" add .
"C:\Program Files\Git\bin\git.exe" commit -m "Initial deployment"
```

#### 5. 推送到 GitHub

```powershell
"[GIT_PATH]" push -u origin main
```

例如：
```powershell
"C:\Program Files\Git\bin\git.exe" push -u origin main
```

**首次推送时注意事项：**
- 会弹出 GitHub 登录窗口，请输入您的 GitHub 用户名和密码
- 或者会提示输入个人访问令牌（如果您使用的是 2FA）

## 步骤 4：启用 GitHub Pages

1. 登录 GitHub
2. 进入您的仓库页面
3. 点击顶部菜单「Settings」
4. 在左侧菜单中点击「Pages」
5. 在「Source」部分：
   - 选择「Deploy from a branch」
   - 选择「main」分支
   - 选择「/ (root)」目录
   - 点击「Save」

6. 等待几分钟，GitHub Pages 会部署您的网站
7. 部署完成后，您将看到网站的访问 URL，格式为：
   ```
   https://您的用户名.github.io/您的仓库名/
   ```

## 步骤 5：验证部署

1. 等待几分钟，让 GitHub Pages 完成部署
2. 打开浏览器，访问您的网站 URL
3. 如果能看到您的网站，则部署成功！

## 步骤 6：后续部署

每次修改代码后，您可以使用以下命令进行快速部署：

```powershell
"[GIT_PATH]" add .
"[GIT_PATH]" commit -m "Update - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
"[GIT_PATH]" push origin main
```

## 常见问题解决

### 1. 命令执行失败，提示「找不到文件」

- 检查 Git 可执行文件路径是否正确
- 确保路径包含 `.exe` 扩展名
- 确保路径用双引号括起来

### 2. 推送失败，提示「Authentication failed」

- 确保 GitHub 用户名和密码正确
- 如果您启用了 2FA（双因素认证），请使用个人访问令牌代替密码
- 如何创建个人访问令牌：
  1. 登录 GitHub
  2. 进入「Settings」→「Developer settings」→「Personal access tokens」→「Tokens (classic)」
  3. 点击「Generate new token」→「Generate new token (classic)」
  4. 勾选「repo」权限
  5. 生成并复制令牌
  6. 推送时使用此令牌作为密码

### 3. 推送失败，提示「The requested URL returned error: 403」

- 确保您有该仓库的推送权限
- 检查远程仓库 URL 是否正确
- 尝试重新配置远程仓库

### 4. GitHub Pages 显示 404

- 确保已正确配置 GitHub Pages
- 等待几分钟，部署需要时间
- 检查仓库是否为公开仓库（私有仓库需要 GitHub Pro 才能使用 GitHub Pages）

## 自动化部署配置（可选）

部署成功后，您可以配置自动化部署，实现「一键部署」：

1. **配置 Git 自动登录**：
   - 使用 Git Credential Manager 保存凭据
   - 或配置 SSH 密钥

2. **配置 Trae CN 快捷键**：
   - 打开 Trae CN 设置
   - 进入「Keyboard Shortcuts」
   - 点击右上角的「Open Keyboard Shortcuts (JSON)」
   - 添加以下配置：
     ```json
     [
         {
             "key": "ctrl+shift+d",
             "command": "workbench.action.terminal.sendSequence",
             "args": {
                 "text": '\"C:\\Program Files\\Git\\bin\\git.exe\" add .; \"C:\\Program Files\\Git\\bin\\git.exe\" commit -m \"Auto deploy - $(Get-Date -Format \\"yyyy-MM-dd HH:mm:ss\\")\"; \"C:\\Program Files\\Git\\bin\\git.exe\" push origin main\\u000D'
             },
             "when": "terminalFocus"
         }
     ]
     ```

3. **使用快捷键部署**：
   - 打开 Trae CN 终端
   - 按下 `Ctrl+Shift+D` 快捷键
   - 等待部署完成

## 本地预览

如果您想在本地预览网站，可以使用项目中的 `local_server.py` 脚本：

1. 打开 Trae CN 终端
2. 确保当前目录为项目根目录
3. 运行以下命令：
   ```powershell
   python local_server.py
   ```
4. 浏览器会自动打开预览页面

## 结语

通过本指南，您可以完全手动完成部署，不依赖于脚本自动检测。虽然步骤较多，但非常可靠，适合各种复杂情况。

如果您在部署过程中遇到任何问题，或者需要进一步的帮助，请随时告诉我。

祝您部署成功！ 🎉