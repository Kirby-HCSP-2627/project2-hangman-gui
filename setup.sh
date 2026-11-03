#!/bin/bash
set -e # Exit immediately if a command encounters an error

# 1. Detect platform and architecture
OS="$(uname -s)"
ARCH="$(uname -m)"

case "${OS}" in
    Darwin*)
        if [ "${ARCH}" != "arm64" ]; then
            echo "Warning: Expected Apple Silicon (arm64), detected ${ARCH}."
        fi
        PLATFORM="mac"
        ARCHIVE="tools/python312-mac.tar.gz"
        TARGET_DIR=".python/mac"
        BASE_PYTHON="${TARGET_DIR}/bin/python3"
        VENV_DIR=".venv-hangman"
        VENV_PYTHON="${VENV_DIR}/bin/python"
        ;;
    CYGWIN*|MINGW*|MSYS*)
        PLATFORM="win"
        ARCHIVE="tools/python312-win.zip"
        TARGET_DIR=".python/win"
        BASE_PYTHON="${TARGET_DIR}/python.exe"
        VENV_DIR=".venv-hangman"
        VENV_PYTHON="${VENV_DIR}/Scripts/python.exe"
        ;;
    *)
        echo "Error: Unsupported operating system or environment (${OS})."
        exit 1
        ;;
esac

echo "Detected Platform: ${PLATFORM}"

# 2. Extract Portable Python base bundle if missing
if [ ! -f "${BASE_PYTHON}" ]; then
    if [ ! -f "${ARCHIVE}" ]; then
        echo "Error: Missing required bundle file '${ARCHIVE}' in tools/"
        exit 1
    fi

    echo "Extracting ${ARCHIVE} into ${TARGET_DIR}..."
    rm -rf "${TARGET_DIR}"
    mkdir -p "${TARGET_DIR}"
    
    if [ "${PLATFORM}" = "mac" ]; then
        tar -xzf "${ARCHIVE}" -C "${TARGET_DIR}" --strip-components=1
        chmod +x "${BASE_PYTHON}"
    elif [ "${PLATFORM}" = "win" ]; then
        unzip -q "${ARCHIVE}" -d "${TARGET_DIR}"
    fi
fi

# 3. Create Custom Virtual Environment (.venv-hangman)
if [ ! -d "${VENV_DIR}" ]; then
    echo "Creating virtual environment in ${VENV_DIR}..."
    "${BASE_PYTHON}" -m venv "${VENV_DIR}"
fi

# 4. Install requirements into the custom venv
echo "Installing dependencies into ${VENV_DIR}..."
"${VENV_PYTHON}" -m pip install --upgrade pip
"${VENV_PYTHON}" -m pip install -r requirements.txt

echo "Setup completed successfully! Virtual environment is ready at ${VENV_DIR}"