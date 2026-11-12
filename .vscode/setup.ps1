$ErrorActionPreference = "Stop"

# 1. Configuration & Architecture Detection
$PythonVersion = "3.12.8"
$Arch = if ($env:PROCESSOR_ARCHITECTURE -eq "ARM64") { "pythonarm64" } else { "python" }
$NuGetUrl = "https://www.nuget.org/api/v2/package/$Arch/$PythonVersion"

# Resolve workspace root (handles running from root or .vscode/)
$WorkspaceRoot = if ((Split-Path $PSScriptRoot -Leaf) -eq ".vscode") {
    Split-Path $PSScriptRoot -Parent
} else {
    $PSScriptRoot
}

$TargetDir  = Join-Path $WorkspaceRoot ".python\win"
$BasePython = Join-Path $TargetDir "tools\python.exe"
$VenvDir    = Join-Path $WorkspaceRoot ".venv-hangman"
$VenvPython = Join-Path $VenvDir "Scripts\python.exe"
$TempZip    = Join-Path $env:TEMP "python-$PythonVersion-$Arch.zip"

Write-Host "Setting up Python $PythonVersion ($Arch) in $WorkspaceRoot..."

# 2. Download & Extract Full Portable Python (via Official NuGet Package)
if (-not (Test-Path -Path $BasePython)) {
    Write-Host "Downloading official Python $PythonVersion package..."
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri $NuGetUrl -OutFile $TempZip -UseBasicParsing

    Write-Host "Extracting Python to $TargetDir..."
    if (Test-Path -Path $TargetDir) {
        Remove-Item -Recurse -Force -Path $TargetDir
    }
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

    Expand-Archive -Path $TempZip -DestinationPath $TargetDir -Force
    Remove-Item -Force -Path $TempZip -ErrorAction SilentlyContinue
}

# 3. Create Virtual Environment (.venv-hangman)
if (-not (Test-Path -Path $VenvPython)) {
    Write-Host "Creating virtual environment in $VenvDir..."
    & "$BasePython" -m venv "$VenvDir"
}

# 4. Install Dependencies
Write-Host "Upgrading pip and installing dependencies..."
& "$VenvPython" -m pip install --upgrade pip --quiet

$ReqFile = Join-Path $WorkspaceRoot "requirements.txt"
if (Test-Path -Path $ReqFile) {
    & "$VenvPython" -m pip install -r "$ReqFile"
} else {
    Write-Warning "No requirements.txt found at $ReqFile; skipping package installation."
}

# 5. Configure VS Code to Automatically Use This Virtual Environment
$VsCodeDir    = Join-Path $WorkspaceRoot ".vscode"
$SettingsFile = Join-Path $VsCodeDir "settings.json"
New-Item -ItemType Directory -Force -Path $VsCodeDir | Out-Null

$Settings = @{}
if (Test-Path -Path $SettingsFile) {
    try {
        $Parsed = Get-Content $SettingsFile -Raw | ConvertFrom-Json
        if ($Parsed) {
            $Parsed.PSObject.Properties | ForEach-Object { $Settings[$_.Name] = $_.Value }
        }
    } catch {
        Write-Warning "Existing settings.json could not be parsed; overwriting with clean settings."
    }
}

$Settings["python.defaultInterpreterPath"] = '${workspaceFolder}/.venv-hangman/Scripts/python.exe'
$Settings["python.terminal.activateEnvironment"] = $true

$Settings | ConvertTo-Json -Depth 10 | Set-Content -Path $SettingsFile -Encoding UTF8

Write-Host "`nSetup complete! Virtual environment configured for VS Code at $VenvDir" -ForegroundColor Green
