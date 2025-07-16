import 'package:challenge_eldorado/app/app.dart';
import 'package:challenge_eldorado/p2p_quote/widgets/quote_currency_switch.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';
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

    testWidgets('complete user workflow: currency selection', (tester) async {
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final currencyButtons = find.byType(AppButton);
      expect(currencyButtons, findsWidgets);

      await tester.tap(currencyButtons.first);
      await tester.pumpAndSettle();

      expect(find.byType(AppButton), findsWidgets);
    });

    testWidgets('complete user workflow: theme and language switching', (
      tester,
    ) async {
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final initialTheme = Theme.of(tester.element(find.byType(Scaffold)));
      final initialBrightness = initialTheme.brightness;

      final darkModeSwitch = find.byType(DarkModeSwitch);
      await tester.tap(darkModeSwitch);
      await tester.pumpAndSettle();

      final newTheme = Theme.of(tester.element(find.byType(Scaffold)));
      final newBrightness = newTheme.brightness;
      expect(newBrightness, isNot(initialBrightness));

      final languageSwitch = find.byType(LanguageSwitch);
      await tester.tap(languageSwitch);
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('complete user workflow: multiple operations sequence', (
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

      final darkModeSwitch = find.byType(DarkModeSwitch);
      await tester.tap(darkModeSwitch);
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

    testWidgets('complete user workflow: responsive design', (tester) async {
      await tester.binding.setSurfaceSize(const Size(375, 667));
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final currencyInput = find.byType(CurrencyInput);
      await tester.enterText(currencyInput, '100');
      await tester.pumpAndSettle();

      await tester.binding.setSurfaceSize(const Size(800, 600));
      await tester.pumpAndSettle();

      expect(find.byType(CurrencyInput), findsOneWidget);

      await tester.binding.setSurfaceSize(const Size(1200, 800));
      await tester.pumpAndSettle();

      expect(find.byType(CurrencyInput), findsOneWidget);
    });

    testWidgets('complete user workflow: performance under load', (
      tester,
    ) async {
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final stopwatch = Stopwatch()..start();

      final currencyInput = find.byType(CurrencyInput);

      for (var i = 1; i <= 10; i++) {
        await tester.enterText(currencyInput, '$i');
        await tester.pump(const Duration(milliseconds: 50));
      }

      await tester.pumpAndSettle();
      stopwatch.stop();

      expect(stopwatch.elapsedMilliseconds, lessThan(5000));
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
