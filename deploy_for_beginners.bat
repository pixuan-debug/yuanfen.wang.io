@echo off
chcp 65001 >nul
echo =========================================
echo 命理正缘查询工具 - 部署脚本（小白专用）
echo =========================================
echo.
echo 这个脚本会帮助你完成部署，你只需要按照提示操作即可！
echo.
pause

echo 步骤 1: 检查Git是否安装
echo -----------------------------------------
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo 错误：未安装Git，请先安装Git
    echo 下载地址：https://gitforwindows.org/
    echo 安装时请勾选"Add Git to PATH"选项
    pause
    exit /b 1
)

echo ✓ Git已安装
echo.
pause

echo 步骤 2: 初始化Git仓库
echo -----------------------------------------
if not exist ".git" (
    echo 正在初始化Git仓库...
    git init
    echo ✓ Git仓库初始化成功
) else (
    echo ✓ Git仓库已存在
)
echo.
pause

echo 步骤 3: 设置Git用户名和邮箱
echo -----------------------------------------
set /p username="请输入你的GitHub用户名："
git config user.name "%username%"

set /p email="请输入你的GitHub邮箱："
git config user.email "%email%"

echo ✓ Git用户信息设置成功
echo.
pause

echo 步骤 4: 配置GitHub仓库
echo -----------------------------------------
echo 请先在GitHub上创建一个新仓库，然后复制仓库URL
echo 仓库URL格式：https://github.com/用户名/仓库名.git
echo.
set /p repo_url="请粘贴GitHub仓库URL："

if exist ".git" (
    git remote add origin %repo_url%
    git branch -M main
    echo ✓ 远程仓库配置成功
) else (
    echo 错误：Git仓库未初始化
    pause
    exit /b 1
)
echo.
pause

echo 步骤 5: 提交并推送代码
echo -----------------------------------------
echo 正在添加所有文件...
git add .
echo.

set /p commit_msg="请输入提交信息（默认为'Initial commit'）："
if "%commit_msg%"=="" set commit_msg=Initial commit
echo 正在提交更改...
git commit -m "%commit_msg%"
echo.

echo 正在推送到GitHub...
echo 首次推送会弹出登录窗口，请输入GitHub账号密码
echo 如果启用了2FA，请使用个人访问令牌

git push -u origin main

if %errorlevel% equ 0 (
    echo ✓ 推送成功！
) else (
    echo ✗ 推送失败，请检查错误信息
    pause
    exit /b 1
)
echo.
pause

echo 步骤 6: 启用GitHub Pages
echo -----------------------------------------
echo 请按照以下步骤启用GitHub Pages：
echo 1. 登录GitHub，进入你的仓库页面
echo 2. 点击顶部的"Settings"选项卡
echo 3. 在左侧菜单中点击"Pages"
echo 4. 在"Source"部分，选择"main"分支
echo 5. 点击"Save"
echo.
echo 你的网站将在几分钟后可访问，URL格式：
echo https://%username%.github.io/%repo_url:~25%/
echo.
echo =========================================
echo 部署完成！
echo =========================================
echo 请按照上面的步骤启用GitHub Pages
echo 有任何问题请联系技术支持
echo.
pause