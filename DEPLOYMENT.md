# Deployment Guide

This document explains how to deploy the Challenge Eldorado Flutter app to GitHub Pages.

## 🚀 Automatic Deployment (Recommended)

The app is automatically deployed to GitHub Pages when you push to the `main` branch.

### GitHub Pages Setup

1. Go to your repository settings on GitHub
2. Navigate to "Pages" section
3. Set Source to "GitHub Actions"
4. The workflow will automatically deploy your app

### Deployment URL

Once deployed, your app will be available at:
```
https://[your-username].github.io/coding-interview-frontend/
```

## 🛠️ Manual Deployment

If you want to test the build locally or deploy manually:

### Prerequisites

- Flutter SDK installed
- Git configured
- GitHub repository with Pages enabled

### Steps

1. Make the deploy script executable:
   ```bash
   chmod +x scripts/deploy.sh
   ```

2. Run the deployment script:
   ```bash
   ./scripts/deploy.sh
   ```

3. Serve locally to test:
   ```bash
   cd build/web
   python -m http.server 8000
   ```

   Then visit: `http://localhost:8000`

## 🔧 CI/CD Pipeline

The GitHub Actions workflow (`.github/workflows/deploy.yml`) includes:

### Build and Test Job
- ✅ Checkout code
- ✅ Setup Flutter environment
- ✅ Install dependencies (main + local packages)
- ✅ Run tests
- ✅ Analyze code
- ✅ Build web app
- ✅ Upload build artifacts

### Deploy Job
- ✅ Download build artifacts
- ✅ Setup GitHub Pages
- ✅ Deploy to GitHub Pages

## 📋 Deployment Checklist

Before deploying:

- [ ] All tests pass locally
- [ ] Code analysis passes
- [ ] Assets are properly included
- [ ] Web configuration is correct
- [ ] Repository has GitHub Pages enabled
- [ ] Workflow permissions are set correctly

## 🐛 Troubleshooting

### Common Issues

1. **Build fails**: Check Flutter version and dependencies
2. **Assets not loading**: Verify asset paths in `pubspec.yaml`
3. **404 on GitHub Pages**: Check base href configuration
4. **Workflow fails**: Check repository permissions and secrets

### Debugging Steps

1. Check workflow logs in GitHub Actions
2. Verify build locally with `./scripts/deploy.sh`
3. Test web app locally before deploying
4. Check GitHub Pages settings

## 🔄 Update Process

To update the deployed app:

1. Make your changes
2. Test locally
3. Commit and push to `main` branch
4. GitHub Actions will automatically deploy

## 📱 Mobile Testing

The app is responsive and works on mobile devices. Test on:
- iOS Safari
- Android Chrome
- Desktop browsers

## 🎨 Customization

To customize the deployment:

1. Update `web/index.html` for branding
2. Modify `web/manifest.json` for PWA settings
3. Update workflow in `.github/workflows/deploy.yml`
4. Adjust base href in deployment script 