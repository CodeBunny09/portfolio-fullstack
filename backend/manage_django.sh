#!/bin/bash

echo "⚙️ Django + Docker Management Script"
echo "----------------------------------"

PS3="Choose an action: "
options=(
  "🧱 Build & Start Docker Containers"
  "📦 Stop Docker Containers"
  "🛠️  Run Migrations"
  "🧬  Make Migrations"
  "👤  Create Superuser"
  "🧼  Flush DB"
  "🧹  Clear & Rebuild All"
  "♻️ Restart Django Dev Server"
  "🚪 Exit"
)

select opt in "${options[@]}"; do
  case "$REPLY" in
    1)
      echo "🧱 Building and starting containers..."
      docker-compose up -d --build
      break
      ;;
    2)
      echo "📦 Stopping containers..."
      docker-compose down
      break
      ;;
    3)
      echo "🛠️  Applying migrations..."
      docker-compose exec web python manage.py migrate
      break
      ;;
    4)
      echo "🧬  Making migrations..."
      docker-compose exec web python manage.py makemigrations
      break
      ;;
    5)
      echo "👤 Creating superuser..."
      docker-compose exec web python manage.py createsuperuser
      break
      ;;
    6)
      echo "🧼 Flushing database..."
      docker-compose exec web python manage.py flush
      break
      ;;
    7)
      echo "🧹 Rebuilding from scratch..."
      docker-compose down -v
      docker-compose up -d --build
      docker-compose exec web python manage.py makemigrations
      docker-compose exec web python manage.py migrate
      docker-compose exec web python manage.py collectstatic --noinput
      docker-compose exec web python manage.py createsuperuser
      break
      ;;
    8)
      echo "♻️ Restarting Django dev server..."

      echo "🔪 Killing existing dev server (if running)..."
      docker-compose exec web bash -c "pkill -f runserver || echo '⚠️ No existing dev server running.'"

      echo "🧹 Collecting static files..."
      docker-compose exec web python manage.py collectstatic --noinput

      echo "🚀 Starting development server on 0.0.0.0:8000..."
      docker-compose exec web python manage.py runserver 0.0.0.0:8000
      break
      ;;
    9)
      echo "🚪 Exiting..."
      exit 0
      ;;
    *)
      echo "❌ Invalid option."
      ;;
  esac
done
