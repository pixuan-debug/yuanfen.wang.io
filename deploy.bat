@echo off
chcp 65001 >nul
echo =========================================
echo 命理正缘查询工具一键部署脚本
echo =========================================
echo.

REM 检查Git是否安装
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo 错误：未安装Git，请先安装Git
    echo 下载地址：https://gitforwindows.org/
    pause
    exit /b 1
)

echo Git已安装，版本：
git --version
echo.

REM 检查是否已初始化Git仓库
if not exist ".git" (
    echo 初始化Git仓库...
    git init
    echo.
)

REM 设置Git用户信息（如果尚未设置）
git config user.name >nul 2>nul
if %errorlevel% neq 0 (
    set /p username="请输入GitHub用户名："
    git config user.name "%username%"
)

git config user.email >nul 2>nul
if %errorlevel% neq 0 (
    set /p email="请输入GitHub邮箱："
    git config user.email "%email%"
)
echo.

REM 添加所有文件到暂存区
echo 添加文件到暂存区...
git add .
echo.

REM 提交更改
set /p commit_msg="请输入提交信息（默认为'Update'）："
if "%commit_msg%"=="" set commit_msg=Update
echo 提交更改：%commit_msg%
git commit -m "%commit_msg%"
echo.

REM 检查是否已添加远程仓库
git remote -v | findstr origin >nul 2>nul
if %errorlevel% neq 0 (
    set /p repo_url="请输入GitHub仓库URL（格式：https://github.com/用户名/仓库名.git）："
    git remote add origin %repo_url%
    git branch -M main
    echo.
)

REM 推送代码到GitHub
echo 推送代码到GitHub...
git push -u origin main
echo.

REM 提示用户在GitHub上启用GitHub Pages
echo =========================================
echo 部署成功！
echo 请登录GitHub，在仓库设置中启用GitHub Pages：
echo 1. 进入仓库页面
2. 点击"Settings"选项卡
3. 在左侧菜单中点击"Pages"
4. 在"Source"部分，选择"main"分支
5. 点击"Save"
echo.
echo 部署的网站将在几分钟后可访问，URL格式：
echo https://用户名.github.io/仓库名/
echo =========================================
pause
