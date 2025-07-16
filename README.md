# Challenge Eldorado - P2P Quote Application

A Flutter web application for P2P cryptocurrency quotes, built as part of the Eldorado coding challenge.

## 🚀 Live Demo

The app is automatically deployed to GitHub Pages: [View Live Demo](https://[your-username].github.io/coding-interview-frontend/)

## 🛠️ Quick Start

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Git

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/[your-username]/coding-interview-frontend.git
   cd coding-interview-frontend
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   cd repositories/client && flutter pub get && cd ../..
   cd repositories/i18n && flutter pub get && cd ../..
   cd repositories/ui && flutter pub get && cd ../..
   cd repositories/recommendation_repository && flutter pub get && cd ../..
   ```

3. Run the application:
   ```bash
   flutter run -d chrome
   ```

## 🚀 Deployment

### Automatic Deployment
The app automatically deploys to GitHub Pages when you push to the `main` branch.

### Manual Deployment
Run the deployment script:
```bash
./scripts/deploy.sh
```

For detailed deployment instructions, see [DEPLOYMENT.md](DEPLOYMENT.md).

## 🏗️ Project Structure

```
lib/
├── app/                    # App configuration and main app widget
├── main.dart              # App entry point
└── p2p_quote/             # P2P quote feature module
    ├── cubit/             # State management (Cubit)
    ├── view/              # UI pages
    └── widgets/           # Reusable widgets

repositories/              # Local packages
├── client/               # API client
├── i18n/                 # Internationalization
├── ui/                   # UI components and theme
└── recommendation_repository/  # Business logic
```

## 🧪 Testing

Run tests:
```bash
flutter test
```

Run code analysis:
```bash
flutter analyze
```

## 🌐 Web Support

This app is optimized for web deployment with:
- Responsive design
- Progressive Web App (PWA) features
- Optimized loading states
- Mobile-friendly interface

## 📱 Features

- P2P cryptocurrency quote interface
- Multi-language support (Spanish/English)
- Dark/Light theme switching
- Responsive design
- Real-time quote updates
- Currency conversion

## 🔧 Development

### Local Development
```bash
flutter run -d chrome
```

### Build for Web
```bash
flutter build web --base-href "/coding-interview-frontend/"
```

### Serve Built App Locally
```bash
cd build/web
python -m http.server 8000
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests and analysis
5. Submit a pull request

## 📄 License

This project is part of a coding challenge for Eldorado.
