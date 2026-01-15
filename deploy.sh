#!/bin/bash

# Deployment script for personal-news
# Run this on your server

set -e  # Exit on error

echo "🚀 Deploying personal-news..."

# Pull latest changes
echo "📥 Pulling latest code from GitHub..."
git pull origin main || git pull origin master

# Build and start containers
echo "🔨 Building Docker containers..."
docker compose build

echo "🔄 Restarting containers..."
docker compose down
docker compose up -d

echo "🧹 Cleaning up old images..."
docker image prune -f

echo "✅ Deployment complete!"
echo "🌐 Glance is running at http://$(hostname -I | awk '{print $1}'):8080"

# Show logs
echo ""
echo "📋 Recent logs:"
docker compose logs --tail=20
