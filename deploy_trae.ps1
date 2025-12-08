# Zodiac Match Tool Deployment Script for Trae CN

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Zodiac Match Tool Deployment for Trae CN" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Check Git
Write-Host "1. Checking Git..." -ForegroundColor Yellow
try {
    $gitVersion = git --version 2>&1
    Write-Host "Git is ready: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "Git is not installed. Please install Git from https://gitforwindows.org/" -ForegroundColor Red
    Read-Host -Prompt "Press Enter to exit"
    Exit 1
}
Write-Host ""

# Step 2: Initialize Git repo if needed
Write-Host "2. Checking Git repository..." -ForegroundColor Yellow
if (-not (Test-Path ".git")) {
    Write-Host "Initializing Git repository..." -ForegroundColor Yellow
    git init 2>&1 | Write-Host
}
Write-Host "Git repository is ready" -ForegroundColor Green
Write-Host ""

# Step 3: Add and commit changes
Write-Host "3. Committing changes..." -ForegroundColor Yellow
git add . 2>&1 | Write-Host
git commit -m "Auto deploy from Trae CN" 2>&1 | Write-Host
Write-Host "Changes committed" -ForegroundColor Green
Write-Host ""

# Step 4: Push to GitHub
Write-Host "4. Pushing to GitHub..." -ForegroundColor Yellow
Write-Host "Note: If this is your first time, you may need to configure remote repository." -ForegroundColor Yellow
Write-Host "Use: git remote add origin https://github.com/your-username/your-repo.git" -ForegroundColor Yellow
git push -u origin main 2>&1 | Write-Host
Write-Host ""

# Step 5: Deployment instructions
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "DEPLOYMENT INSTRUCTIONS" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "1. Go to your GitHub repo page" -ForegroundColor White
Write-Host "2. Click 'Settings' tab" -ForegroundColor White
Write-Host "3. Click 'Pages' in left menu" -ForegroundColor White
Write-Host "4. Select 'main' branch in 'Source' section" -ForegroundColor White
Write-Host "5. Click 'Save'" -ForegroundColor White
Write-Host ""
Write-Host "Your site will be available at: https://username.github.io/repo/" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Cyan

Read-Host -Prompt "Press Enter to exit"