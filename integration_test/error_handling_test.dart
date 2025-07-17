import 'package:challenge_eldorado/app/app.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i18n/i18n.dart';
import 'package:integration_test/integration_test.dart';
import 'package:recommendation_repository/recommendation_repository.dart';
import 'package:ui/ui.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Error Handling Integration Tests', () {
    late RecommendationRepository recommendationRepository;

    setUp(() async {
      final client = ElDoradoApiClient.stage();
      recommendationRepository = RecommendationRepository(client: client);
      await LocaleSettings.setLocale(AppLocale.es);
    });

    testWidgets('app handles empty input correctly', (tester) async {
      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );
      await tester.pumpAndSettle();

      final currencyInput = find.byType(CurrencyInput);
      await tester.enterText(currencyInput, '');
      await tester.pumpAndSettle();

      expect(find.byType(CurrencyInput), findsOneWidget);
    });

    testWidgets('app handles special characters in input', (tester) async {
      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );
      await tester.pumpAndSettle();

      final currencyInput = find.byType(CurrencyInput);
      await tester.enterText(currencyInput, r'!@#$%^&*()');
      await tester.pumpAndSettle();

      expect(find.byType(CurrencyInput), findsOneWidget);
    });

    testWidgets('app handles rapid input changes', (tester) async {
      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );
      await tester.pumpAndSettle();

      final currencyInput = find.byType(CurrencyInput);

      for (var i = 0; i < 10; i++) {
        await tester.enterText(currencyInput, '$i');
        await tester.pump(const Duration(milliseconds: 50));
      }

      await tester.pumpAndSettle();
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('app handles widget disposal correctly', (tester) async {
      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );
      await tester.pumpAndSettle();

      final currencyInput = find.byType(CurrencyInput);
      await tester.enterText(currencyInput, '100');
      await tester.pumpAndSettle();

      await tester.pumpWidget(const MaterialApp(home: Scaffold()));
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}
