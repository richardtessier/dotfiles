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
  "Claude Sonnet 4") model="Sonnet 4" ;;
  "Claude Sonnet 4.5") model="Sonnet 4.5" ;;
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

# Get and shorten current directory to ~30 chars
dir=$(echo "$input" | jq -r '.cwd // empty')
[ -z "$dir" ] && dir="$PWD"

# Replace home directory with ~
dir="${dir/#$HOME/~}"

# Shorten path if longer than 30 chars by removing middle directories
max_len=30
if [ ${#dir} -gt $max_len ]; then
  IFS='/' read -ra parts <<< "$dir"
  num_parts=${#parts[@]}

  if [ $num_parts -gt 2 ]; then
    # Keep first and last parts, collapse middle
    first="${parts[0]}/${parts[1]}"
    last="${parts[$((num_parts-1))]}"
    dir="${first}/.../.../${last}"

    # If still too long, just show .../last two dirs
    if [ ${#dir} -gt $max_len ] && [ $num_parts -gt 3 ]; then
      second_last="${parts[$((num_parts-2))]}"
      dir=".../${second_last}/${last}"
    fi
  fi
fi

# Output the statusline
printf "[%s] %s %d%% (%s)" "$model" "$bar" "$used" "$dir"
