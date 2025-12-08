@echo off
chcp 65001 >nul
echo =========================================
echo 命理正缘查询工具 - 简单部署脚本
echo =========================================
echo.
echo 这个脚本会帮助你部署网站，一步步按照提示操作即可！
echo.
echo 按任意键开始...
pause >nul

echo.
echo 步骤 1: 检查Git是否安装
echo -----------------------------------------
where git >nul 2>nul
if %errorlevel% neq 0 (
    echo 错误：未安装Git，请先安装Git
    echo 下载地址：https://gitforwindows.org/
    echo 安装时请勾选"Add Git to PATH"选项
    echo.
    echo 按任意键退出...
    pause >nul
    exit /b 1
)

echo Git已安装 ✓
echo.
echo 按任意键继续...
pause >nul

echo.
echo 步骤 2: 初始化Git仓库
echo -----------------------------------------
if not exist ".git" (
    echo 正在初始化Git仓库...
    git init
    echo Git仓库初始化成功 ✓
) else (
    echo Git仓库已存在 ✓
)

echo.
echo 按任意键继续...
pause >nul

echo.
echo 步骤 3: 设置GitHub信息
echo -----------------------------------------
set /p username=请输入GitHub用户名：
git config user.name "%username%"

set /p email=请输入GitHub邮箱：
git config user.email "%email%"

echo GitHub信息设置成功 ✓
echo.
echo 按任意键继续...
pause >nul

echo.
echo 步骤 4: 配置GitHub仓库
echo -----------------------------------------
echo 请先在GitHub上创建一个新仓库，然后复制仓库URL
echo 仓库URL格式：https://github.com/用户名/仓库名.git
echo.
set /p repo=请粘贴GitHub仓库URL：

if "%repo%" neq "" (
    git remote add origin %repo%
    git branch -M main
    echo 远程仓库配置成功 ✓
) else (
    echo 错误：未提供仓库URL
    echo 按任意键退出...
    pause >nul
    exit /b 1
)

echo.
echo 按任意键继续...
pause >nul

echo.
echo 步骤 5: 提交并推送代码
echo -----------------------------------------
echo 正在添加所有文件...
git add .
echo.

echo 正在提交更改...
git commit -m "Initial deployment"
echo.

echo 正在推送到GitHub...
echo 首次推送会弹出登录窗口，请输入GitHub账号密码
echo 按任意键开始推送...
pause >nul

git push -u origin main

echo.
if %errorlevel% equ 0 (
    echo 推送成功 ✓
) else (
    echo 推送失败，请检查错误信息
    echo 按任意键退出...
    pause >nul
    exit /b 1
)

echo.
echo 按任意键继续...
pause >nul

echo.
echo 步骤 6: 启用GitHub Pages
echo -----------------------------------------
echo 请按照以下步骤操作：
echo 1. 登录GitHub，进入你的仓库页面
echo 2. 点击顶部的"Settings"选项卡
echo 3. 在左侧菜单中点击"Pages"
echo 4. 在"Source"部分选择"main"分支
echo 5. 点击"Save"按钮
echo.
echo 等待几分钟，你的网站就可以访问了！
echo 网站URL示例：https://%username%.github.io/仓库名/
echo.
echo =========================================
echo 部署完成！
echo =========================================
echo.
echo 按任意键退出...
pause >nul