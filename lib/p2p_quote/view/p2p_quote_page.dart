import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:challenge_eldorado/p2p_quote/cubit/p2p_quote_cubit.dart';
import 'package:challenge_eldorado/p2p_quote/widgets/background.dart';
import 'package:challenge_eldorado/p2p_quote/widgets/quote_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendation_repository/recommendation_repository.dart';
import 'package:ui/ui.dart';

class P2PQuotePage extends StatelessWidget {
  const P2PQuotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => P2PQuoteCubit(
        recommendationRepository: context.read<RecommendationRepository>(),
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: ThemeSwitchingArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: const Stack(
              alignment: Alignment.center,
              children: [
                Background(),
                QuoteCard(),
                DarkModeSwitch(),
                LanguageSwitch(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
