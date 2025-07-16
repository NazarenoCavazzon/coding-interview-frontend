import 'package:challenge_eldorado/p2p_quote/widgets/quote_button.dart';
import 'package:challenge_eldorado/p2p_quote/widgets/quote_currency_input.dart';
import 'package:challenge_eldorado/p2p_quote/widgets/quote_currency_selector.dart';
import 'package:challenge_eldorado/p2p_quote/widgets/quote_info_section.dart';
import 'package:flutter/material.dart';
import 'package:ui/ui.dart';

class QuoteCard extends StatelessWidget {
  const QuoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(color: AppTheme.borderSecondary, width: 2),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.2),
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          QuoteCurrencySelector(),
          SizedBox(height: 16),
          QuoteCurrencyInput(),
          SizedBox(height: 24),
          QuoteInfoSection(),
          SizedBox(height: 24),
          QuoteButton(),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
