#!/bin/bash

echo "📦 Preparing to push code to GitHub..."

# Init Git repo if not present
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

# Choose commit type
echo ""
echo "🧠 What type of commit is this?"
select commit_type in "Feature (from feature.txt)" "Bugfix (prompted)" "Cancel"; do
  case $REPLY in
    1)
      if [ -f "feature.txt" ]; then
        commit_msg=$(<feature.txt)
      else
        echo "❌ feature.txt not found!"
        exit 1
      fi
      break
      ;;
    2)
      read -p "🔧 What is the scope (e.g. readme, models)? " scope
      read -p "📝 Short description (1 line): " desc
      read -p "✍️ One-liner summary of the fix: " body
      read -p "✅ Completed task: " done
      read -p "📝 TODO: " todo
      read -p "📎 Footer note (optional): " footer

      commit_msg="fix($scope): $desc

$body

Completed:
- $done

TODO:
- $todo

<footer>
$footer"
      break
      ;;
    3)
      echo "❌ Cancelled."
      exit 0
      ;;
    *)
      echo "Please select a valid option (1–3)"
      ;;
  esac
done

# Commit and push
git commit -m "$commit_msg"
git branch -M main
git push -u origin main

echo "🚀 Code pushed to GitHub with structured message!"
