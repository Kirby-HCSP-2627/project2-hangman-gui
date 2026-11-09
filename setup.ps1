$ErrorActionPreference = "Stop"

# 1. Set Windows paths and environment variables
$Platform = "win"
$Archive = "tools\python312-win.zip"
$TargetDir = Join-Path $PSScriptRoot ".python\win"
$BasePython = Join-Path $TargetDir "python.exe"
$VenvDir = Join-Path $PSScriptRoot ".venv-hangman"
$VenvPython = Join-Path $VenvDir "Scripts\python.exe"

Write-Host "Detected Platform: $Platform"

# 2. Extract Portable Python base bundle if missing
if (-not (Test-Path -Path $BasePython)) {
    $ArchivePath = Join-Path $PSScriptRoot $Archive
    if (-not (Test-Path -Path $ArchivePath)) {
        Write-Error "Error: Missing required bundle file '$Archive' in tools/"
        exit 1
    }

    Write-Host "Extracting $Archive into $TargetDir..."
    if (Test-Path -Path $TargetDir) {
        Remove-Item -Recurse -Force -Path $TargetDir
    }
    New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

    # Native extraction
    Expand-Archive -Path $ArchivePath -DestinationPath $TargetDir -Force

    # Handle nested subfolder extraction if the ZIP contained a top-level directory
    $subDirs = Get-ChildItem -Path $TargetDir -Directory
    if ($subDirs.Count -eq 1 -and -not (Test-Path -Path $BasePython)) {
        $nestedPath = $subDirs[0].FullName
        Get-ChildItem -Path $nestedPath | Move-Item -Destination $TargetDir -Force
        Remove-Item -Recurse -Force -Path $nestedPath
    }

    # Enable site-packages if using standard Windows embeddable Python distribution
    $pthFile = Get-ChildItem -Path $TargetDir -Filter "*._pth" | Select-Object -First 1
    if ($pthFile) {
        (Get-Content $pthFile.FullName) -replace '#\s*import site', 'import site' | Set-Content $pthFile.FullName
    }
}

# 3. Create Custom Virtual Environment (.venv-hangman)
if (-not (Test-Path -Path $VenvDir)) {
    Write-Host "Creating virtual environment in $VenvDir..."
    & "$BasePython" -m venv "$VenvDir"
}

# 4. Install requirements into the custom venv
Write-Host "Installing dependencies into $VenvDir..."
& "$VenvPython" -m pip install --upgrade pip
& "$VenvPython" -m pip install -r (Join-Path $PSScriptRoot "requirements.txt")

Write-Host "Setup completed successfully! Virtual environment is ready at $VenvDir"
