#!/bin/bash
if [ ! -d ".python/mac" ]; then
  echo "Extracting portable Python 3.12 for macOS..."
  mkdir -p .python/mac
  tar -xzf tools/python-mac.tar.gz -C .python/mac --strip-components=1
  chmod +x .python/mac/bin/python3
fi

# Ensure pip is installed and install requirements
.python/mac/bin/python3 -m ensurepip --default-pip 2>/dev/null || true
.python/mac/bin/python3 -m pip install -r requirements.txt
