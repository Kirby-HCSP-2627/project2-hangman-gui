if (-not (Test-Path ".python\win")) {
    Write-Host "Extracting portable Python 3.12 for Windows..."
    Expand-Archive -Path "tools\python-win.zip" -DestinationPath ".python\win" -Force
}

# Ensure pip is installed and install requirements
.\.python\win\python.exe -m ensurepip --default-pip 2>$null
.\.python\win\python.exe -m pip install -r requirements.txt
