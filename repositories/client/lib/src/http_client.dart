import 'dart:convert';

import 'package:client/src/http_client_base.dart';
import 'package:decimal/decimal.dart';
import 'package:http/http.dart' as http;

const _stageBaseUrl =
    'https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage';

/// HTTP client for the El Dorado API.
class ElDoradoApiClient implements HttpClientBase {
  /// Creates a new [ElDoradoApiClient] instance.
  ElDoradoApiClient._({required String baseUrl, http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client(),
      _baseUrl = baseUrl;

  /// Creates a new [ElDoradoApiClient] instance for the stage environment.
  factory ElDoradoApiClient.stage({http.Client? httpClient}) =>
      ElDoradoApiClient._(baseUrl: _stageBaseUrl, httpClient: httpClient);

  final http.Client _httpClient;
  final String _baseUrl;

  /// Private generic get method for making HTTP requests.
  Future<Map<String, dynamic>> _get(
    String endpoint,
    Map<String, String> queryParameters,
  ) async {
    final uri = Uri.parse(
      '$_baseUrl$endpoint',
    ).replace(queryParameters: queryParameters);

    final response = await _httpClient.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return json;
    } else {
      throw HttpClientException('HTTP request failed', response.statusCode);
    }
  }

  @override
  Future<Map<String, dynamic>> getRecommendations({
    required int exchangeType,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required Decimal amount,
    required String amountCurrencyId,
  }) async {
    return _get('/orderbook/public/recommendations', {
      'type': exchangeType.toString(),
      'cryptoCurrencyId': cryptoCurrencyId,
      'fiatCurrencyId': fiatCurrencyId,
      'amount': amount.toString(),
      'amountCurrencyId': amountCurrencyId,
    });
  }

  /// Disposes the [ElDoradoApiClient] instance.
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
