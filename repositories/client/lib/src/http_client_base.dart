import 'package:decimal/decimal.dart';

/// Base class for the client.
abstract class HttpClientBase {
  /// Gets the recommendations for a given exchange type, crypto currency, fiat
  /// currency, amount, and amount currency.
  Future<Map<String, dynamic>> getRecommendations({
    required int exchangeType,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required Decimal amount,
    required String amountCurrencyId,
  });

  /// Disposes the client.
  void dispose();
}
