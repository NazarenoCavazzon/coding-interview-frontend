// ignore_for_file: lines_longer_than_80_chars

import 'package:client/client.dart';
import 'package:decimal/decimal.dart';
import 'package:recommendation_repository/recommendation_repository.dart';
import 'package:test/test.dart';

// Mock client for testing
class MockClient implements HttpClientBase {
  MockClient(this._handler);

  final Future<Map<String, dynamic>> Function(
    int exchangeType,
    String cryptoCurrencyId,
    String fiatCurrencyId,
    Decimal amount,
    String amountCurrencyId,
  )
  _handler;

  @override
  Future<Map<String, dynamic>> getRecommendations({
    required int exchangeType,
    required String cryptoCurrencyId,
    required String fiatCurrencyId,
    required Decimal amount,
    required String amountCurrencyId,
  }) async {
    return _handler(
      exchangeType,
      cryptoCurrencyId,
      fiatCurrencyId,
      amount,
      amountCurrencyId,
    );
  }

  @override
  void dispose() {}
}

void main() {
  group('RecommendationRepository', () {
    late RecommendationRepository repository;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient((_, __, ___, ____, _____) async => _mockResponse);
      repository = RecommendationRepository(client: mockClient);
    });

    test('should make correct call to client', () async {
      late int capturedExchangeType;
      late String capturedCryptoCurrencyId;
      late String capturedFiatCurrencyId;
      late Decimal capturedAmount;
      late String capturedAmountCurrencyId;

      mockClient = MockClient((
        exchangeType,
        cryptoCurrencyId,
        fiatCurrencyId,
        amount,
        amountCurrencyId,
      ) async {
        capturedExchangeType = exchangeType;
        capturedCryptoCurrencyId = cryptoCurrencyId;
        capturedFiatCurrencyId = fiatCurrencyId;
        capturedAmount = amount;
        capturedAmountCurrencyId = amountCurrencyId;
        return _mockResponse;
      });
      repository = RecommendationRepository(client: mockClient);

      await repository.getRecommendations(
        exchangeType: ExchangeType.offRamp,
        cryptoCurrencyId: 'TATUM-TRON-USDT',
        fiatCurrencyId: 'COP',
        amount: Decimal.fromInt(100),
        amountCurrencyId: 'TATUM-TRON-USDT',
      );

      expect(capturedExchangeType, equals(0));
      expect(capturedCryptoCurrencyId, equals('TATUM-TRON-USDT'));
      expect(capturedFiatCurrencyId, equals('COP'));
      expect(capturedAmount, equals(Decimal.fromInt(100)));
      expect(capturedAmountCurrencyId, equals('TATUM-TRON-USDT'));
    });

    test('should parse successful response correctly', () async {
      mockClient = MockClient((_, __, ___, ____, _____) async => _mockResponse);
      repository = RecommendationRepository(client: mockClient);

      final result = await repository.getRecommendations(
        exchangeType: ExchangeType.offRamp,
        cryptoCurrencyId: 'TATUM-TRON-USDT',
        fiatCurrencyId: 'COP',
        amount: Decimal.fromInt(100),
        amountCurrencyId: 'TATUM-TRON-USDT',
      );

      expect(result, isA<Recommendation>());
      expect(result.byPrice.fiatToCryptoExchangeRate, equals('3965.55'));
      expect(result.byPrice.cryptoCurrencyId, equals('TATUM-TRON-USDT'));
      expect(result.byPrice.fiatCurrencyId, equals('COP'));
      expect(
        result.byPrice.user.id,
        equals('d4b1a36a-f488-4848-8fbc-382cb82d9a80'),
      );
      expect(result.byPrice.user.username, equals('elizabeth412'));
      expect(result.byPrice.offerMakerStats.rating, equals(4.8));
      expect(result.byPrice.offerMakerStats.releaseTime, equals(2.65));
      expect(result.byPrice.limits.fiat.maxLimit, equals('9803832.73'));
      expect(result.byPrice.limits.crypto.maxLimit, equals('2481.89'));
    });

    test('should handle on-ramp exchange type', () async {
      late int capturedExchangeType;
      mockClient = MockClient((exchangeType, _, __, ___, ____) async {
        capturedExchangeType = exchangeType;
        return _mockResponse;
      });
      repository = RecommendationRepository(client: mockClient);

      await repository.getRecommendations(
        exchangeType: ExchangeType.onRamp,
        cryptoCurrencyId: 'TATUM-TRON-USDT',
        fiatCurrencyId: 'COP',
        amount: Decimal.fromInt(100),
        amountCurrencyId: 'COP',
      );

      expect(capturedExchangeType, equals(1));
    });

    test(
      'should throw NoRecommendationDataFoundException when data is null',
      () async {
        mockClient = MockClient(
          (_, __, ___, ____, _____) async => {'data': null},
        );
        repository = RecommendationRepository(client: mockClient);

        expect(
          () async => repository.getRecommendations(
            exchangeType: ExchangeType.offRamp,
            cryptoCurrencyId: 'TATUM-TRON-USDT',
            fiatCurrencyId: 'COP',
            amount: Decimal.fromInt(100),
            amountCurrencyId: 'TATUM-TRON-USDT',
          ),
          throwsA(isA<NoRecommendationDataFoundException>()),
        );
      },
    );

    test(
      'should throw NoRecommendationDataFoundException when data is empty',
      () async {
        mockClient = MockClient(
          (_, __, ___, ____, _____) async => {'data': <String, dynamic>{}},
        );
        repository = RecommendationRepository(client: mockClient);

        expect(
          () async => repository.getRecommendations(
            exchangeType: ExchangeType.offRamp,
            cryptoCurrencyId: 'TATUM-TRON-USDT',
            fiatCurrencyId: 'COP',
            amount: Decimal.fromInt(100),
            amountCurrencyId: 'TATUM-TRON-USDT',
          ),
          throwsA(isA<NoRecommendationDataFoundException>()),
        );
      },
    );

    test(
      'should throw NoRecommendationDataFoundException when data is not a Map',
      () async {
        mockClient = MockClient(
          (_, __, ___, ____, _____) async => {'data': 'not a map'},
        );
        repository = RecommendationRepository(client: mockClient);

        expect(
          () async => repository.getRecommendations(
            exchangeType: ExchangeType.offRamp,
            cryptoCurrencyId: 'TATUM-TRON-USDT',
            fiatCurrencyId: 'COP',
            amount: Decimal.fromInt(100),
            amountCurrencyId: 'TATUM-TRON-USDT',
          ),
          throwsA(isA<NoRecommendationDataFoundException>()),
        );
      },
    );

    test('should handle missing optional fields in response', () async {
      final minimalResponse = {
        'data': {
          'byPrice': {
            'fiatToCryptoExchangeRate': '3965.55',
            'user': {'id': 'test-id'},
            'offerMakerStats': {'userId': 'test-user-id'},
            'limits': {
              'crypto': <String, dynamic>{},
              'fiat': <String, dynamic>{},
            },
          },
          'bySpeed': {
            'fiatToCryptoExchangeRate': '3936',
            'user': {'id': 'test-id'},
            'offerMakerStats': {'userId': 'test-user-id'},
            'limits': {
              'crypto': <String, dynamic>{},
              'fiat': <String, dynamic>{},
            },
          },
          'byReputation': {
            'fiatToCryptoExchangeRate': '3835',
            'user': {'id': 'test-id'},
            'offerMakerStats': {'userId': 'test-user-id'},
            'limits': {
              'crypto': <String, dynamic>{},
              'fiat': <String, dynamic>{},
            },
          },
        },
      };

      mockClient = MockClient(
        (_, __, ___, ____, _____) async => minimalResponse,
      );
      repository = RecommendationRepository(client: mockClient);

      final result = await repository.getRecommendations(
        exchangeType: ExchangeType.offRamp,
        cryptoCurrencyId: 'TATUM-TRON-USDT',
        fiatCurrencyId: 'COP',
        amount: Decimal.fromInt(100),
        amountCurrencyId: 'TATUM-TRON-USDT',
      );

      expect(result, isA<Recommendation>());
      expect(result.byPrice.fiatToCryptoExchangeRate, equals('3965.55'));
      expect(result.byPrice.user.id, equals('test-id'));
      expect(result.byPrice.user.username, isNull);
    });

    test(
      'should throw RecommendationParsingException when JSON structure is invalid',
      () async {
        mockClient = MockClient(
          (_, __, ___, ____, _____) async => {
            'data': {
              'byPrice': 'invalid_structure',
              'bySpeed': 'invalid_structure',
              'byReputation': 'invalid_structure',
            },
          },
        );
        repository = RecommendationRepository(client: mockClient);

        expect(
          () async => repository.getRecommendations(
            exchangeType: ExchangeType.offRamp,
            cryptoCurrencyId: 'TATUM-TRON-USDT',
            fiatCurrencyId: 'COP',
            amount: Decimal.fromInt(100),
            amountCurrencyId: 'TATUM-TRON-USDT',
          ),
          throwsA(isA<RecommendationParsingException>()),
        );
      },
    );

    test(
      'should throw NoRecommendationDataFoundException when response has no data key',
      () async {
        mockClient = MockClient(
          (_, __, ___, ____, _____) async => {'invalid_key': 'some_value'},
        );
        repository = RecommendationRepository(client: mockClient);

        expect(
          () async => repository.getRecommendations(
            exchangeType: ExchangeType.offRamp,
            cryptoCurrencyId: 'TATUM-TRON-USDT',
            fiatCurrencyId: 'COP',
            amount: Decimal.fromInt(100),
            amountCurrencyId: 'TATUM-TRON-USDT',
          ),
          throwsA(isA<NoRecommendationDataFoundException>()),
        );
      },
    );

    test(
      'should throw RecommendationParsingException when response structure is completely wrong',
      () async {
        mockClient = MockClient(
          (_, __, ___, ____, _____) async => {
            'data': {
              'byPrice': {
                'fiatToCryptoExchangeRate':
                    null, // This will cause parsing errors
                'user': null,
                'offerMakerStats': null,
                'limits': null,
              },
              'bySpeed': {
                'fiatToCryptoExchangeRate': null,
                'user': null,
                'offerMakerStats': null,
                'limits': null,
              },
              'byReputation': {
                'fiatToCryptoExchangeRate': null,
                'user': null,
                'offerMakerStats': null,
                'limits': null,
              },
            },
          },
        );
        repository = RecommendationRepository(client: mockClient);

        expect(
          () async => repository.getRecommendations(
            exchangeType: ExchangeType.offRamp,
            cryptoCurrencyId: 'TATUM-TRON-USDT',
            fiatCurrencyId: 'COP',
            amount: Decimal.fromInt(100),
            amountCurrencyId: 'TATUM-TRON-USDT',
          ),
          throwsA(isA<RecommendationParsingException>()),
        );
      },
    );
  });

  group('NoRecommendationDataFoundException', () {
    test('should have correct string representation', () {
      const exception = NoRecommendationDataFoundException();
      expect(
        exception.toString(),
        equals(
          'NoRecommendationDataFoundException: No recommendation data found',
        ),
      );
    });
  });

  group('RecommendationParsingException', () {
    test('should have correct string representation', () {
      const exception = RecommendationParsingException('Test parsing error');
      expect(
        exception.toString(),
        equals('RecommendationParsingException: Test parsing error'),
      );
    });

    test('should have correct properties', () {
      const exception = RecommendationParsingException('Test parsing error');
      expect(exception.message, equals('Test parsing error'));
    });
  });
}

const Map<String, dynamic> _mockResponse = {
  'data': {
    'byPrice': {
      'offerId': '222508f9-13fd-4439-849e-b1716a7252f3',
      'user': {
        'id': 'd4b1a36a-f488-4848-8fbc-382cb82d9a80',
        'username': 'elizabeth412',
      },
      'offerStatus': 1,
      'offerType': 0,
      'createdAt': '2025-03-05T13:03:44.652Z',
      'description': 'ESTOY EN LÍNEA 24/7',
      'cryptoCurrencyId': 'TATUM-TRON-USDT',
      'chain': 'TRON',
      'fiatCurrencyId': 'COP',
      'maxLimit': '9803832.73',
      'minLimit': '195000',
      'marketSize': '55000000',
      'availableSize': '10008601.09557145777693852956',
      'limits': {
        'crypto': {
          'maxLimit': '2481.89',
          'minLimit': '49.77',
          'marketSize': '13902.73',
          'availableSize': '2533.73',
        },
        'fiat': {
          'maxLimit': '9803832.73',
          'minLimit': '195000',
          'marketSize': '55000000',
          'availableSize': '10008601.09557145777693852956',
        },
      },
      'isDepleted': false,
      'fiatToCryptoExchangeRate': '3965.55',
      'offerMakerStats': {
        'userId': 'd4b1a36a-f488-4848-8fbc-382cb82d9a80',
        'rating': 4.8,
        'userRating': 4.8,
        'releaseTime': 2.65,
        'payTime': 2.09,
        'responseTime': 2.36,
        'totalOffersCount': 95,
        'totalTransactionCount': 944,
        'marketMakerTransactionCount': 633,
        'marketTakerTransactionCount': 311,
        'uniqueTradersCount': 756,
        'marketMakerOrderTime': 5.89,
        'marketMakerSuccessRatio': 0.87,
        'user_lastSeen': '41',
        'user_status': 'OFFLINE',
      },
      'paymentMethods': ['bank_bancolombia'],
      'usdRate': '1',
      'paused': false,
      'user_status': 'OFFLINE',
      'user_lastSeen': '41',
      'display': true,
      'visibility': 'PUBLIC',
      'paymentMethodFilter': <String>[],
      'orderRequestEnabled': true,
      'offerTransactionsEnabled': true,
      'escrow': 'INTERNAL_V1',
      'allowsThirdPartyPayments': true,
    },
    'bySpeed': {
      'offerId': 'a35919a3-13a7-4fa2-831c-83f5d64e794a',
      'user': {
        'id': '3b3ea3ff-05e3-424d-88d2-edc521ee697f',
        'username': 'liliana272',
      },
      'offerStatus': 1,
      'offerType': 0,
      'createdAt': '2025-06-25T23:51:38.001Z',
      'description': 'activo',
      'cryptoCurrencyId': 'TATUM-TRON-USDT',
      'chain': 'TRON',
      'fiatCurrencyId': 'COP',
      'maxLimit': '900000',
      'minLimit': '10000',
      'marketSize': '16287000',
      'availableSize': '900000.00000000000000001191',
      'limits': {
        'crypto': {
          'maxLimit': '230.92',
          'minLimit': '3.03',
          'marketSize': '4154.09',
          'availableSize': '230.92',
        },
        'fiat': {
          'maxLimit': '900000',
          'minLimit': '10000',
          'marketSize': '16287000',
          'availableSize': '900000.00000000000000001191',
        },
      },
      'isDepleted': false,
      'fiatToCryptoExchangeRate': '3936',
      'offerMakerStats': {
        'userId': '3b3ea3ff-05e3-424d-88d2-edc521ee697f',
        'rating': 4.9,
        'userRating': 4.9,
        'releaseTime': 1.03,
        'payTime': 1.54,
        'responseTime': 1.41,
        'totalOffersCount': 27,
        'totalTransactionCount': 364,
        'marketMakerTransactionCount': 293,
        'marketTakerTransactionCount': 71,
        'uniqueTradersCount': 270,
        'marketMakerOrderTime': 4.27,
        'marketMakerSuccessRatio': 0.93,
        'user_lastSeen': '201',
        'user_status': 'OFFLINE',
      },
      'paymentMethods': ['bank_bancolombia'],
      'usdRate': '1',
      'paused': false,
      'user_status': 'OFFLINE',
      'user_lastSeen': '201',
      'display': true,
      'visibility': 'PUBLIC',
      'paymentMethodFilter': <String>[],
      'orderRequestEnabled': true,
      'offerTransactionsEnabled': true,
      'escrow': 'INTERNAL_V1',
      'allowsThirdPartyPayments': true,
    },
    'byReputation': {
      'offerId': 'afc8fd2e-164b-4305-82fd-9dd69d728892',
      'user': {
        'id': '713ce3f5-4a5b-47ac-bcad-7ec4c9673509',
        'username': 'serluis_36',
      },
      'offerStatus': 1,
      'offerType': 0,
      'createdAt': '2025-01-27T00:30:20.548Z',
      'description': 'soy el titular. pago rápido',
      'cryptoCurrencyId': 'TATUM-TRON-USDT',
      'fiatCurrencyId': 'COP',
      'maxLimit': '8604103.82',
      'minLimit': '40000',
      'marketSize': '36000000',
      'availableSize': '8604103.82008512300388548561',
      'limits': {
        'crypto': {
          'maxLimit': '2252.32',
          'minLimit': '10.92',
          'marketSize': '9423.83',
          'availableSize': '2252.32',
        },
        'fiat': {
          'maxLimit': '8604103.82',
          'minLimit': '40000',
          'marketSize': '36000000',
          'availableSize': '8604103.82008512300388548561',
        },
      },
      'isDepleted': false,
      'fiatToCryptoExchangeRate': '3835',
      'offerMakerStats': {
        'userId': '713ce3f5-4a5b-47ac-bcad-7ec4c9673509',
        'rating': 5.0,
        'userRating': 5.0,
        'releaseTime': 1.30,
        'payTime': 2.82,
        'responseTime': 1.84,
        'totalOffersCount': 590,
        'totalTransactionCount': 5976,
        'marketMakerTransactionCount': 5946,
        'marketTakerTransactionCount': 30,
        'uniqueTradersCount': 3312,
        'marketMakerOrderTime': 6.34,
        'marketMakerSuccessRatio': 0.98,
        'user_lastSeen': '28',
        'user_status': 'AWAY',
      },
      'paymentMethods': ['app_llave_co', 'app_nequi_co', 'bank_bancolombia'],
      'usdRate': '1',
      'paused': false,
      'user_status': 'AWAY',
      'user_lastSeen': '28',
      'display': true,
      'visibility': 'PUBLIC',
      'paymentMethodFilter': <String>[],
      'orderRequestEnabled': true,
      'offerTransactionsEnabled': false,
      'escrow': 'INTERNAL_V1',
      'allowsThirdPartyPayments': true,
    },
  },
};
