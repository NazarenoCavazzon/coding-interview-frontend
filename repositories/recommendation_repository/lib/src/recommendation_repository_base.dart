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

/// Implementation of the recommendation repository.
class RecommendationRepository implements RecommendationRepositoryBase {
  /// Creates a new [RecommendationRepository] instance.
  const RecommendationRepository({required this.client});

  /// The client instance.
  final HttpClientBase client;

  @override
  Future<Recommendation> getRecommendations({
    required ExchangeType exchangeType,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required num amount,
    required String amountCurrencyId,
  }) async {
    final json = await client.getRecommendations(
      exchangeType: exchangeType.value,
      cryptoCurrencyId: cryptoCurrencyId,
      fiatCurrencyId: fiatCurrencyId,
      amount: amount,
      amountCurrencyId: amountCurrencyId,
    );

    final data = json['data'];
    if (data is! Map<String, dynamic> || data.isEmpty) {
      throw const NoRecommendationDataFoundException();
    }

    try {
      return Recommendation.fromJson(json);
    } on FormatException catch (e) {
      throw RecommendationParsingException(
        'Invalid format in recommendation data: ${e.message}',
      );
    } catch (e) {
      throw RecommendationParsingException(
        'Failed to parse recommendation data: $e',
      );
    }
  }
}

/// Exception thrown when no recommendation data is found.
class NoRecommendationDataFoundException implements Exception {
  /// Creates a new [NoRecommendationDataFoundException] instance.
  const NoRecommendationDataFoundException();

  @override
  String toString() =>
      'NoRecommendationDataFoundException: No recommendation data found';
}

/// Exception thrown when recommendation data parsing fails.
class RecommendationParsingException implements Exception {
  /// Creates a new [RecommendationParsingException] instance.
  const RecommendationParsingException(this.message);

  /// The error message.
  final String message;

  @override
  String toString() => 'RecommendationParsingException: $message';
}
