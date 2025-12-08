# 命理正缘查询工具 - 部署脚本（小白专用）
# PowerShell版本

# 设置编码为UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "命理正缘查询工具 - 部署脚本（小白专用）" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "这个脚本会帮助你完成部署，你只需要按照提示操作即可！" -ForegroundColor Yellow
Write-Host ""
Read-Host -Prompt "按Enter键继续..."

Write-Host "`n步骤 1: 检查Git是否安装" -ForegroundColor Green
Write-Host "-----------------------------------------" -ForegroundColor Green

try {
    $gitVersion = git --version 2>&1
    Write-Host "✓ Git已安装，版本：$gitVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ 错误：未安装Git，请先安装Git" -ForegroundColor Red
    Write-Host "下载地址：https://gitforwindows.org/" -ForegroundColor Yellow
    Write-Host "安装时请勾选'Add Git to PATH'选项" -ForegroundColor Yellow
    Read-Host -Prompt "按Enter键退出..."
    Exit 1
}

Read-Host -Prompt "按Enter键继续..."

Write-Host "`n步骤 2: 初始化Git仓库" -ForegroundColor Green
Write-Host "-----------------------------------------" -ForegroundColor Green

if (-not (Test-Path ".git")) {
    Write-Host "正在初始化Git仓库..." -ForegroundColor Yellow
    git init 2>&1 | Write-Host
    Write-Host "✓ Git仓库初始化成功" -ForegroundColor Green
} else {
    Write-Host "✓ Git仓库已存在" -ForegroundColor Green
}

Read-Host -Prompt "按Enter键继续..."

Write-Host "`n步骤 3: 设置Git用户名和邮箱" -ForegroundColor Green
Write-Host "-----------------------------------------" -ForegroundColor Green

$username = Read-Host -Prompt "请输入你的GitHub用户名"
git config user.name "$username"

$email = Read-Host -Prompt "请输入你的GitHub邮箱"
git config user.email "$email"

Write-Host "✓ Git用户信息设置成功" -ForegroundColor Green

Read-Host -Prompt "按Enter键继续..."

Write-Host "`n步骤 4: 配置GitHub仓库" -ForegroundColor Green
Write-Host "-----------------------------------------" -ForegroundColor Green
Write-Host "请按照以下步骤操作：" -ForegroundColor Yellow
Write-Host "1. 打开浏览器，访问 https://github.com" -ForegroundColor White
Write-Host "2. 登录你的GitHub账号" -ForegroundColor White
Write-Host "3. 点击右上角的'+'图标，选择'New repository'" -ForegroundColor White
Write-Host "4. 输入仓库名称，例如'zodiac-match-tool'" -ForegroundColor White
Write-Host "5. 选择'Public'（公开仓库）" -ForegroundColor White
Write-Host "6. 点击'Create repository'创建仓库" -ForegroundColor White
Write-Host "7. 复制仓库URL，格式：https://github.com/用户名/仓库名.git" -ForegroundColor White
Write-Host ""

$repo_url = Read-Host -Prompt "请粘贴GitHub仓库URL"

if (-not $repo_url) {
    Write-Host "✗ 错误：未提供仓库URL" -ForegroundColor Red
    Read-Host -Prompt "按Enter键退出..."
    Exit 1
}

if (Test-Path ".git") {
    Write-Host "正在配置远程仓库..." -ForegroundColor Yellow
    git remote add origin $repo_url 2>&1 | Write-Host
    git branch -M main 2>&1 | Write-Host
    Write-Host "✓ 远程仓库配置成功" -ForegroundColor Green
} else {
    Write-Host "✗ 错误：Git仓库未初始化" -ForegroundColor Red
    Read-Host -Prompt "按Enter键退出..."
    Exit 1
}

Read-Host -Prompt "按Enter键继续..."

Write-Host "`n步骤 5: 提交并推送代码" -ForegroundColor Green
Write-Host "-----------------------------------------" -ForegroundColor Green

Write-Host "正在添加所有文件..." -ForegroundColor Yellow
git add . 2>&1 | Write-Host

$commit_msg = Read-Host -Prompt "请输入提交信息（默认为'Initial commit'）"
if (-not $commit_msg) {
    $commit_msg = "Initial commit"
}

Write-Host "正在提交更改..." -ForegroundColor Yellow
git commit -m "$commit_msg" 2>&1 | Write-Host

Write-Host "`n正在推送到GitHub..." -ForegroundColor Yellow
Write-Host "重要提示：首次推送会弹出登录窗口，请输入GitHub账号密码！" -ForegroundColor Red
Write-Host "如果启用了2FA（双因素认证），请使用个人访问令牌代替密码！" -ForegroundColor Red
Write-Host ""

$pushResult = git push -u origin main 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✓ 推送成功！" -ForegroundColor Green
} else {
    Write-Host "`n✗ 推送失败，请检查上面的错误信息" -ForegroundColor Red
    Write-Host "常见错误：" -ForegroundColor Yellow
    Write-Host "1. 仓库URL错误" -ForegroundColor White
    Write-Host "2. GitHub账号密码错误" -ForegroundColor White
    Write-Host "3. 未启用2FA但使用了密码登录" -ForegroundColor White
    Write-Host "4. 网络连接问题" -ForegroundColor White
    Read-Host -Prompt "按Enter键退出..."
    Exit 1
}

Read-Host -Prompt "按Enter键继续..."

Write-Host "`n步骤 6: 启用GitHub Pages" -ForegroundColor Green
Write-Host "-----------------------------------------" -ForegroundColor Green

Write-Host "请按照以下步骤启用GitHub Pages：" -ForegroundColor Yellow
Write-Host "1. 打开浏览器，登录GitHub" -ForegroundColor White
Write-Host "2. 进入你的仓库页面" -ForegroundColor White
Write-Host "3. 点击顶部的'Settings'选项卡" -ForegroundColor White
Write-Host "4. 在左侧菜单中点击'Pages'" -ForegroundColor White
Write-Host "5. 在'Source'部分：" -ForegroundColor White
Write-Host "   - 选择'Deploy from a branch'" -ForegroundColor White
Write-Host "   - 选择'main'分支" -ForegroundColor White
Write-Host "   - 选择'/ (root)'目录" -ForegroundColor White
Write-Host "   - 点击'Save'按钮" -ForegroundColor White
Write-Host ""
Write-Host "6. 等待几分钟，你的网站就可以访问了！" -ForegroundColor White
Write-Host ""
Write-Host "你的网站URL格式：" -ForegroundColor Yellow
Write-Host "https://$username.github.io/$($repo_url -replace 'https://github.com/[^/]+/([^/]+)\.git','$1')/" -ForegroundColor Green
Write-Host ""

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "部署完成！" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "请按照上面的步骤启用GitHub Pages" -ForegroundColor Yellow
Write-Host "有任何问题请联系技术支持" -ForegroundColor Yellow
Write-Host ""
Read-Host -Prompt "按Enter键退出..."