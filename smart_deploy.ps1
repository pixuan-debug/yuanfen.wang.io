# 智能部署脚本 - 自动处理Git路径问题
# 适用于 Trae CN 开发环境

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Zodiac Match Tool - 智能部署脚本" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# 函数：检测Git安装路径
function Find-GitPath {
    Write-Host "检测Git安装路径..." -ForegroundColor Yellow
    
    # 常见的Git安装路径
    $commonPaths = @(
        "C:\Program Files\Git\bin\git.exe",
        "C:\Program Files (x86)\Git\bin\git.exe",
        "$env:LOCALAPPDATA\Programs\Git\bin\git.exe",
        "$env:ProgramFiles\Git\bin\git.exe",
        "$env:ProgramFiles(x86)\Git\bin\git.exe"
    )
    
    # 检查PATH中的Git
    $gitInPath = Get-Command git -ErrorAction SilentlyContinue
    if ($gitInPath) {
        Write-Host "✅ Git在PATH中找到: $($gitInPath.Source)" -ForegroundColor Green
        return $gitInPath.Source
    }
    
    # 检查常见路径
    foreach ($path in $commonPaths) {
        if (Test-Path $path) {
            Write-Host "✅ Git在常见路径找到: $path" -ForegroundColor Green
            return $path
        }
    }
    
    # 尝试搜索整个系统
    Write-Host "🔍 正在系统中搜索Git..." -ForegroundColor Yellow
    $gitPaths = Get-ChildItem -Path "C:\" -Name "git.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 10
    
    if ($gitPaths) {
        foreach ($gitPath in $gitPaths) {
            $fullPath = "C:\$gitPath"
            if (Test-Path $fullPath) {
                Write-Host "✅ Git在系统中找到: $fullPath" -ForegroundColor Green
                return $fullPath
            }
        }
    }
    
    return $null
}

# 函数：运行Git命令
function Run-GitCommand {
    param(
        [string]$Command,
        [string]$GitPath
    )
    
    if ($GitPath) {
        & "$GitPath" $Command.Split(' ') 2>&1
    } else {
        git $Command.Split(' ') 2>&1
    }
}

# 主程序开始

# 1. 检测Git
$gitPath = Find-GitPath

if (-not $gitPath) {
    Write-Host "❌ 未找到Git安装！" -ForegroundColor Red
    Write-Host "" -ForegroundColor Red
    Write-Host "请按照以下步骤安装Git：" -ForegroundColor Yellow
    Write-Host "1. 访问 https://gitforwindows.org/" -ForegroundColor White
    Write-Host "2. 下载并安装Git" -ForegroundColor White
    Write-Host "3. 确保勾选'Add Git to PATH'选项" -ForegroundColor White
    Write-Host "4. 重启Trae CN终端后重试" -ForegroundColor White
    Write-Host "" -ForegroundColor Red
    Read-Host -Prompt "按Enter键退出"
    Exit 1
}

Write-Host "Git版本: $(Run-GitCommand --version $gitPath)" -ForegroundColor Green
Write-Host ""

# 2. 检查当前目录
$currentDir = Get-Location
Write-Host "当前目录: $currentDir" -ForegroundColor Yellow

# 3. 初始化Git仓库（如果需要）
if (-not (Test-Path ".git")) {
    Write-Host "初始化Git仓库..." -ForegroundColor Yellow
    Run-GitCommand init $gitPath | Write-Host
    Write-Host "✅ Git仓库初始化成功" -ForegroundColor Green
} else {
    Write-Host "✅ Git仓库已存在" -ForegroundColor Green
}

Write-Host ""

# 4. 配置Git用户信息
Write-Host "检查Git用户信息..." -ForegroundColor Yellow
$gitName = Run-GitCommand config user.name $gitPath
$gitEmail = Run-GitCommand config user.email $gitPath

if (-not $gitName -or -not $gitEmail) {
    Write-Host "需要配置Git用户信息：" -ForegroundColor Yellow
    $username = Read-Host -Prompt "请输入GitHub用户名"
    $email = Read-Host -Prompt "请输入GitHub邮箱"
    
    Run-GitCommand "config user.name '$username'" $gitPath | Write-Host
    Run-GitCommand "config user.email '$email'" $gitPath | Write-Host
    Write-Host "✅ Git用户信息配置成功" -ForegroundColor Green
} else {
    Write-Host "✅ Git用户信息已配置：" -ForegroundColor Green
    Write-Host "   用户名: $gitName" -ForegroundColor White
    Write-Host "   邮箱: $gitEmail" -ForegroundColor White
}

Write-Host ""

# 5. 检查远程仓库
Write-Host "检查远程仓库配置..." -ForegroundColor Yellow
$remote = Run-GitCommand "remote -v" $gitPath | Select-String "origin"

if (-not $remote) {
    Write-Host "⚠️  未配置远程仓库！" -ForegroundColor Yellow
    Write-Host "请按照以下步骤配置：" -ForegroundColor White
    Write-Host "1. 登录GitHub创建新仓库" -ForegroundColor White
    Write-Host "2. 复制仓库URL（格式：https://github.com/用户名/仓库名.git）" -ForegroundColor White
    Write-Host ""
    
    $repoUrl = Read-Host -Prompt "请输入GitHub仓库URL"
    if (-not $repoUrl) {
        Write-Host "❌ 未提供仓库URL，跳过配置" -ForegroundColor Red
    } else {
        Run-GitCommand "remote add origin $repoUrl" $gitPath | Write-Host
        Run-GitCommand "branch -M main" $gitPath | Write-Host
        Write-Host "✅ 远程仓库配置成功" -ForegroundColor Green
    }
} else {
    Write-Host "✅ 远程仓库已配置：" -ForegroundColor Green
    $remote | Write-Host
}

Write-Host ""

# 6. 添加和提交更改
Write-Host "添加并提交更改..." -ForegroundColor Yellow
Run-GitCommand "add ." $gitPath | Write-Host
$commitMsg = "[自动部署] $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Run-GitCommand "commit -m '$commitMsg'" $gitPath | Write-Host
Write-Host "✅ 更改提交成功" -ForegroundColor Green

Write-Host ""

# 7. 推送到GitHub
Write-Host "推送到GitHub..." -ForegroundColor Yellow
Write-Host "⚠️  首次推送需要输入GitHub凭据！" -ForegroundColor Yellow
Write-Host "如果使用SSH密钥，则无需输入。" -ForegroundColor Yellow
Write-Host ""

$pushResult = Run-GitCommand "push -u origin main" $gitPath
if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ 推送成功！" -ForegroundColor Green
} else {
    Write-Host "❌ 推送失败，错误信息：" -ForegroundColor Red
    $pushResult | Write-Host -ForegroundColor Red
    Write-Host "" -ForegroundColor Red
    Write-Host "常见解决方案：" -ForegroundColor Yellow
    Write-Host "1. 检查GitHub仓库URL是否正确" -ForegroundColor White
    Write-Host "2. 检查网络连接" -ForegroundColor White
    Write-Host "3. 确保您有仓库推送权限" -ForegroundColor White
    Write-Host "4. 尝试使用SSH密钥替代HTTPS" -ForegroundColor White
    Write-Host "5. 检查是否已登录GitHub（使用git credential-manager）" -ForegroundColor White
}

Write-Host ""

# 8. 显示部署说明
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "📋 部署完成！下一步操作：" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "1. 登录GitHub，进入您的仓库页面" -ForegroundColor White
Write-Host "2. 点击 'Settings' 选项卡" -ForegroundColor White
Write-Host "3. 点击 'Pages' 在左侧菜单" -ForegroundColor White
Write-Host "4. 在 'Source' 部分，选择 'main' 分支" -ForegroundColor White
Write-Host "5. 点击 'Save'" -ForegroundColor White
Write-Host "" -ForegroundColor White
Write-Host "您的网站将在几分钟后可访问：" -ForegroundColor Yellow
Write-Host "https://用户名.github.io/仓库名/" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Cyan

# 9. 提供本地预览选项
Write-Host ""
$preview = Read-Host -Prompt "是否启动本地预览？(y/n)"
if ($preview -eq "y" -or $preview -eq "Y") {
    Write-Host "启动本地预览服务器..." -ForegroundColor Yellow
    if (Test-Path "local_server.py") {
        python local_server.py
    } else {
        Write-Host "❌ 未找到local_server.py文件" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "感谢使用智能部署脚本！" -ForegroundColor Green
Read-Host -Prompt "按Enter键退出"
