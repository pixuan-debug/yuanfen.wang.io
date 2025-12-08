# Simple Deployment Script - English Version
# For Trae CN Development Environment

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Zodiac Match Tool - Simple Deployment" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Check if Git is available
Write-Host "1. Checking Git..." -ForegroundColor Yellow

try {
    $gitVersion = git --version 2>&1
    Write-Host "Git is available: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "Git is not found in PATH" -ForegroundColor Red
    Write-Host "Please check if Git is installed and added to PATH" -ForegroundColor Yellow
    Write-Host "Download Git from: https://gitforwindows.org/" -ForegroundColor Yellow
    Read-Host -Prompt "Press Enter to exit"
    Exit 1
}

Write-Host ""

# Step 2: Initialize Git repo if needed
Write-Host "2. Checking Git repository..." -ForegroundColor Yellow

if (-not (Test-Path ".git")) {
    Write-Host "Initializing Git repository..." -ForegroundColor Yellow
    git init 2>&1 | Write-Host
    Write-Host "Git repository initialized" -ForegroundColor Green
} else {
    Write-Host "Git repository already exists" -ForegroundColor Green
}

Write-Host ""

# Step 3: Configure Git user info
Write-Host "3. Checking Git user info..." -ForegroundColor Yellow

$gitName = git config user.name 2>&1
$gitEmail = git config user.email 2>&1

if (-not $gitName -or $gitName -like "*fatal*" -or -not $gitEmail -or $gitEmail -like "*fatal*") {
    Write-Host "Git user info not set. Please configure:" -ForegroundColor Yellow
    $username = Read-Host -Prompt "Enter GitHub username"
    $email = Read-Host -Prompt "Enter GitHub email"
    
    git config user.name "$username" 2>&1 | Write-Host
    git config user.email "$email" 2>&1 | Write-Host
    Write-Host "Git user info configured" -ForegroundColor Green
} else {
    Write-Host "Git user info is set:" -ForegroundColor Green
    Write-Host "  Username: $gitName" -ForegroundColor White
    Write-Host "  Email: $gitEmail" -ForegroundColor White
}

Write-Host ""

# Step 4: Check remote repository
Write-Host "4. Checking remote repository..." -ForegroundColor Yellow

$remote = git remote -v 2>&1 | Select-String "origin"

if (-not $remote -or $remote -like "*fatal*") {
    Write-Host "Remote repository not configured" -ForegroundColor Yellow
    Write-Host "Please create a GitHub repo and provide the URL" -ForegroundColor White
    $repoUrl = Read-Host -Prompt "Enter GitHub repo URL (https://github.com/username/repo.git)"
    
    if ($repoUrl) {
        git remote add origin $repoUrl 2>&1 | Write-Host
        git branch -M main 2>&1 | Write-Host
        Write-Host "Remote repository configured" -ForegroundColor Green
    } else {
        Write-Host "No repo URL provided. Skipping remote configuration." -ForegroundColor Yellow
    }
} else {
    Write-Host "Remote repository is configured:" -ForegroundColor Green
    $remote | Write-Host
}

Write-Host ""

# Step 5: Add and commit changes
Write-Host "5. Committing changes..." -ForegroundColor Yellow

git add . 2>&1 | Write-Host
$commitMsg = "Auto deploy - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
git commit -m "$commitMsg" 2>&1 | Write-Host

Write-Host "Changes committed" -ForegroundColor Green
Write-Host ""

# Step 6: Push to GitHub
Write-Host "6. Pushing to GitHub..." -ForegroundColor Yellow
Write-Host "Note: First push may require GitHub credentials!" -ForegroundColor Yellow

$pushResult = git push -u origin main 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "Push successful!" -ForegroundColor Green
} else {
    Write-Host "Push failed. Error:" -ForegroundColor Red
    $pushResult | Write-Host -ForegroundColor Red
    Write-Host ""
    Write-Host "Common solutions:" -ForegroundColor Yellow
    Write-Host "1. Check GitHub repo URL is correct" -ForegroundColor White
    Write-Host "2. Check network connection" -ForegroundColor White
    Write-Host "3. Ensure you have push permissions" -ForegroundColor White
    Write-Host "4. Try using SSH key instead of HTTPS" -ForegroundColor White
}

Write-Host ""

# Step 7: Deployment instructions
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

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "DEPLOYMENT COMPLETED" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

Read-Host -Prompt "Press Enter to exit"