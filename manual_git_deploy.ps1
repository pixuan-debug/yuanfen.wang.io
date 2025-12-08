# Manual Git Deployment Script
# Allows user to specify Git path manually
# For Trae CN Development Environment

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "Zodiac Match Tool - Manual Git Deployment" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Get Git path from user
Write-Host "Step 1: Configure Git Path" -ForegroundColor Yellow
Write-Host "Please provide the full path to git.exe"
Write-Host "Example: C:\Program Files\Git\bin\git.exe"
Write-Host ""

$gitPath = Read-Host -Prompt "Enter Git path (leave blank to try auto-detect)"

# Try auto-detect if no path provided
if (-not $gitPath) {
    Write-Host "Trying to auto-detect Git..." -ForegroundColor Yellow
    
    # Check PATH
    $gitInPath = Get-Command git -ErrorAction SilentlyContinue
    if ($gitInPath) {
        $gitPath = $gitInPath.Source
        Write-Host "Found Git in PATH: $gitPath" -ForegroundColor Green
    } else {
        # Check common paths
        $commonPaths = @(
            "C:\Program Files\Git\bin\git.exe",
            "C:\Program Files (x86)\Git\bin\git.exe",
            "$env:LOCALAPPDATA\Programs\Git\bin\git.exe"
        )
        
        $found = $false
        foreach ($path in $commonPaths) {
            if (Test-Path $path) {
                $gitPath = $path
                Write-Host "Found Git at common path: $gitPath" -ForegroundColor Green
                $found = $true
                break
            }
        }
        
        if (-not $found) {
            Write-Host "❌ Git not found!" -ForegroundColor Red
            Write-Host "Please install Git from https://gitforwindows.org/" -ForegroundColor Yellow
            Write-Host "Or provide the exact path to git.exe" -ForegroundColor Yellow
            Read-Host -Prompt "Press Enter to exit"
            Exit 1
        }
    }
}

# Verify Git path exists
if (-not (Test-Path $gitPath)) {
    Write-Host "❌ Git path does not exist: $gitPath" -ForegroundColor Red
    Read-Host -Prompt "Press Enter to exit"
    Exit 1
}

Write-Host "✅ Git path verified: $gitPath" -ForegroundColor Green
Write-Host ""

# Step 2: Show Git version
Write-Host "Step 2: Git Version" -ForegroundColor Yellow
& "$gitPath" --version
Write-Host ""

# Step 3: Initialize Git repo if needed
Write-Host "Step 3: Git Repository" -ForegroundColor Yellow

if (-not (Test-Path ".git")) {
    Write-Host "Initializing Git repository..." -ForegroundColor Yellow
    & "$gitPath" init
    Write-Host "✅ Git repository initialized" -ForegroundColor Green
} else {
    Write-Host "✅ Git repository already exists" -ForegroundColor Green
}

Write-Host ""

# Step 4: Configure Git user info
Write-Host "Step 4: Git User Info" -ForegroundColor Yellow

$gitName = & "$gitPath" config user.name
$gitEmail = & "$gitPath" config user.email

if (-not $gitName -or -not $gitEmail) {
    Write-Host "Git user info not set. Please configure:" -ForegroundColor Yellow
    $username = Read-Host -Prompt "Enter GitHub username"
    $email = Read-Host -Prompt "Enter GitHub email"
    
    & "$gitPath" config user.name "$username"
    & "$gitPath" config user.email "$email"
    Write-Host "✅ Git user info configured" -ForegroundColor Green
} else {
    Write-Host "✅ Git user info is set:" -ForegroundColor Green
    Write-Host "  Username: $gitName" -ForegroundColor White
    Write-Host "  Email: $gitEmail" -ForegroundColor White
}

Write-Host ""

# Step 5: Configure remote repository
Write-Host "Step 5: Remote Repository" -ForegroundColor Yellow

$remote = & "$gitPath" remote -v | Select-String "origin"

if (-not $remote) {
    Write-Host "Remote repository not configured. Please provide GitHub repo URL:" -ForegroundColor Yellow
    $repoUrl = Read-Host -Prompt "Enter GitHub repo URL (https://github.com/username/repo.git)"
    
    if ($repoUrl) {
        & "$gitPath" remote add origin $repoUrl
        & "$gitPath" branch -M main
        Write-Host "✅ Remote repository configured" -ForegroundColor Green
    } else {
        Write-Host "⚠️  No repo URL provided. Skipping remote configuration." -ForegroundColor Yellow
    }
} else {
    Write-Host "✅ Remote repository is configured:" -ForegroundColor Green
    $remote
}

Write-Host ""

# Step 6: Add and commit changes
Write-Host "Step 6: Commit Changes" -ForegroundColor Yellow

& "$gitPath" add .
$commitMsg = "Auto deploy - $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
& "$gitPath" commit -m "$commitMsg"

Write-Host "✅ Changes committed" -ForegroundColor Green
Write-Host ""

# Step 7: Push to GitHub
Write-Host "Step 7: Push to GitHub" -ForegroundColor Yellow
Write-Host "Note: First push may require GitHub credentials!" -ForegroundColor Yellow

& "$gitPath" push -u origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "✅ Push successful!" -ForegroundColor Green
} else {
    Write-Host "❌ Push failed. Please check the error message above." -ForegroundColor Red
}

Write-Host ""

# Step 8: Deployment instructions
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