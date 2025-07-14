import 'dart:convert';

import 'package:client/src/client_base.dart';
import 'package:client/src/models/models.dart';
import 'package:http/http.dart' as http;

/// HTTP client for the exchange rate API.
class HttpClient implements ClientBase {
  /// Creates a new [HttpClient] instance.
  HttpClient({http.Client? httpClient, String? baseUrl})
    : _httpClient = httpClient ?? http.Client(),
      _baseUrl =
          baseUrl ??
          'https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage';

  final http.Client _httpClient;
  final String _baseUrl;

  @override
  Future<Recommendation> getRecommendations({
    required ExchangeType type,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required double amount,
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
      return Recommendation.fromJson(json);
    } else {
      throw HttpClientException(
        'Failed to get recommendations: ${response.statusCode}',
        response.statusCode,
      );
    }
  }

  /// Disposes the [HttpClient] instance.
  @override
  void dispose() {
    _httpClient.close();
  }
}

/// Exception thrown when an HTTP client error occurs.
class HttpClientException implements Exception {
  /// Creates a new [HttpClientException] instance.
  const HttpClientException(this.message, this.statusCode);

  /// The error message.
  final String message;

  /// The HTTP status code.
  final int statusCode;

  /// Returns a string representation of the [HttpClientException].
  @override
  String toString() => 'HttpClientException: $message (Status: $statusCode)';
}
