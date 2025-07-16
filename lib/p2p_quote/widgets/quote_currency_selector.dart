import 'package:challenge_eldorado/p2p_quote/widgets/quote_currency_buttons.dart';
import 'package:challenge_eldorado/p2p_quote/widgets/quote_currency_switch.dart';
import 'package:flutter/material.dart';

class QuoteCurrencySelector extends StatelessWidget {
  const QuoteCurrencySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [QuoteCurrencyButtons(), QuoteCurrencySwitch()],
    );
  }
}
