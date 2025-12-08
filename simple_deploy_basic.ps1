# 命理正缘查询工具 - 简单部署脚本
# 适用于所有用户，尤其是小白

Write-Host "========================================="
Write-Host "命理正缘查询工具 - 部署助手"
Write-Host "========================================="
Write-Host ""
Write-Host "这个工具会帮助你部署网站，一步步按照提示操作即可！"
Write-Host ""
Write-Host "按任意键开始..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# 步骤1：检查Git
Write-Host "`n1. 检查Git是否安装"
Write-Host "------------------------"

try {
    git --version > $null 2>&1
    Write-Host "✓ Git已安装，继续下一步"
} catch {
    Write-Host "✗ Git未安装！请先安装Git："
    Write-Host "下载地址：https://gitforwindows.org/"
    Write-Host "安装时请勾选'Add Git to PATH'选项"
    Write-Host ""
    Write-Host "安装完成后重新运行此脚本"
    Write-Host "按任意键退出..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host "按任意键继续..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# 步骤2：初始化仓库
Write-Host "`n2. 初始化Git仓库"
Write-Host "------------------------"

if (-not (Test-Path ".git")) {
    Write-Host "正在初始化Git仓库..."
    git init
    Write-Host "✓ Git仓库初始化成功"
} else {
    Write-Host "✓ Git仓库已存在"
}

Write-Host "按任意键继续..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# 步骤3：设置用户信息
Write-Host "`n3. 设置GitHub用户信息"
Write-Host "------------------------"

$username = Read-Host "请输入你的GitHub用户名"
git config user.name $username

$email = Read-Host "请输入你的GitHub邮箱"
git config user.email $email

Write-Host "✓ 用户信息设置成功"
Write-Host "按任意键继续..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# 步骤4：配置远程仓库
Write-Host "`n4. 配置GitHub仓库"
Write-Host "------------------------"
Write-Host "请先在GitHub上创建一个新仓库，然后复制仓库URL"
Write-Host "格式：https://github.com/用户名/仓库名.git"
Write-Host ""

$repoUrl = Read-Host "请粘贴GitHub仓库URL"

if ($repoUrl) {
    git remote add origin $repoUrl
    git branch -M main
    Write-Host "✓ 远程仓库配置成功"
} else {
    Write-Host "✗ 未提供仓库URL，无法继续"
    Write-Host "按任意键退出..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host "按任意键继续..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# 步骤5：提交和推送
Write-Host "`n5. 提交并推送代码"
Write-Host "------------------------"

Write-Host "正在添加所有文件..."
git add .

Write-Host "正在提交更改..."
git commit -m "Initial deployment"

Write-Host "`n正在推送到GitHub..."
Write-Host "注意：首次推送会要求输入GitHub账号密码！"
Write-Host ""

git push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n✓ 推送成功！"
} else {
    Write-Host "`n✗ 推送失败，请检查错误信息"
    Write-Host "按任意键退出..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    exit 1
}

Write-Host "按任意键继续..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

# 步骤6：启用GitHub Pages
Write-Host "`n6. 启用GitHub Pages"
Write-Host "------------------------"
Write-Host "请按照以下步骤操作："
Write-Host "1. 登录GitHub，进入你的仓库"
Write-Host "2. 点击顶部的'Settings'"
Write-Host "3. 在左侧菜单点击'Pages'"
Write-Host "4. 在'Source'部分选择'main'分支"
Write-Host "5. 点击'Save'保存"
Write-Host ""
Write-Host "网站URL示例：https://$username.github.io/仓库名/"
Write-Host ""
Write-Host "等待几分钟，网站就可以访问了！"
Write-Host ""
Write-Host "========================================="
Write-Host "部署完成！"
Write-Host "========================================="
Write-Host ""
Write-Host "按任意键退出..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")