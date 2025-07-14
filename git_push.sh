#!/bin/bash

echo "📦 Preparing to push code to GitHub..."

# 1. Init Git repo if not already
if [ ! -d ".git" ]; then
  git init
  echo "✅ Git repository initialized."
fi

# 2. Add remote if missing
if ! git remote | grep -q origin; then
  read -p "🔗 Enter GitHub repo URL (e.g. https://github.com/yourusername/portfolio-fullstack.git): " repo_url
  git remote add origin "$repo_url"
  echo "✅ Remote 'origin' set to $repo_url"
fi

# 3. Add all changes
git add .

# 4. Ask for commit message
read -p "📝 Enter commit message: " commit_msg
git commit -m "$commit_msg"

# 5. Set main branch and push
git branch -M main
git push -u origin main

echo "🚀 Code pushed to GitHub successfully!"
