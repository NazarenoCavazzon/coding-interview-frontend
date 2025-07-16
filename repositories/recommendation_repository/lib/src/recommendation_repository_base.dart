import 'package:client/client.dart';

/// Base class for the recommendation repository.
abstract class RecommendationRepositoryBase {
  /// Gets the recommendations for a given exchange type, crypto currency, fiat
  /// currency, amount, and amount currency.
  Future<Recommendation> getRecommendations({
    required ExchangeType exchangeType,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required num amount,
    required String amountCurrencyId,
  });
}
