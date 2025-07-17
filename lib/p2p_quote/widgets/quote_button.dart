import 'package:challenge_eldorado/p2p_quote/cubit/p2p_quote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class QuoteButton extends StatelessWidget {
  const QuoteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<P2PQuoteCubit, P2PQuoteState>(
      buildWhen: (previous, current) => previous.isSuccess != current.isSuccess,
      builder: (context, state) {
        return AppButton(
          title: t.common.exchange,
          onPressed: () {},
          isEnabled: state.isSuccess,
        );
      },
    );
  }
}
