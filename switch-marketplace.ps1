# Marketplace Branch Switcher Script
# Usage: .\switch-marketplace.ps1 [master|staging]

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("master", "staging")]
    [string]$Branch
)

$MarketplacePath = "D:\Working\Automation\research"
$OpenCodeSkillsPath = "C:\Users\huanglong\.config\opencode\skills\hello-world"

Write-Host "🔄 Switching to $Branch marketplace..." -ForegroundColor Cyan

# Change to marketplace directory
Set-Location $MarketplacePath

# Checkout the desired branch
git checkout $Branch
if ($LASTEXITCODE -ne 0) {
    Write-Error "Failed to checkout branch $Branch"
    exit 1
}

# Copy the skill to OpenCode
Copy-Item -Path "$MarketplacePath\plugins\skills\hello-world\SKILL.md" `
          -Destination "$OpenCodeSkillsPath\SKILL.md" `
          -Force

# Show current version
$SkillContent = Get-Content "$OpenCodeSkillsPath\SKILL.md" -Raw
if ($SkillContent -match "Version:\s*(.+)") {
    $Version = $Matches[1].Trim()
    Write-Host "✅ Successfully switched to $Branch marketplace" -ForegroundColor Green
    Write-Host "📦 Current skill version: $Version" -ForegroundColor Yellow
}

# Show git status
git log --oneline -1