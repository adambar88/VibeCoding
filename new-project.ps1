<#
.SYNOPSIS
    Creates a new project from the VibeCoding template.

.DESCRIPTION
    Clones the VibeCoding template repository, removes its git history,
    and initializes a fresh repo ready for development.

.PARAMETER Name
    The name of the new project folder.

.PARAMETER Path
    The parent directory where the project will be created. Defaults to current directory.

.EXAMPLE
    .\new-project.ps1 my-awesome-app

.EXAMPLE
    .\new-project.ps1 my-awesome-app -Path C:\Projects
#>

param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Name,

    [Parameter(Position = 1)]
    [string]$Path = (Get-Location)
)

$ErrorActionPreference = "Stop"
$projectDir = Join-Path $Path $Name

if (Test-Path $projectDir) {
    Write-Error "Directory '$projectDir' already exists. Choose a different name or remove it first."
    exit 1
}

Write-Host "Creating new project '$Name' from VibeCoding template..." -ForegroundColor Cyan

# Clone the template
git clone https://github.com/adambar88/VibeCoding.git $projectDir
if ($LASTEXITCODE -ne 0) { exit 1 }

# Remove template git history
Push-Location $projectDir
Remove-Item -Recurse -Force .git

# Initialize fresh repo
git init
git add -A
git commit -m "Initial commit from Vibe Coding template"

Write-Host ""
Write-Host "Project '$Name' created at: $projectDir" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. cd $projectDir"
Write-Host "  2. Open in VS Code: code ."
Write-Host "  3. Run /init-project in Copilot Chat to customize for your stack"
Write-Host "  4. Run /build-app to build your application autonomously"

Pop-Location
