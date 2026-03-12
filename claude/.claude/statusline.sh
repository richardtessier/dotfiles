#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract model display name (shorten common model names)
model=$(echo "$input" | jq -r '.model.display_name')
case "$model" in
  "Claude 3.5 Sonnet") model="Sonnet 3.5" ;;
  "Claude 3.5 Haiku") model="Haiku 3.5" ;;
  "Claude Opus 4") model="Opus 4" ;;
  "Claude Opus 4.5") model="Opus 4.5" ;;
  "Claude Opus 4.6") model="Opus 4.6" ;;
  "Claude Sonnet 4") model="Sonnet 4" ;;
  "Claude Sonnet 4.5") model="Sonnet 4.5" ;;
  "Claude Sonnet 4.6") model="Sonnet 4.6" ;;
esac

# Extract context usage percentage
used=$(echo "$input" | jq -r '.context_window.used_percentage // 0')

# Round to nearest integer
used=$(printf "%.0f" "$used")

# Create progress bar (10 blocks total)
bar_length=10
filled=$(( used * bar_length / 100 ))
empty=$(( bar_length - filled ))

# Build the progress bar with filled and empty blocks
bar=""
for ((i=0; i<filled; i++)); do
  bar="${bar}▓"
done
for ((i=0; i<empty; i++)); do
  bar="${bar}░"
done

# Get project name: prefer session_name, fall back to basename of project_dir, then cwd
project=$(echo "$input" | jq -r '.session_name // empty')
if [ -z "$project" ]; then
  project=$(echo "$input" | jq -r '.workspace.project_dir // empty')
  [ -n "$project" ] && project=$(basename "$project")
fi
if [ -z "$project" ]; then
  project=$(echo "$input" | jq -r '.cwd // empty')
  [ -n "$project" ] && project=$(basename "$project")
fi
[ -z "$project" ] && project=$(basename "$PWD")

# Output the statusline
printf "[%s] %s %d%% (%s)" "$model" "$bar" "$used" "$project"
