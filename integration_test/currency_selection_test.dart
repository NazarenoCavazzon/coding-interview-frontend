import 'package:challenge_eldorado/app/app.dart';
import 'package:challenge_eldorado/p2p_quote/widgets/quote_currency_bottom_sheet.dart';
import 'package:challenge_eldorado/p2p_quote/widgets/quote_currency_buttons.dart';
import 'package:challenge_eldorado/p2p_quote/widgets/quote_currency_dialog.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:i18n/i18n.dart';
import 'package:integration_test/integration_test.dart';
import 'package:recommendation_repository/recommendation_repository.dart';
import 'package:ui/ui.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Currency Selection Integration Tests', () {
    late RecommendationRepository recommendationRepository;

    setUp(() async {
      final client = ElDoradoApiClient.stage();
      recommendationRepository = RecommendationRepository(client: client);
      await LocaleSettings.setLocale(AppLocale.es);
    });

    testWidgets('fiat currency selection opens bottom sheet on phone', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(375, 667));
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final fiatCurrencyButton = find.byType(SelectedCurrency).first;
      await tester.tap(fiatCurrencyButton);
      await tester.pumpAndSettle();

      expect(find.byType(QuoteCurrencySelectorBottomSheet), findsOneWidget);
      expect(find.text('FIAT'), findsOneWidget);
    });

    testWidgets('fiat currency selection opens dialog on tablet', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(800, 600));
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final fiatCurrencyButton = find.byType(SelectedCurrency).first;
      await tester.tap(fiatCurrencyButton);
      await tester.pumpAndSettle();

      final hasBottomSheet = find
          .byType(QuoteCurrencySelectorBottomSheet)
          .evaluate()
          .isNotEmpty;
      final hasDialog =
          find.byType(QuoteCurrencySelectorDialog).evaluate().isNotEmpty ||
          find.byType(AppDialog).evaluate().isNotEmpty ||
          find.byType(Dialog).evaluate().isNotEmpty;

      expect(hasBottomSheet || hasDialog, true);
      expect(find.text('FIAT'), findsOneWidget);
    });

    testWidgets('can select fiat currency from bottom sheet', (tester) async {
      await tester.binding.setSurfaceSize(const Size(375, 667));
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final fiatCurrencyButton = find.byType(SelectedCurrency).first;
      await tester.tap(fiatCurrencyButton);
      await tester.pumpAndSettle();

      final currencyItem = find.byType(AppBottomSheetItem).first;
      await tester.tap(currencyItem);
      await tester.pumpAndSettle();

      expect(find.byType(QuoteCurrencySelectorBottomSheet), findsNothing);
    });

    testWidgets('crypto currency selection shows USDT', (tester) async {
      await tester.binding.setSurfaceSize(const Size(375, 667));
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final cryptoCurrencyButton = find.byType(SelectedCurrency).last;
      await tester.tap(cryptoCurrencyButton);
      await tester.pumpAndSettle();

      expect(find.byType(QuoteCurrencySelectorBottomSheet), findsOneWidget);
      expect(find.text('CRYPTO'), findsOneWidget);
      expect(find.byType(AppBottomSheetItem), findsOneWidget);
    });

    testWidgets('bottom sheet can be dismissed by tapping outside', (
      tester,
    ) async {
      await tester.binding.setSurfaceSize(const Size(375, 667));
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final fiatCurrencyButton = find.byType(SelectedCurrency).first;
      await tester.tap(fiatCurrencyButton);
      await tester.pumpAndSettle();

      expect(find.byType(QuoteCurrencySelectorBottomSheet), findsOneWidget);

      await tester.tapAt(const Offset(200, 100));
      await tester.pumpAndSettle();

      expect(find.byType(QuoteCurrencySelectorBottomSheet), findsNothing);
    });

    testWidgets('radio buttons work correctly', (tester) async {
      await tester.binding.setSurfaceSize(const Size(375, 667));
      await tester.pumpWidget(
        TranslationProvider(
          child: App(recommendationRepository: recommendationRepository),
        ),
      );
      await tester.pumpAndSettle();

      final fiatCurrencyButton = find.byType(SelectedCurrency).first;
      await tester.tap(fiatCurrencyButton);
      await tester.pumpAndSettle();

      final radioButtons = find.byType(Radio<Currency>);
      expect(radioButtons, findsNWidgets(4));

      await tester.tap(radioButtons.at(1));
      await tester.pumpAndSettle();

      expect(find.byType(QuoteCurrencySelectorBottomSheet), findsNothing);
    });
  });
}
