#!/usr/bin/env bash
set -euo pipefail

# 1. Configuration & OS/Architecture Detection
PYTHON_VERSION="3.12.8"
RELEASE_TAG="20250106"

OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
  Darwin)
    PLATFORM="apple-darwin"
    case "$ARCH" in
      arm64)  TARGET_ARCH="aarch64" ;;
      x86_64) TARGET_ARCH="x86_64" ;;
      *)      echo "Unsupported macOS architecture: $ARCH" >&2; exit 1 ;;
    esac
    ;;
  Linux)
    PLATFORM="unknown-linux-gnu"
    case "$ARCH" in
      aarch64|arm64) TARGET_ARCH="aarch64" ;;
      x86_64)        TARGET_ARCH="x86_64" ;;
      *)             echo "Unsupported Linux architecture: $ARCH" >&2; exit 1 ;;
    esac
    ;;
  *)
    echo "Unsupported OS: $OS" >&2
    exit 1
    ;;
esac

# Resolve workspace root (handles running from root or .vscode/)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ "$(basename "$SCRIPT_DIR")" == ".vscode" ]]; then
  WORKSPACE_ROOT="$(dirname "$SCRIPT_DIR")"
else
  WORKSPACE_ROOT="$SCRIPT_DIR"
fi

ARCHIVE_NAME="cpython-${PYTHON_VERSION}+${RELEASE_TAG}-${TARGET_ARCH}-${PLATFORM}-install_only.tar.gz"
DOWNLOAD_URL="https://github.com/astral-sh/python-build-standalone/releases/download/${RELEASE_TAG}/${ARCHIVE_NAME}"

TARGET_DIR="$WORKSPACE_ROOT/.python/unix"
BASE_PYTHON="$TARGET_DIR/bin/python3"
VENV_DIR="$WORKSPACE_ROOT/.venv-hangman"
VENV_PYTHON="$VENV_DIR/bin/python"
TEMP_ARCHIVE="$(mktemp -t python-standalone.XXXXXX.tar.gz)"

trap 'rm -f "$TEMP_ARCHIVE"' EXIT

echo "Setting up Python $PYTHON_VERSION ($TARGET_ARCH-$PLATFORM) in $WORKSPACE_ROOT..."

# 2. Download & Extract Standalone Python
if [[ ! -x "$BASE_PYTHON" ]]; then
  echo "Downloading portable Python $PYTHON_VERSION..."
  curl -fL --progress-bar "$DOWNLOAD_URL" -o "$TEMP_ARCHIVE"

  echo "Extracting Python to $TARGET_DIR..."
  rm -rf "$TARGET_DIR"
  mkdir -p "$TARGET_DIR"
  tar -xzf "$TEMP_ARCHIVE" -C "$TARGET_DIR" --strip-components=1
fi

# 3. Create Virtual Environment (.venv-hangman)
if [[ ! -x "$VENV_PYTHON" ]]; then
  echo "Creating virtual environment in $VENV_DIR..."
  "$BASE_PYTHON" -m venv "$VENV_DIR"
fi

# 4. Install Dependencies
echo "Upgrading pip and installing dependencies..."
"$VENV_PYTHON" -m pip install --upgrade pip --quiet

REQ_FILE="$WORKSPACE_ROOT/requirements.txt"
if [[ -f "$REQ_FILE" ]]; then
  "$VENV_PYTHON" -m pip install -r "$REQ_FILE"
else
  echo "Warning: No requirements.txt found at $REQ_FILE; skipping package installation."
fi

# 5. Configure VS Code to Automatically Use This Virtual Environment
VSCODE_DIR="$WORKSPACE_ROOT/.vscode"
SETTINGS_FILE="$VSCODE_DIR/settings.json"
mkdir -p "$VSCODE_DIR"

"$VENV_PYTHON" -c '
import json, os, sys

settings_path = sys.argv[1]
data = {}

if os.path.exists(settings_path):
    try:
        with open(settings_path, "r", encoding="utf-8") as f:
            data = json.load(f)
    except Exception:
        print("Warning: Existing settings.json could not be parsed; overwriting with clean settings.")

data["python.defaultInterpreterPath"] = "${workspaceFolder}/.venv-hangman/bin/python"
data["python.terminal.activateEnvironment"] = True

with open(settings_path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2)
    f.write("\n")
' "$SETTINGS_FILE"

echo ""
echo "Setup complete! Virtual environment configured for VS Code at $VENV_DIR"
