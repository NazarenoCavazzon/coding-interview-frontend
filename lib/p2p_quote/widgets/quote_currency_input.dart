import 'package:challenge_eldorado/p2p_quote/cubit/p2p_quote_cubit.dart';
import 'package:challenge_eldorado/utils/currency.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/ui.dart';

class QuoteCurrencyInput extends StatelessWidget {
  const QuoteCurrencyInput({super.key});

  @override
  Widget build(BuildContext context) {
    final currency = context.select<P2PQuoteCubit, Currency>(
      (cubit) => cubit.state.exchangeType == ExchangeType.offRamp
          ? cubit.state.cryptoCurrency
          : cubit.state.fiatCurrency,
    );
    final amount = context.select<P2PQuoteCubit, num?>(
      (cubit) => cubit.state.amount,
    );

    return CurrencyInput(
      value: amount,
      currencySymbol: currency.displaySymbol,
      contentPadding: const EdgeInsets.symmetric(vertical: 12),
      onChanged: (value) {
        context.read<P2PQuoteCubit>().setAmount(value);
      },
    );
  }
}
