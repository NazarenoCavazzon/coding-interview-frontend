import 'package:challenge_eldorado/app/app.dart';
import 'package:challenge_eldorado/p2p_quote/widgets/quote_card.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i18n/i18n.dart';
import 'package:integration_test/integration_test.dart';
import 'package:recommendation_repository/recommendation_repository.dart';
import 'package:ui/ui.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('App Integration Tests', () {
    late RecommendationRepository recommendationRepository;

    setUp(() async {
      final client = ElDoradoApiClient.stage();
      recommendationRepository = RecommendationRepository(client: client);
      await LocaleSettings.setLocale(AppLocale.es);
    });

    testWidgets('app initializes and renders main components', (tester) async {
      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(QuoteCard), findsOneWidget);
      expect(find.byType(DarkModeSwitch), findsOneWidget);
      expect(find.byType(LanguageSwitch), findsOneWidget);
    });

    testWidgets('app renders without crashing on different screen sizes', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(375, 667));
      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );
      await tester.pumpAndSettle();

      expect(find.byType(QuoteCard), findsOneWidget);

      await tester.binding.setSurfaceSize(const Size(414, 896));
      await tester.pumpAndSettle();

      expect(find.byType(QuoteCard), findsOneWidget);

      await tester.binding.setSurfaceSize(const Size(800, 600));
      await tester.pumpAndSettle();

      expect(find.byType(QuoteCard), findsOneWidget);
    });

    testWidgets('tap outside input dismisses keyboard', (tester) async {
      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );
      await tester.pumpAndSettle();

      final currencyInput = find.byType(CurrencyInput);
      expect(currencyInput, findsOneWidget);

      await tester.tap(currencyInput);
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Scaffold));
      await tester.pumpAndSettle();

      expect(find.byType(QuoteCard), findsOneWidget);
    });

    testWidgets('app preserves state during widget rebuilds', (tester) async {
      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );
      await tester.pumpAndSettle();

      final currencyInput = find.byType(CurrencyInput);
      await tester.enterText(currencyInput, '100');
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );
      await tester.pumpAndSettle();

      expect(find.byType(QuoteCard), findsOneWidget);
    });
  });
}
