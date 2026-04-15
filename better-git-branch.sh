#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NO_COLOR='\033[0m'
BLUE='\033[0;34m'
YELLOW='\033[0;33m'

width1=5
width2=6
width3=30 # Width for the current branch
width4=20
max_branch_length=$width3

# Get current branch name
current_branch=$(git symbolic-ref --short HEAD)

# Function to count commits ahead/behind from current branch
count_commits() {
  local branch="$1"
  git rev-list --left-right --count "$current_branch...$branch" 2>/dev/null
}

# Print header
printf "${GREEN}%-${width1}s ${RED}%-${width2}s ${BLUE}%-${width3}s ${YELLOW}%-${width4}s${NO_COLOR}\n" "Ahead" "Behind" "Branch" "Last Commit"
printf "${GREEN}%-${width1}s ${RED}%-${width2}s ${BLUE}%-${width3}s ${YELLOW}%-${width4}s${NO_COLOR}\n" "-----" "------" "------------------------------" "-------------------"

format_string="%(refname:short)@%(committerdate:relative)"
IFS=$'\n'

for line in $(git for-each-ref --sort=-committerdate --format="$format_string" refs/heads/); do
  branch=$(echo "$line" | cut -d '@' -f1)
  time=$(echo "$line" | cut -d '@' -f2)

  if [ "$branch" = "$current_branch" ]; then
    ahead="-"
    behind="-"
    mark="*"
  else
    mark=" "
    ab=$(count_commits "$branch")
    ahead=$(echo "$ab" | cut -f2)
    behind=$(echo "$ab" | cut -f1)
  fi

  # ⛏️ Truncate long branch name
  short_branch=$branch
  if [ ${#branch} -gt $max_branch_length ]; then
    short_branch="${branch:0:$((max_branch_length - 1))}…"
  fi

  printf "${GREEN}%-${width1}s ${RED}%-${width2}s ${BLUE}${mark}%-${width3}s ${YELLOW}%-${width4}s${NO_COLOR}\n" "$ahead" "$behind" "$short_branch" "$time"
done
