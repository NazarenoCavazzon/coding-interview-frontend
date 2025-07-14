import 'package:client/src/models/models.dart';
import 'package:decimal/decimal.dart';

/// Base class for the client.
abstract class ClientBase {
  /// Gets the recommendations for a given exchange type, crypto currency, fiat
  /// currency, amount, and amount currency.
  Future<Recommendation> getRecommendations({
    required ExchangeType type,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required Decimal amount,
    required String amountCurrencyId,
  });

  /// Disposes the client.
  void dispose();
}
