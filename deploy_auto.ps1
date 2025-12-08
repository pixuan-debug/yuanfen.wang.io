# 自动化部署脚本 - 无需交互
# 用于 Trae CN 快捷键一键部署

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Zodiac Match Tool - 自动化部署" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# 检查Git是否可用
try {
    $gitVersion = git --version 2>&1
    Write-Host "Git版本: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "错误: Git未安装!" -ForegroundColor Red
    Write-Host "请从 https://gitforwindows.org/ 安装Git" -ForegroundColor Yellow
    exit 1
}

# 检查Git仓库
try {
    if (-not (Test-Path ".git")) {
        Write-Host "初始化Git仓库..." -ForegroundColor Yellow
        git init 2>&1 | Write-Host
    }
    
    # 自动添加和提交
    Write-Host "添加所有文件..." -ForegroundColor Yellow
    git add . 2>&1 | Write-Host
    
    Write-Host "提交更改..." -ForegroundColor Yellow
    git commit -m "[自动部署] $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" 2>&1 | Write-Host
    
    # 推送
    Write-Host "推送到GitHub..." -ForegroundColor Yellow
    git push origin main 2>&1 | Write-Host
    
    Write-Host "" -ForegroundColor Green
    Write-Host "✅ 部署成功!" -ForegroundColor Green
    Write-Host "请登录GitHub启用GitHub Pages" -ForegroundColor Yellow
    Write-Host "=========================================" -ForegroundColor Cyan
    
} catch {
    Write-Host "部署失败: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}