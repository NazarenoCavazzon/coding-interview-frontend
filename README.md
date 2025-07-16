# Challenge Eldorado - P2P Quote Application

A Flutter web application implementing a P2P cryptocurrency quote interface, built using Very Good Ventures' layered architecture and modern Flutter best practices.

## 🌐 Live Demo

**[View Application](https://nazarenocavazzon.github.io/coding-interview-frontend/)**

## 🏗️ Architecture Overview

This application follows **Very Good Ventures' layered architecture**, implementing separation of concerns through multiple layers:

### Layer Structure

```
┌────────────────────────────────────────────────────────────────┐
│                    Presentation Layer                          │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │   P2P Quote     │  │   App Widget    │  │   UI Package    │ │
│  │   Feature       │  │   Configuration │  │   Components    │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
├────────────────────────────────────────────────────────────────┤
│                    Business Logic Layer                        │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │   BloC/Cubit    │  │  Recommendation │  │   State Models  │ │
│  │  State Mgmt     │  │   Repository    │  │   & Validation  │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
├────────────────────────────────────────────────────────────────┤
│                      Data Layer                                │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │   HTTP Client   │  │   Data Models   │  │   Exceptions    │ │
│  │   & API Calls   │  │   & Parsing     │  │   & Handling    │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
└────────────────────────────────────────────────────────────────┘
```

### Package Organization

The application is organized into **local packages** for maximum modularity:

- **`client/`** - HTTP client, API models, and data layer abstractions
- **`ui/`** - Reusable UI components, theming, and design system
- **`i18n/`** - Type-safe internationalization using Slang
- **`recommendation_repository/`** - Business logic and data transformation

## 🎯 Technical Stack & Dependencies

### Core Dependencies

| Package | Purpose | Technical Decision |
|---------|---------|-------------------|
| `flutter_bloc` | State management | **BloC pattern** for predictable state management with business logic separation |
| `equatable` | Value equality | **Immutable state objects** with efficient comparison for BloC states |
| `slang` | Internationalization | **Type-safe i18n** with compile-time checks and hot-reload support |
| `shimmer` | Loading states | **Progressive loading UX** with skeleton screens |
| `http` | Network layer | **Lightweight HTTP client** with custom error handling |
| `very_good_analysis` | Code quality | **VGV linting rules** for consistent code style and best practices |

### Architecture Patterns

#### 1. **BloC/Cubit State Management**
```dart
class P2PQuoteCubit extends Cubit<P2PQuoteState> {
  // ✅ Immutable state objects
  // ✅ Business logic separation
  // ✅ Debounced API calls (500ms)
  // ✅ Typed exception handling
}
```

#### 2. **Repository Pattern**
```dart
abstract class RecommendationRepository {
  Future<Recommendation> getRecommendations({
    required String fiatCurrencyId,
    required String cryptoCurrencyId,
    required ExchangeType exchangeType,
    required num amount,
    required String amountCurrencyId,
  });
}
```

#### 3. **Dependency Injection**
- **RepositoryProvider** for repository injection
- **BlocProvider** for state management
- **Constructor injection** for dependency graph

## 🔧 Key Technical Features

### State Management

**P2PQuoteState** with status-based UI rendering:
- ✅ **Immutable state objects** using `Equatable`
- ✅ **Status-based UI rendering** (`loading`, `success`, `noData`, `error`)
- ✅ **Optimistic updates** with rollback
- ✅ **Debounced user input** for API efficiency

### Error Handling Strategy

**Type-safe error handling** with custom exceptions:
```dart
try {
  final quote = await recommendationRepository.getRecommendations(/*...*/);
  emit(state.copyWith(status: P2PQuoteStatus.success, recommendation: quote));
} on NoRecommendationDataFoundException {
  emit(state.copyWith(status: P2PQuoteStatus.noData));
} on RecommendationParsingException {
  emit(state.copyWith(status: P2PQuoteStatus.error));
}
```

### Performance Optimizations

- **Debounced API calls** (500ms delay) to prevent excessive requests
- **Efficient state updates** using copyWith pattern
- **Shimmer loading states** for better perceived performance
- **Lazy loading** of currency data

## 🧪 Testing & Quality Assurance

### Integration Testing
- **End-to-end user flows** 
- **Currency selection testing**
- **Error handling scenarios**
- **Theme and localization testing**

### Code Quality
- **Very Good Analysis** linting rules enforced
- **Full null safety** compliance
- **Comprehensive error handling**
- **Type-safe API models**

## 📱 Feature Implementation

### Core Features
- **P2P Quote Interface** with real-time updates
- **Currency Exchange Direction** switching (OnRamp/OffRamp)
- **Multi-currency Support** (Fiat ⟷ Crypto)
- **Responsive Design** optimized for web
- **Dark/Light Theme** with system preference detection
- **Spanish/English Localization** with type-safe translations

### UI/UX Highlights
- **Progressive Loading States** with shimmer effects
- **Intuitive Currency Selection** with search and filtering
- **Smooth Animations** and transitions
- **Mobile-first Responsive Design**
- **Accessibility Compliant** components

## 🚀 Web Deployment

**Automated GitHub Pages deployment** with:
- **Build optimization** for web performance
- **Asset optimization** with caching
- **Progressive Web App** features
- **Responsive design** across all devices

## 🔍 Code Quality Metrics

- **Zero analysis issues** with Very Good Analysis
- **Full null safety** compliance
- **Comprehensive error handling** with typed exceptions
- **Clean architecture** with layer separation
- **Efficient state management** with minimal rebuilds

---
