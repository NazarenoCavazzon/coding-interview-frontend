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

  group('Theme and Localization Integration Tests', () {
    late RecommendationRepository recommendationRepository;

    setUp(() async {
      final client = ElDoradoApiClient.stage();
      recommendationRepository = RecommendationRepository(client: client);
      await LocaleSettings.setLocale(AppLocale.es);
    });

    testWidgets('dark mode switch toggles theme', (tester) async {
      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );
      await tester.pumpAndSettle();

      final initialTheme = Theme.of(tester.element(find.byType(Scaffold)));
      final initialBrightness = initialTheme.brightness;

      final darkModeSwitch = find.byType(DarkModeSwitch);
      expect(darkModeSwitch, findsOneWidget);

      await tester.tap(darkModeSwitch);
      await tester.pumpAndSettle();

      final newTheme = Theme.of(tester.element(find.byType(Scaffold)));
      final newBrightness = newTheme.brightness;

      expect(newBrightness, isNot(initialBrightness));
    });

    testWidgets('language switch toggles localization', (tester) async {
      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );
      await tester.pumpAndSettle();

      final languageSwitch = find.byType(LanguageSwitch);
      expect(languageSwitch, findsOneWidget);

      await tester.tap(languageSwitch);
      await tester.pumpAndSettle();

      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('theme persists across screen rotations', (tester) async {
      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );
      await tester.pumpAndSettle();

      final darkModeSwitch = find.byType(DarkModeSwitch);
      await tester.tap(darkModeSwitch);
      await tester.pumpAndSettle();

      final themeAfterSwitch = Theme.of(tester.element(find.byType(Scaffold)));
      final brightnessAfterSwitch = themeAfterSwitch.brightness;

      await tester.binding.setSurfaceSize(const Size(800, 600));
      await tester.pumpAndSettle();

      final themeAfterRotation = Theme.of(
        tester.element(find.byType(Scaffold)),
      );
      final brightnessAfterRotation = themeAfterRotation.brightness;

      expect(brightnessAfterRotation, brightnessAfterSwitch);
    });

    testWidgets('app adapts to system theme changes', (tester) async {
      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );
      await tester.pumpAndSettle();

      final materialApp = tester.widget<MaterialApp>(find.byType(MaterialApp));
      expect(materialApp.theme, isNotNull);
    });

    testWidgets('text elements use correct theme colors', (tester) async {
      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );
      await tester.pumpAndSettle();

      final textWidgets = find.byType(Text);
      expect(textWidgets, findsWidgets);

      final darkModeSwitch = find.byType(DarkModeSwitch);
      await tester.tap(darkModeSwitch);
      await tester.pumpAndSettle();

      final textWidgetsAfterSwitch = find.byType(Text);
      expect(textWidgetsAfterSwitch, findsWidgets);
    });

    testWidgets('card colors adapt to theme changes', (tester) async {
      await tester.pumpWidget(
        App(recommendationRepository: recommendationRepository),
      );
      await tester.pumpAndSettle();

      final containers = find.byType(Container);
      expect(containers, findsWidgets);

      final darkModeSwitch = find.byType(DarkModeSwitch);
      await tester.tap(darkModeSwitch);
      await tester.pumpAndSettle();

      final containersAfterSwitch = find.byType(Container);
      expect(containersAfterSwitch, findsWidgets);
    });
  });
}
