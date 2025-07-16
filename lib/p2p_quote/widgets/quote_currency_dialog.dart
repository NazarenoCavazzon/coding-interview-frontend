import 'package:challenge_eldorado/p2p_quote/cubit/p2p_quote_cubit.dart';
import 'package:challenge_eldorado/utils/currency.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class QuoteCurrencySelectorDialog extends StatelessWidget {
  const QuoteCurrencySelectorDialog({
    required this.value,
    required this.items,
    super.key,
  });

  final Currency value;
  final List<Currency> items;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: items.length,
      itemBuilder: (context, index) =>
          CurrencyDialogItem(currency: items[index]),
    );
  }

  static Future<void> show({
    required BuildContext context,
    required Currency value,
    required List<Currency> items,
  }) => AppDialog.show(
    context: context,
    title: value is FiatCurrency ? 'FIAT' : 'CRYPTO',
    width: 300,
    height: 350,
    child: BlocProvider.value(
      value: BlocProvider.of<P2PQuoteCubit>(context),
      child: QuoteCurrencySelectorDialog(value: value, items: items),
    ),
  );
}

class CurrencyDialogItem extends StatelessWidget {
  const CurrencyDialogItem({required this.currency, super.key});

  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final value = context.select<P2PQuoteCubit, Currency>(
      (cubit) => currency is FiatCurrency
          ? cubit.state.fiatCurrency
          : cubit.state.cryptoCurrency,
    );

    final subtitle = t.currency.description[currency.id];

    return AppDialogItem(
      title: currency.displaySymbol,
      subtitle: subtitle,
      leading: Image.asset(currency.assetPath, width: 32, height: 32),
      trailing: Transform.scale(
        scale: 1.25,
        child: Radio<Currency>(
          value: currency,
          onChanged: (_) {
            context.read<P2PQuoteCubit>().selectCurrency(currency);
            Navigator.pop(context);
          },
          groupValue: value,
          activeColor: Theme.of(context).colorScheme.primary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      onTap: () {
        context.read<P2PQuoteCubit>().selectCurrency(currency);
        Navigator.pop(context);
      },
    );
  }
}
