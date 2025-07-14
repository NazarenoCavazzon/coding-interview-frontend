import 'dart:convert';

import 'package:client/src/client_base.dart';
import 'package:client/src/models/models.dart';
import 'package:decimal/decimal.dart';
import 'package:http/http.dart' as http;

const _stageBaseUrl =
    'https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage';

/// HTTP client for the El Dorado API.
class ElDoradoApiClient implements ClientBase {
  /// Creates a new [ElDoradoApiClient] instance.
  ElDoradoApiClient._({required String baseUrl, http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client(),
      _baseUrl = baseUrl;

  /// Creates a new [ElDoradoApiClient] instance for the stage environment.
  factory ElDoradoApiClient.stage({http.Client? httpClient}) =>
      ElDoradoApiClient._(baseUrl: _stageBaseUrl, httpClient: httpClient);

  final http.Client _httpClient;
  final String _baseUrl;

  @override
  Future<Recommendation> getRecommendations({
    required ExchangeType type,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required Decimal amount,
    required String amountCurrencyId,
  }) async {
    final uri = Uri.parse('$_baseUrl/orderbook/public/recommendations').replace(
      queryParameters: {
        'type': type.value.toString(),
        'cryptoCurrencyId': cryptoCurrencyId,
        'fiatCurrencyId': fiatCurrencyId,
        'amount': amount.toString(),
        'amountCurrencyId': amountCurrencyId,
      },
    );

    final response = await _httpClient.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<dynamic, dynamic>;
      final data = json['data'];

      if (data is! Map<dynamic, dynamic> || data.isEmpty) {
        throw ElDoradoApiClientException(
          'No data found in the response',
          response.statusCode,
        );
      }

      return Recommendation.fromJson(json);
    } else {
      throw ElDoradoApiClientException(
        'Failed to get recommendations: ${response.statusCode}',
        response.statusCode,
      );
    }
  }

  /// Disposes the [ElDoradoApiClient] instance.
  @override
  void dispose() {
    _httpClient.close();
  }
}

/// Exception thrown when an HTTP client error occurs.
class ElDoradoApiClientException implements Exception {
  /// Creates a new [ElDoradoApiClientException] instance.
  const ElDoradoApiClientException(this.message, this.statusCode);

  /// The error message.
  final String message;

  /// The HTTP status code.
  final int statusCode;

  /// Returns a string representation of the [ElDoradoApiClientException].
  @override
  String toString() =>
      'ElDoradoApiClientException: $message (Status: $statusCode)';
}
