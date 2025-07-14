import 'package:client/client.dart';
import 'package:decimal/decimal.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

// Mock HTTP client for testing
class MockHttpClient extends http.BaseClient {
  MockHttpClient(this._handler);

  /// The handler for the mock HTTP client.
  final Future<http.Response> Function(http.BaseRequest) _handler;

  /// Sends a request to the mock HTTP client.
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
  group('HttpClient', () {
    late ElDoradoApiClient client;
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient((_) async => http.Response('', 200));
      client = ElDoradoApiClient.stage(httpClient: mockHttpClient);
    });

    test('should make correct HTTP request', () async {
      http.BaseRequest? capturedRequest;
      mockHttpClient = MockHttpClient((request) async {
        capturedRequest = request;
        return http.Response(_mockResponseBody, 200);
      });
      client = ElDoradoApiClient.stage(httpClient: mockHttpClient);

      await client.getRecommendations(
        type: ExchangeType.offRamp,
        cryptoCurrencyId: 'TATUM-TRON-USDT',
        fiatCurrencyId: 'COP',
        amount: Decimal.fromInt(100),
        amountCurrencyId: 'TATUM-TRON-USDT',
      );

      expect(capturedRequest, isNotNull);
      expect(capturedRequest!.method, equals('GET'));
      expect(
        capturedRequest!.url.path,
        equals('/stage/orderbook/public/recommendations'),
      );
      expect(capturedRequest!.url.queryParameters['type'], equals('0'));
      expect(
        capturedRequest!.url.queryParameters['cryptoCurrencyId'],
        equals('TATUM-TRON-USDT'),
      );
      expect(
        capturedRequest!.url.queryParameters['fiatCurrencyId'],
        equals('COP'),
      );
      expect(capturedRequest!.url.queryParameters['amount'], equals('100'));
      expect(
        capturedRequest!.url.queryParameters['amountCurrencyId'],
        equals('TATUM-TRON-USDT'),
      );
    });

    test('should parse successful response correctly', () async {
      mockHttpClient = MockHttpClient(
        (_) async => http.Response(_mockResponseBody, 200),
      );
      client = ElDoradoApiClient.stage(httpClient: mockHttpClient);

      final result = await client.getRecommendations(
        type: ExchangeType.offRamp,
        cryptoCurrencyId: 'TATUM-TRON-USDT',
        fiatCurrencyId: 'COP',
        amount: Decimal.fromInt(100),
        amountCurrencyId: 'TATUM-TRON-USDT',
      );

      expect(result, isA<Recommendation>());
      expect(result.byPrice.fiatToCryptoExchangeRate, equals('3965.55'));
      expect(result.byPrice.cryptoCurrencyId, equals('TATUM-TRON-USDT'));
      expect(result.byPrice.fiatCurrencyId, equals('COP'));
    });

    test('should throw exception on HTTP error', () async {
      mockHttpClient = MockHttpClient(
        (_) async => http.Response('Not Found', 404),
      );
      client = ElDoradoApiClient.stage(httpClient: mockHttpClient);

      expect(
        () async => client.getRecommendations(
          type: ExchangeType.offRamp,
          cryptoCurrencyId: 'TATUM-TRON-USDT',
          fiatCurrencyId: 'COP',
          amount: Decimal.fromInt(100),
          amountCurrencyId: 'TATUM-TRON-USDT',
        ),
        throwsA(isA<ElDoradoApiClientException>()),
      );
    });

    test('should dispose HTTP client correctly', () {
      expect(() => client.dispose(), returnsNormally);
    });
  });

  group('ExchangeType', () {
    test('should have correct values', () {
      expect(ExchangeType.offRamp.value, equals(0));
      expect(ExchangeType.onRamp.value, equals(1));
    });
  });
}

const String _mockResponseBody = '''
{
  "data": {
    "byPrice": {
      "offerId": "222508f9-13fd-4439-849e-b1716a7252f3",
      "user": {
        "id": "d4b1a36a-f488-4848-8fbc-382cb82d9a80",
        "username": "elizabeth412"
      },
      "offerStatus": 1,
      "offerType": 0,
      "createdAt": "2025-03-05T13:03:44.652Z",
      "description": "ESTOY EN LÍNEA 24/7",
      "cryptoCurrencyId": "TATUM-TRON-USDT",
      "chain": "TRON",
      "fiatCurrencyId": "COP",
      "maxLimit": "9803832.73",
      "minLimit": "195000",
      "marketSize": "55000000",
      "availableSize": "10008601.09557145777693852956",
      "limits": {
        "crypto": {
          "maxLimit": "2481.89",
          "minLimit": "49.77",
          "marketSize": "13902.73",
          "availableSize": "2533.73"
        },
        "fiat": {
          "maxLimit": "9803832.73",
          "minLimit": "195000",
          "marketSize": "55000000",
          "availableSize": "10008601.09557145777693852956"
        }
      },
      "isDepleted": false,
      "fiatToCryptoExchangeRate": "3965.55",
      "offerMakerStats": {
        "userId": "d4b1a36a-f488-4848-8fbc-382cb82d9a80",
        "rating": 4.8,
        "userRating": 4.8,
        "releaseTime": 2.65,
        "payTime": 2.09,
        "responseTime": 2.36,
        "totalOffersCount": 95,
        "totalTransactionCount": 944,
        "marketMakerTransactionCount": 633,
        "marketTakerTransactionCount": 311,
        "uniqueTradersCount": 756,
        "marketMakerOrderTime": 5.89,
        "marketMakerSuccessRatio": 0.87,
        "user_lastSeen": "41",
        "user_status": "OFFLINE"
      },
      "paymentMethods": ["bank_bancolombia"],
      "usdRate": "1",
      "paused": false,
      "user_status": "OFFLINE",
      "user_lastSeen": "41",
      "display": true,
      "visibility": "PUBLIC",
      "paymentMethodFilter": [],
      "orderRequestEnabled": true,
      "offerTransactionsEnabled": true,
      "escrow": "INTERNAL_V1",
      "allowsThirdPartyPayments": true
    },
    "bySpeed": {
      "offerId": "a35919a3-13a7-4fa2-831c-83f5d64e794a",
      "user": {
        "id": "3b3ea3ff-05e3-424d-88d2-edc521ee697f",
        "username": "liliana272"
      },
      "offerStatus": 1,
      "offerType": 0,
      "createdAt": "2025-06-25T23:51:38.001Z",
      "description": "activo",
      "cryptoCurrencyId": "TATUM-TRON-USDT",
      "chain": "TRON",
      "fiatCurrencyId": "COP",
      "maxLimit": "900000",
      "minLimit": "10000",
      "marketSize": "16287000",
      "availableSize": "900000.00000000000000001191",
      "limits": {
        "crypto": {
          "maxLimit": "230.92",
          "minLimit": "3.03",
          "marketSize": "4154.09",
          "availableSize": "230.92"
        },
        "fiat": {
          "maxLimit": "900000",
          "minLimit": "10000",
          "marketSize": "16287000",
          "availableSize": "900000.00000000000000001191"
        }
      },
      "isDepleted": false,
      "fiatToCryptoExchangeRate": "3936",
      "offerMakerStats": {
        "userId": "3b3ea3ff-05e3-424d-88d2-edc521ee697f",
        "rating": 4.9,
        "userRating": 4.9,
        "releaseTime": 1.03,
        "payTime": 1.54,
        "responseTime": 1.41,
        "totalOffersCount": 27,
        "totalTransactionCount": 364,
        "marketMakerTransactionCount": 293,
        "marketTakerTransactionCount": 71,
        "uniqueTradersCount": 270,
        "marketMakerOrderTime": 4.27,
        "marketMakerSuccessRatio": 0.93,
        "user_lastSeen": "201",
        "user_status": "OFFLINE"
      },
      "paymentMethods": ["bank_bancolombia"],
      "usdRate": "1",
      "paused": false,
      "user_status": "OFFLINE",
      "user_lastSeen": "201",
      "display": true,
      "visibility": "PUBLIC",
      "paymentMethodFilter": [],
      "orderRequestEnabled": true,
      "offerTransactionsEnabled": true,
      "escrow": "INTERNAL_V1",
      "allowsThirdPartyPayments": true
    },
    "byReputation": {
      "offerId": "afc8fd2e-164b-4305-82fd-9dd69d728892",
      "user": {
        "id": "713ce3f5-4a5b-47ac-bcad-7ec4c9673509",
        "username": "serluis_36"
      },
      "offerStatus": 1,
      "offerType": 0,
      "createdAt": "2025-01-27T00:30:20.548Z",
      "description": "soy el titular. pago rápido",
      "cryptoCurrencyId": "TATUM-TRON-USDT",
      "fiatCurrencyId": "COP",
      "maxLimit": "8604103.82",
      "minLimit": "40000",
      "marketSize": "36000000",
      "availableSize": "8604103.82008512300388548561",
      "limits": {
        "crypto": {
          "maxLimit": "2252.32",
          "minLimit": "10.92",
          "marketSize": "9423.83",
          "availableSize": "2252.32"
        },
        "fiat": {
          "maxLimit": "8604103.82",
          "minLimit": "40000",
          "marketSize": "36000000",
          "availableSize": "8604103.82008512300388548561"
        }
      },
      "isDepleted": false,
      "fiatToCryptoExchangeRate": "3835",
      "offerMakerStats": {
        "userId": "713ce3f5-4a5b-47ac-bcad-7ec4c9673509",
        "rating": 5.0,
        "userRating": 5.0,
        "releaseTime": 1.30,
        "payTime": 2.82,
        "responseTime": 1.84,
        "totalOffersCount": 590,
        "totalTransactionCount": 5976,
        "marketMakerTransactionCount": 5946,
        "marketTakerTransactionCount": 30,
        "uniqueTradersCount": 3312,
        "marketMakerOrderTime": 6.34,
        "marketMakerSuccessRatio": 0.98,
        "user_lastSeen": "28",
        "user_status": "AWAY"
      },
      "paymentMethods": ["app_llave_co", "app_nequi_co", "bank_bancolombia"],
      "usdRate": "1",
      "paused": false,
      "user_status": "AWAY",
      "user_lastSeen": "28",
      "display": true,
      "visibility": "PUBLIC",
      "paymentMethodFilter": [],
      "orderRequestEnabled": true,
      "offerTransactionsEnabled": false,
      "escrow": "INTERNAL_V1",
      "allowsThirdPartyPayments": true
    }
  }
}
''';
