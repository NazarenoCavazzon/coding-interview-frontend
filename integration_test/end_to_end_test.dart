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

  group('End-to-End Integration Tests', () {
    late RecommendationRepository recommendationRepository;

    setUp(() async {
      final client = ElDoradoApiClient.stage();
      recommendationRepository = RecommendationRepository(client: client);
      await LocaleSettings.setLocale(AppLocale.es);
    });

    testWidgets('complete user workflow: off-ramp flow', (tester) async {
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

    testWidgets('complete user workflow: on-ramp flow', (tester) async {
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final switchButton = find.byType(QuoteCurrencySwitch);
      await tester.tap(switchButton);
      await tester.pumpAndSettle();

      final currencyInput = find.byType(CurrencyInput);
      await tester.enterText(currencyInput, '0.1');
      await tester.pumpAndSettle();

      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      expect(find.byType(CurrencyInput), findsOneWidget);
    });

    testWidgets('complete user workflow: currency selection and switching', (
      tester,
    ) async {
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final currencyInput = find.byType(CurrencyInput);
      await tester.enterText(currencyInput, '50');
      await tester.pumpAndSettle();

      final switchButton = find.byType(QuoteCurrencySwitch);
      await tester.tap(switchButton);
      await tester.pumpAndSettle();

      await tester.enterText(currencyInput, '0.05');
      await tester.pumpAndSettle();

      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      expect(find.byType(CurrencyInput), findsOneWidget);
    });

    testWidgets('complete user workflow: error recovery', (tester) async {
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final currencyInput = find.byType(CurrencyInput);

      await tester.enterText(currencyInput, 'invalid');
      await tester.pumpAndSettle();

      await tester.enterText(currencyInput, '');
      await tester.pumpAndSettle();

      await tester.enterText(currencyInput, '100');
      await tester.pumpAndSettle();

      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();

      expect(find.byType(CurrencyInput), findsOneWidget);
    });
  });
}
