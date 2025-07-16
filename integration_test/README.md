# Integration Tests

This directory contains comprehensive integration tests for the Challenge Eldorado P2P Quote application.

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
- Amount input and validation
- Exchange direction switching
- Currency selection dialogs
- Comma to decimal conversion
- Zero amount handling
- Debounced quote requests
- Quote button visibility

### 3. `currency_selection_test.dart`
Tests comprehensive currency selection functionality:
- Bottom sheet display on phone screens
- Dialog display on tablet screens
- Fiat currency selection (BRL, COP, PEN, VES)
- Crypto currency selection (USDT only)
- Radio button interactions
- Currency state updates in cubit
- Currency images display
- Multiple currency selections
- Modal dismissal by tapping outside
- Responsive behavior across screen sizes

### 4. `theme_and_localization_test.dart`
Tests theme switching and localization:
- Dark mode toggle functionality
- Language switching
- Theme persistence across screen rotations
- System theme adaptation
- Theme colors for text and backgrounds

### 5. `error_handling_test.dart`
Tests error handling and edge cases:
- Network error handling
- No data scenarios
- Parsing errors
- Empty input handling
- Large number input
- Special character filtering
- Rapid input changes
- Widget disposal
- Multiple simultaneous operations

### 6. `end_to_end_test.dart`
Tests complete user workflows:
- Off-ramp flow (crypto to fiat)
- On-ramp flow (fiat to crypto)
- Currency selection workflow
- Theme and language switching workflow
- Multiple operations sequence
- Error recovery scenarios
- Responsive design testing
- Performance under load

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
- ✅ **Error Handling**: Network errors, parsing errors, validation
- ✅ **Responsive Design**: Multiple screen sizes and orientations
- ✅ **Performance**: Load testing and timing constraints
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
- Test accessibility and user experience

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