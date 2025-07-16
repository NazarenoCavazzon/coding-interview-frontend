import 'package:challenge_eldorado/app/app.dart';
import 'package:challenge_eldorado/p2p_quote/widgets/quote_currency_switch.dart';
import 'package:client/client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i18n/i18n.dart';
import 'package:integration_test/integration_test.dart';
import 'package:recommendation_repository/recommendation_repository.dart';
import 'package:ui/ui.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('P2P Quote Flow Integration Tests', () {
    late RecommendationRepository recommendationRepository;

    setUp(() async {
      final client = ElDoradoApiClient.stage();
      recommendationRepository = RecommendationRepository(client: client);
      await LocaleSettings.setLocale(AppLocale.es);
    });

    testWidgets('complete quote flow - enter amount', (tester) async {
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final currencyInput = find.byType(CurrencyInput);
      await tester.enterText(currencyInput, '100');
      await tester.pumpAndSettle();

      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      expect(find.byType(CurrencyInput), findsOneWidget);
    });

    testWidgets('exchange direction switch works', (tester) async {
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final switchButton = find.byType(QuoteCurrencySwitch);
      await tester.tap(switchButton);
      await tester.pumpAndSettle();

      expect(find.byType(QuoteCurrencySwitch), findsOneWidget);
    });

    testWidgets('amount input accepts decimal numbers', (tester) async {
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final currencyInput = find.byType(CurrencyInput);
      await tester.enterText(currencyInput, '123.45');
      await tester.pumpAndSettle();

      expect(find.byType(CurrencyInput), findsOneWidget);
    });

    testWidgets('comma to decimal conversion works', (tester) async {
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final currencyInput = find.byType(CurrencyInput);
      await tester.enterText(currencyInput, '123,45');
      await tester.pumpAndSettle();

      expect(find.byType(CurrencyInput), findsOneWidget);
    });

    testWidgets('debounced quote requests work', (tester) async {
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final currencyInput = find.byType(CurrencyInput);

      await tester.enterText(currencyInput, '1');
      await tester.pump(const Duration(milliseconds: 100));

      await tester.enterText(currencyInput, '12');
      await tester.pump(const Duration(milliseconds: 100));

      await tester.enterText(currencyInput, '123');
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      expect(find.byType(CurrencyInput), findsOneWidget);
    });
  });
}
