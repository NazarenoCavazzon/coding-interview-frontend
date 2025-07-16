import 'package:challenge_eldorado/p2p_quote/cubit/p2p_quote_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class QuoteButton extends StatelessWidget {
  const QuoteButton({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.select<P2PQuoteCubit, P2PQuoteState>(
      (cubit) => cubit.state,
    );

    return AppButton(
      title: 'Cambiar',
      onPressed: () {},
      isEnabled: state.isSuccess,
    );
  }
}
