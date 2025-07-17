import 'package:challenge_eldorado/p2p_quote/p2p_quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:recommendation_repository/recommendation_repository.dart';
import 'package:ui/ui.dart';

class App extends StatelessWidget {
  const App({
    required RecommendationRepository recommendationRepository,
    super.key,
  }) : _recommendationRepository = recommendationRepository;

  final RecommendationRepository _recommendationRepository;

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(
      child: RepositoryProvider.value(
        value: _recommendationRepository,
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Challenge El Dorado',
            theme: theme,
            locale: TranslationProvider.of(context).flutterLocale,
            supportedLocales: AppLocaleUtils.supportedLocales,
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            home: const P2PQuotePage(),
          );
        },
      ),
    );
  }
}
