# 自动化部署配置指南

## 概述

本指南将帮助您在 Trae CN 开发工具中配置自动化部署，实现真正的"一键部署"效果。

## 已创建的自动化部署文件

### 1. 自动化部署脚本

- **`deploy_auto.ps1`** - 无需交互的自动化部署脚本
  - 检查 Git 安装情况
  - 自动初始化 Git 仓库（如果需要）
  - 自动添加所有文件
  - 自动提交（带时间戳）
  - 自动推送到 GitHub
  - 显示部署结果

### 2. Trae CN 配置文件

- **`trae_settings.json`** - Trae CN 配置模板
  - 自定义终端配置
  - 快捷键配置
  - 一键部署设置

## 配置步骤

### 步骤 1：启用 Git 自动登录

为了实现真正的一键部署，建议配置 Git 自动登录，避免每次部署都需要输入用户名和密码。

#### 方法 A：使用 Git Credential Manager

1. 下载并安装 Git Credential Manager：
   - 下载地址：https://github.com/GitCredentialManager/git-credential-manager/releases
   - 选择适合您系统的安装包

2. 安装后，首次推送时会自动弹出登录窗口，输入 GitHub 凭据后会自动保存。

#### 方法 B：使用 SSH 密钥

1. 生成 SSH 密钥：
   ```powershell
   ssh-keygen -t ed25519 -C "your_email@example.com"
   ```

2. 查看公钥：
   ```powershell
   cat ~/.ssh/id_ed25519.pub
   ```

3. 将公钥添加到 GitHub：
   - 登录 GitHub
   - 进入 "Settings" → "SSH and GPG keys"
   - 点击 "New SSH key"
   - 粘贴公钥，设置标题
   - 点击 "Add SSH key"

4. 测试 SSH 连接：
   ```powershell
   ssh -T git@github.com
   ```

### 步骤 2：配置 Trae CN 终端

#### 方法 1：直接修改设置

1. 打开 Trae CN
2. 点击左下角的齿轮图标，选择 "Settings"
3. 搜索 "terminal.integrated.profiles.windows"
4. 点击 "Edit in settings.json"
5. 添加以下配置：
   ```json
   "terminal.integrated.profiles.windows": {
       "Zodiac Deploy": {
           "source": "PowerShell",
           "args": [
               "-ExecutionPolicy",
               "Bypass",
               "-File",
               "c:\\Users\\agenew\\Desktop\\1\\deploy_auto.ps1"
           ]
       }
   },
   "terminal.integrated.defaultProfile.windows": "Zodiac Deploy"
   ```

#### 方法 2：使用配置文件

1. 打开 Trae CN
2. 点击左下角的齿轮图标，选择 "Settings"
3. 点击右上角的 "Open Settings (JSON)"
4. 将 `trae_settings.json` 中的内容复制到打开的文件中
5. 保存文件

### 步骤 3：配置快捷键

1. 打开 Trae CN
2. 点击左下角的齿轮图标，选择 "Keyboard Shortcuts"
3. 点击右上角的 "Open Keyboard Shortcuts (JSON)"
4. 添加以下配置：
   ```json
   [
       {
           "key": "ctrl+shift+d",
           "command": "workbench.action.terminal.sendSequence",
           "args": {
               "text": "powershell -ExecutionPolicy Bypass -File \"c:\\Users\\agenew\\Desktop\\1\\deploy_auto.ps1\"\u000D"
           },
           "when": "terminalFocus"
       },
       {
           "key": "f5",
           "command": "workbench.action.terminal.sendSequence",
           "args": {
               "text": "python local_server.py\u000D"
           },
           "when": "terminalFocus"
       }
   ]
   ```

## 使用方法

### 方法 1：使用快捷键

1. 打开 Trae CN 终端
2. 确保终端在项目目录中
3. 按下 `Ctrl+Shift+D` 快捷键
4. 等待部署完成

### 方法 2：使用自定义终端

1. 打开 Trae CN
2. 按 `Ctrl+Shift+P` 打开命令面板
3. 输入 "Terminal: Create New Terminal"
4. 选择 "Zodiac Deploy" 配置文件
5. 终端会自动运行部署脚本

### 方法 3：直接运行脚本

1. 打开 Trae CN 终端
2. 切换到项目目录
3. 运行以下命令：
   ```powershell
   powershell -ExecutionPolicy Bypass -File deploy_auto.ps1
   ```

## 本地预览快捷键

已配置 `F5` 键用于本地预览：

1. 打开 Trae CN 终端
2. 按下 `F5` 键
3. 本地服务器会自动启动，浏览器会打开预览页面

## 部署脚本说明

### 脚本工作流程

1. **检查 Git** - 确保 Git 已安装
2. **初始化仓库** - 如果 `.git` 目录不存在，则初始化
3. **添加文件** - 自动添加所有更改的文件
4. **提交** - 自动提交，提交信息包含当前时间戳
5. **推送** - 自动推送到 GitHub main 分支
6. **显示结果** - 显示部署成功或失败信息

### 提交信息格式

```
[自动部署] 2025-12-08 14:30:45
```

## 常见问题解决

### 1. 脚本无法运行

- 确保已安装 Git
- 确保文件路径正确
- 检查 PowerShell 执行策略

### 2. 推送失败

- 确保已配置 Git 自动登录
- 确保远程仓库已正确配置
- 检查网络连接

### 3. 快捷键不生效

- 确保快捷键配置正确
- 确保终端处于焦点状态
- 重启 Trae CN 尝试

## 高级配置

### 自定义部署分支

如果您想部署到其他分支，可以修改 `deploy_auto.ps1` 文件：

```powershell
# 将 main 改为您的分支名称
git push origin main
```

### 自定义提交信息

修改 `deploy_auto.ps1` 文件中的提交信息格式：

```powershell
git commit -m "[自定义前缀] $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
```

### 添加部署前检查

可以在脚本中添加部署前检查，例如：

```powershell
# 检查是否有未提交的更改
$changes = git status --porcelain
if (-not $changes) {
    Write-Host "没有需要部署的更改" -ForegroundColor Yellow
    exit 0
}
```

## 结语

通过以上配置，您已经在 Trae CN 开发工具中实现了真正的"一键部署"效果。现在您可以：

- 使用 `Ctrl+Shift+D` 一键部署
- 使用 `F5` 一键本地预览
- 使用自定义终端配置快速部署

祝您使用愉快！