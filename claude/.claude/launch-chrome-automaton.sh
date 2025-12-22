#!/bin/bash

# Launch Chrome Canary for browser automation
# This script ensures Chrome Canary is running with remote debugging enabled

CHROME_BINARY="/Applications/Google Chrome Canary.app/Contents/MacOS/Google Chrome Canary"
USER_DATA_DIR="/tmp/chrome_canary_automaton"
DEBUG_PORT=9222

# Check if Chrome is already running with remote debugging on the correct port
if lsof -ti:$DEBUG_PORT >/dev/null 2>&1; then
  echo "Chrome Canary is already running with remote debugging on port $DEBUG_PORT"
  exit 0
fi

# Launch Chrome Canary with remote debugging
echo "Launching Chrome Canary..."
/Applications/Google\ Chrome\ Canary.app/Contents/MacOS/Google\ Chrome\ Canary \
  --remote-debugging-port=$DEBUG_PORT \
  --user-data-dir="$USER_DATA_DIR" \
  --profile-directory="Profile 1" &

# Wait for Chrome to start (try for up to 5 seconds)
for i in {1..10}; do
  if lsof -ti:$DEBUG_PORT >/dev/null 2>&1; then
    echo "Chrome Canary launched successfully with remote debugging enabled"
    exit 0
  fi
  sleep 0.5
done

echo "Warning: Chrome Canary may not have started with remote debugging. Check manually."
exit 1
