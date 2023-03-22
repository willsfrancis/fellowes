#!/bin/bash

if [ -f "package.json" ]; then
  if command -v yarn > /dev/null 2>&1; then
    yarn install
  elif command -v npm > /dev/null 2>&1; then
    npm install
  else
    echo "Neither yarn nor npm is installed."
    exit 1
  fi
else
  echo "package.json not found in the project root."
  exit 1
fi
