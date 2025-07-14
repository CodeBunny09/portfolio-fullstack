#!/bin/bash

echo "🚀 Automating commit + changelog generation..."

# Git init if needed
if [ ! -d ".git" ]; then
  git init
  echo "✅ Git repository initialized."
fi

# Add remote if missing
if ! git remote | grep -q origin; then
  read -p "🔗 Enter GitHub repo URL: " repo_url
  git remote add origin "$repo_url"
  echo "✅ Remote 'origin' set to $repo_url"
fi

# Stage all changes
git add .

# Get list of staged files (one-liner + readable)
changed_files=$(git diff --cached --name-only | tr '\n' ' ')

# Load commit info from changes.txt
if [ ! -f "changes.txt" ]; then
  echo "❌ Missing changes.txt! Create one with 2 lines:"
  echo "Line 1: type(scope)"
  echo "Line 2: short description"
  exit 1
fi

commit_type_scope=$(sed -n '1p' changes.txt | tr -d '\r')
description=$(sed -n '2p' changes.txt | tr -d '\r')
type=$(echo "$commit_type_scope" | cut -d'(' -f1)
scope=$(echo "$commit_type_scope" | sed -E 's/^[^(]+\(([^)]+)\).*/\1/')

# Extract completed and todo tasks
completed_tasks=$(awk '/^### ✅ Completed/,/^### /' README.md | grep '^- \[x\]' | sed 's/^/  /')
todo_tasks=$(awk '/^### 📝 TODO/,/^### /' README.md | grep '^- \[ \]' | sed 's/^/  /')

# Fallback if no match
[ -z "$completed_tasks" ] && completed_tasks="  N/A"
[ -z "$todo_tasks" ] && todo_tasks="  N/A"


# If no tasks found, mark N/A
[ -z "$completed_tasks" ] && completed_tasks="  N/A"
[ -z "$todo_tasks" ] && todo_tasks="  N/A"

# Get metadata
timestamp=$(date '+%Y-%m-%d %H:%M')
branch=$(git branch --show-current)
footer="Auto-generated on $timestamp from branch: $branch"

# Construct commit message
commit_msg="$commit_type_scope: $description

Automated commit based on detected changes in $scope.

✅ Completed:
$completed_tasks

📝 TODO:
$todo_tasks

Affected Files:
$changed_files

<footer>
$footer"

# Commit
echo "$commit_msg" | git commit -F -

# Write formatted entry to CHANGELOG.md
changelog_entry="### $commit_type_scope: $description

- Affected: $changed_files
- ✅ Completed:
$completed_tasks
- 📝 TODO:
$todo_tasks

<footer>
$footer
"

# Append to CHANGELOG.md
echo -e "\n$changelog_entry\n" >> CHANGELOG.md
echo "📘 CHANGELOG.md updated!"

# Push to GitHub
git branch -M main
git push -u origin main
echo "✅ Code pushed to GitHub!"
