# Integration Tests

This directory contains focused integration tests for the Challenge El Dorado P2P Quote application.

## Test Files

### 1. `app_test.dart`
Tests basic app initialization and core functionality:
- App renders without crashing
- Main components are present (QuoteCard, DarkModeSwitch, LanguageSwitch)
- Responsive design across different screen sizes
- Keyboard dismissal when tapping outside
- Widget rebuilds maintain state

### 2. `p2p_quote_flow_test.dart`
Tests the main P2P quote functionality:
- Amount input and quote flow
- Exchange direction switching
- Decimal number input validation
- Comma to decimal conversion
- Debounced quote requests

### 3. `currency_selection_test.dart`
Tests core currency selection functionality:
- Bottom sheet display on phone screens
- Dialog display on tablet screens
- Fiat currency selection (generic test)
- Crypto currency selection (USDT only)
- Radio button interactions
- Modal dismissal by tapping outside

### 4. `theme_and_localization_test.dart`
Tests theme switching and localization:
- Dark mode toggle functionality
- Language switching
- Theme persistence across screen rotations
- System theme adaptation
- Theme colors for text and backgrounds
- Card colors adaptation

### 5. `error_handling_test.dart`
Tests error handling and edge cases:
- Empty input handling
- Special character filtering
- Rapid input changes
- Widget disposal scenarios

### 6. `end_to_end_test.dart`
Tests complete user workflows:
- Off-ramp flow (crypto to fiat)
- On-ramp flow (fiat to crypto)
- Currency selection and switching workflow
- Error recovery scenarios

## Running the Tests

### Run All Integration Tests
```bash
flutter test integration_test/
```

### Run Specific Test File
```bash
flutter test integration_test/app_test.dart
flutter test integration_test/p2p_quote_flow_test.dart
flutter test integration_test/currency_selection_test.dart
flutter test integration_test/theme_and_localization_test.dart
flutter test integration_test/error_handling_test.dart
flutter test integration_test/end_to_end_test.dart
```

### Run Integration Tests with Flutter Driver
```bash
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/integration_test.dart
```

## Test Coverage

These integration tests cover:

- ✅ **App Initialization**: Basic app startup and component rendering
- ✅ **UI Interactions**: Tapping, text input, navigation
- ✅ **Currency Selection**: Bottom sheet/dialog interactions, fiat/crypto selection
- ✅ **State Management**: BLoC state changes and persistence
- ✅ **Theme System**: Dark/light mode switching
- ✅ **Localization**: Language switching functionality
- ✅ **Error Handling**: Input validation and edge cases
- ✅ **Responsive Design**: Multiple screen sizes and orientations
- ✅ **User Workflows**: Complete end-to-end user scenarios

## Test Structure

Each test file follows this structure:
1. **Setup**: Initialize API client and dependencies
2. **Test Cases**: Individual test scenarios with descriptive names
3. **Assertions**: Verify expected behavior using Flutter test matchers
4. **Cleanup**: Automatic cleanup between tests

## Best Practices

These tests follow Flutter testing best practices:
- Use `testWidgets` for integration tests
- Use `pumpAndSettle()` for UI stabilization
- Use descriptive test names
- Test both happy path and error scenarios
- Use proper finders for UI elements
- Test responsive design across screen sizes
- Verify state management behavior
- Focus on core functionality without redundancy

## Dependencies

The integration tests require:
- `flutter_test` SDK
- `integration_test` SDK
- Main app dependencies (client, ui, i18n packages)

## Notes

- Tests are designed to run on both emulators and physical devices
- Some tests may require network connectivity for API calls
- Tests use staging API client for realistic scenarios
- All tests are designed to be deterministic and repeatable
- Test suite has been optimized for maintainability and reduced redundancy 