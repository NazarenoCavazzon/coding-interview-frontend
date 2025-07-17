import 'package:client/client.dart';
import 'package:recommendation_repository/recommendation_repository.dart';

/// Implementation of the recommendation repository.
class RecommendationRepository implements RecommendationRepositoryBase {
  /// Creates a new [RecommendationRepository] instance.
  const RecommendationRepository({required this.client});

  /// The client instance.
  final ElDoradoApiClientBase client;

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
