#!/bin/bash

# Deploy script for Challenge El Dorado Flutter Web App

set -e

echo "🚀 Starting deployment process..."

# Check if flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

# Get dependencies for main project
echo "📦 Getting dependencies for main project..."
flutter pub get

# Get dependencies for local packages
echo "📦 Getting dependencies for local packages..."
for dir in repositories/*/; do
    if [ -f "$dir/pubspec.yaml" ]; then
        echo "  📦 Getting dependencies for $(basename "$dir")..."
        cd "$dir" && flutter pub get && cd ../..
    fi
done

# Run tests
echo "🧪 Running tests..."
flutter test

# Analyze code
echo "🔍 Analyzing code..."
flutter analyze

# Build web app
echo "🏗️  Building web app..."
flutter build web --base-href "/coding-interview-frontend/"

echo "✅ Build completed successfully!"
echo "📁 Built files are in: build/web/"
echo "🌐 You can serve the app locally with: flutter run -d chrome"
echo "🚀 Push to main branch to deploy to GitHub Pages automatically" 