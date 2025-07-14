# Exchange Rate Client

A Dart client library for consuming the El Dorado API recommendations endpoint, designed for currency exchange rate calculations.

## Features

- **Type-safe models**: Hand-crafted Dart models for all API responses
- **Easy testing**: Interface-based design with dependency injection
- **HTTP client abstraction**: Built on top of the standard `http` package
- **Error handling**: Custom exceptions for API errors
- **Comprehensive**: Supports both FIAT to CRYPTO and CRYPTO to FIAT exchanges

## Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  client:
    path: ./repositories/client
```

## Usage

### Basic Usage

```dart
import 'package:client/client.dart';

void main() async {
  // Create a client instance
  final client = HttpClient();

  try {
    // Get recommendations for CRYPTO to FIAT exchange
    final response = await client.getRecommendations(
      type: ExchangeType.cryptoToFiat,
      cryptoCurrencyId: 'TATUM-TRON-USDT',
      fiatCurrencyId: 'COP',
      amount: 100.0,
      amountCurrencyId: 'TATUM-TRON-USDT',
    );

    // Access the exchange rate
    final exchangeRate = response.data.byPrice.fiatToCryptoExchangeRate;
    print('Exchange rate: $exchangeRate');

    // Calculate result
    final result = 100.0 * double.parse(exchangeRate);
    print('100 USDT = $result COP');

  } on HttpClientException catch (e) {
    print('Error: ${e.message}');
  } finally {
    // Don't forget to dispose the client
    client.dispose();
  }
}
```

### Custom Configuration

```dart
import 'package:client/client.dart';
import 'package:http/http.dart' as http;

void main() async {
  // Custom HTTP client with timeout
  final httpClient = http.Client();

  // Custom base URL (useful for testing)
  final client = HttpClient(
    httpClient: httpClient,
    baseUrl: 'https://custom-api.com/v1',
  );

  // Use the client...

  client.dispose();
}
```

### Using Different Exchange Types

```dart
// CRYPTO to FIAT
final cryptoToFiatResponse = await client.getRecommendations(
  type: ExchangeType.cryptoToFiat,
  cryptoCurrencyId: 'TATUM-TRON-USDT',
  fiatCurrencyId: 'COP',
  amount: 100.0,
  amountCurrencyId: 'TATUM-TRON-USDT',
);

// FIAT to CRYPTO
final fiatToCryptoResponse = await client.getRecommendations(
  type: ExchangeType.fiatToCrypto,
  cryptoCurrencyId: 'TATUM-TRON-USDT',
  fiatCurrencyId: 'COP',
  amount: 100000.0,
  amountCurrencyId: 'COP',
);
```

## Testing

The client is designed to be easily testable through dependency injection:

```dart
import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:client/client.dart';

class MockHttpClient extends http.BaseClient {
  final Future<http.Response> Function(http.BaseRequest) _handler;
  MockHttpClient(this._handler);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final response = await _handler(request);
    return http.StreamedResponse(
      Stream.fromIterable([response.bodyBytes]),
      response.statusCode,
      headers: response.headers,
      request: request,
    );
  }
}

void main() {
  test('should make correct API call', () async {
    // Arrange
    final mockClient = MockHttpClient((request) async {
      return http.Response('{"data": {...}}', 200);
    });

    final client = HttpClient(httpClient: mockClient);

    // Act
    final response = await client.getRecommendations(
      type: ExchangeType.cryptoToFiat,
      cryptoCurrencyId: 'TATUM-TRON-USDT',
      fiatCurrencyId: 'COP',
      amount: 100.0,
      amountCurrencyId: 'TATUM-TRON-USDT',
    );

    // Assert
    expect(response, isA<RecommendationResponse>());
  });
}
```

## API Reference

### ExchangeRateClient

Abstract interface for exchange rate operations.

#### Methods

- `getRecommendations({required ExchangeType type, required String cryptoCurrencyId, required String fiatCurrencyId, required double amount, required String amountCurrencyId})` - Get exchange recommendations

### HttpClient

HTTP implementation of `ExchangeRateClient`.

#### Constructor

- `HttpClient({http.Client? httpClient, String? baseUrl})` - Create client with optional custom HTTP client and base URL

#### Methods

- `dispose()` - Clean up resources

### Models

- `ExchangeType` - Enum for exchange direction (cryptoToFiat, fiatToCrypto)
- `RecommendationResponse` - Complete API response
- `RecommendationData` - Contains byPrice, bySpeed, byReputation offers
- `Offer` - Individual exchange offer
- `User` - User information
- `Limits` - Currency limits
- `OfferMakerStats` - Statistics about offer maker

### Exceptions

- `HttpClientException` - Thrown on API errors

## Development

Run tests:

```bash
cd repositories/client
dart test
```

## License

This project is part of the El Dorado coding challenge.
