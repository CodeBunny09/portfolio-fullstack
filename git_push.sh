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

# Stage all files
git add .

# Detect changes
changed_files=$(git diff --cached --name-only)

# Load from changes.txt
if [ ! -f "changes.txt" ]; then
  echo "❌ Missing changes.txt! Create one with 2 lines:"
  echo "Line 1: type(scope)"
  echo "Line 2: short description"
  exit 1
fi

commit_type_scope=$(sed -n '1p' changes.txt)
description=$(sed -n '2p' changes.txt)
type=$(echo "$commit_type_scope" | cut -d'(' -f1)
scope=$(echo "$commit_type_scope" | sed -E 's/^[^(]+\(([^)]+)\).*/\1/')

# Extract Completed and TODO from README.md
completed_tasks=$(awk '/^### ✅ Completed/,/^### 📝 TODO/' README.md | grep '^- ' || echo "N/A")
todo_tasks=$(awk '/^### 📝 TODO/,/^$/' README.md | grep '^- ' || echo "N/A")

# Footer
footer="Auto-generated on $(date '+%Y-%m-%d %H:%M') from branch: $(git branch --show-current)"

# Prepare changelog entry
changelog_entry="### $type($scope): $description

- Affected: $changed_files
- Completed:
$completed_tasks
- TODO:
$todo_tasks

<footer>
$footer
"

# Append to CHANGELOG.md before committing
echo -e "\n$changelog_entry\n" >> CHANGELOG.md
echo "📘 CHANGELOG.md updated!"

# Prepare full commit message
commit_msg="$type($scope): $description

Automated commit based on detected changes in $scope.

Completed:
$completed_tasks

TODO:
$todo_tasks

<footer>
$footer"

# Commit
echo "$commit_msg" | git commit -F -

# Push
git branch -M main
git push -u origin main
echo "✅ Pushed to GitHub!"
