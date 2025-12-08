# Zodiac Match Tool Deployment Script
# For Trae CN Development Environment

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Zodiac Match Tool One-Click Deployment" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# Check if Git is installed
Write-Host "Checking Git installation..." -ForegroundColor Yellow
try {
    $gitVersion = git --version
    Write-Host "Git is installed: $gitVersion" -ForegroundColor Green
    Write-Host ""
} catch {
    Write-Host "Error: Git is not installed. Please install Git first." -ForegroundColor Red
    Write-Host "Download URL: https://gitforwindows.org/" -ForegroundColor Yellow
    Read-Host -Prompt "Press Enter to exit"
    Exit 1
}

# Check if Git repo is initialized
Write-Host "Checking Git repository..." -ForegroundColor Yellow
if (-not (Test-Path ".git")) {
    Write-Host "Initializing Git repository..." -ForegroundColor Yellow
    git init
    Write-Host ""
}

# Set Git user info if not already set
try {
    $gitName = git config user.name
    if (-not $gitName) {
        $username = Read-Host -Prompt "Enter GitHub username"
        git config user.name "$username"
    }
    
    $gitEmail = git config user.email
    if (-not $gitEmail) {
        $email = Read-Host -Prompt "Enter GitHub email"
        git config user.email "$email"
    }
} catch {
    Write-Host "Failed to set Git user info. Please set it manually." -ForegroundColor Red
    Read-Host -Prompt "Press Enter to exit"
    Exit 1
}

Write-Host ""

# Add all files to staging
Write-Host "Adding files to staging..." -ForegroundColor Yellow
git add .
Write-Host ""

# Commit changes
$commit_msg = Read-Host -Prompt "Enter commit message (default: 'Update')"
if (-not $commit_msg) {
    $commit_msg = "Update"
}

Write-Host "Committing changes: $commit_msg" -ForegroundColor Yellow
git commit -m "$commit_msg"
Write-Host ""

# Check if remote repo is configured
try {
    $remote = git remote -v | Select-String "origin"
    if (-not $remote) {
        $repo_url = Read-Host -Prompt "Enter GitHub repo URL (format: https://github.com/username/repo.git)"
        git remote add origin $repo_url
        git branch -M main
        Write-Host ""
    }
} catch {
    Write-Host "Failed to check remote repository. Please configure it manually." -ForegroundColor Red
    Read-Host -Prompt "Press Enter to exit"
    Exit 1
}

# Push to GitHub
Write-Host "Pushing to GitHub..." -ForegroundColor Yellow
git push -u origin main
Write-Host ""

# Instructions for GitHub Pages
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Deployment completed!" -ForegroundColor Green
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Please enable GitHub Pages in your repo settings:" -ForegroundColor Yellow
Write-Host "1. Go to your repo page" -ForegroundColor White
Write-Host "2. Click 'Settings' tab" -ForegroundColor White
Write-Host "3. Click 'Pages' in the left menu" -ForegroundColor White
Write-Host "4. In 'Source' section, select 'main' branch" -ForegroundColor White
Write-Host "5. Click 'Save'" -ForegroundColor White
Write-Host ""
Write-Host "Your site will be available in a few minutes at:" -ForegroundColor Yellow
Write-Host "https://username.github.io/repo/" -ForegroundColor White
Write-Host "=========================================" -ForegroundColor Cyan

Read-Host -Prompt "Press Enter to exit"