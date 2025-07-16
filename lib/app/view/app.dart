import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:challenge_eldorado/p2p_quote/p2p_quote.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:recommendation_repository/recommendation_repository.dart';
import 'package:ui/ui.dart';

class App extends StatelessWidget {
  const App({required this.client, super.key});

  final ElDoradoApiClient client;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => RecommendationRepository(client: client),
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: AppTheme.lightTheme,
      builder: (context, myTheme) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Challenge Eldorado',
          theme: myTheme,
          locale: TranslationProvider.of(context).flutterLocale,
          supportedLocales: AppLocaleUtils.supportedLocales,
          localizationsDelegates: GlobalMaterialLocalizations.delegates,
          home: const P2PQuotePage(),
        );
      },
    );
  }
}
