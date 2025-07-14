#!/bin/bash

echo "📦 Preparing to push code to GitHub..."

# Step 1: Git Init if needed
if [ ! -d ".git" ]; then
  git init
  echo "✅ Git repository initialized."
fi

# Step 2: Set remote if missing
if ! git remote | grep -q origin; then
  read -p "🔗 Enter GitHub repo URL (e.g. https://github.com/yourusername/portfolio-fullstack.git): " repo_url
  git remote add origin "$repo_url"
  echo "✅ Remote 'origin' set to $repo_url"
fi

# Step 3: Add all changes
git add .

# Step 4: Choose commit type
echo ""
echo "🧠 What type of commit is this?"
select commit_type in "Feature (from feature.txt)" "Bugfix (prompted)" "Cancel"; do
  case $REPLY in
    1)
      if [ -f "feature.txt" ]; then
        commit_msg=$(<feature.txt)
        echo "📝 Commit message loaded from feature.txt"
      else
        echo "❌ feature.txt not found! Aborting."
        exit 1
      fi
      break
      ;;
    2)
      read -p "🛠️ Describe the bugfix (e.g., added README): " fix_desc
      commit_msg="fix: $fix_desc"
      break
      ;;
    3)
      echo "❌ Commit cancelled."
      exit 0
      ;;
    *)
      echo "Please choose a valid option (1 or 2)"
      ;;
  esac
done

# Step 5: Commit and push
git commit -m "$commit_msg"
git branch -M main
git push -u origin main

echo "🚀 Code pushed to GitHub with message:"
echo "\"$commit_msg\""
