# 命理正缘查询工具PowerShell部署脚本
# 适用于Trae CN开发工具环境

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "命理正缘查询工具一键部署脚本" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# 检查Git是否安装
Try {
    $gitVersion = git --version
    Write-Host "Git已安装，版本：" -ForegroundColor Green
    Write-Host $gitVersion -ForegroundColor Green
    Write-Host ""
} Catch {
    Write-Host "错误：未安装Git，请先安装Git" -ForegroundColor Red
    Write-Host "下载地址：https://gitforwindows.org/" -ForegroundColor Yellow
    Read-Host -Prompt "按Enter键退出"
    Exit 1
}

# 检查是否已初始化Git仓库
if (-not (Test-Path ".git")) {
    Write-Host "初始化Git仓库..." -ForegroundColor Yellow
    git init
    Write-Host ""
}

# 设置Git用户信息（如果尚未设置）
Try {
    $gitName = git config user.name
    if (-not $gitName) {
        $username = Read-Host -Prompt "请输入GitHub用户名"
        git config user.name "$username"
    }
    
    $gitEmail = git config user.email
    if (-not $gitEmail) {
        $email = Read-Host -Prompt "请输入GitHub邮箱"
        git config user.email "$email"
    }
} Catch {
    Write-Host "设置Git用户信息失败，请手动设置" -ForegroundColor Red
    Read-Host -Prompt "按Enter键退出"
    Exit 1
}

Write-Host ""

# 添加所有文件到暂存区
Write-Host "添加文件到暂存区..." -ForegroundColor Yellow
git add .
Write-Host ""

# 提交更改
$commit_msg = Read-Host -Prompt "请输入提交信息（默认为'Update'）"
if (-not $commit_msg) {
    $commit_msg = "Update"
}

Write-Host "提交更改：$commit_msg" -ForegroundColor Yellow
git commit -m "$commit_msg"
Write-Host ""

# 检查是否已添加远程仓库
Try {
    $remote = git remote -v | Select-String "origin"
    if (-not $remote) {
        $repo_url = Read-Host -Prompt "请输入GitHub仓库URL（格式：https://github.com/用户名/仓库名.git）"
        git remote add origin $repo_url
        git branch -M main
        Write-Host ""
    }
} Catch {
    Write-Host "检查远程仓库失败" -ForegroundColor Red
    Read-Host -Prompt "按Enter键退出"
    Exit 1
}

# 推送代码到GitHub
Write-Host "推送代码到GitHub..." -ForegroundColor Yellow
git push -u origin main
Write-Host ""

# 提示用户在GitHub上启用GitHub Pages
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "部署成功！" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "请登录GitHub，在仓库设置中启用GitHub Pages：" -ForegroundColor Yellow
Write-Host "1. 进入仓库页面" -ForegroundColor White
Write-Host "2. 点击\"Settings\"选项卡" -ForegroundColor White
Write-Host "3. 在左侧菜单中点击\"Pages\"" -ForegroundColor White
Write-Host "4. 在\"Source\"部分，选择\"main\"分支" -ForegroundColor White
Write-Host "5. 点击\"Save\"" -ForegroundColor White
Write-Host ""
Write-Host "部署的网站将在几分钟后可访问，URL格式：" -ForegroundColor Yellow
Write-Host "https://用户名.github.io/仓库名/" -ForegroundColor White
Write-Host "=========================================" -ForegroundColor Cyan

Read-Host -Prompt "按Enter键退出"