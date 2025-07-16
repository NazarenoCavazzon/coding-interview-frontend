import 'package:challenge_eldorado/p2p_quote/cubit/p2p_quote_cubit.dart';
import 'package:challenge_eldorado/p2p_quote/widgets/quote_currency_bottom_sheet.dart';
import 'package:challenge_eldorado/p2p_quote/widgets/quote_currency_dialog.dart';
import 'package:challenge_eldorado/utils/currency.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:ui/ui.dart';

class QuoteCurrencyButtons extends StatelessWidget {
  const QuoteCurrencyButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [SelectedCurrencies(), _TopLeftText(), _TopRightText()],
    );
  }
}

// I prefered to repeat the code twice here :)
class _TopLeftText extends StatelessWidget {
  const _TopLeftText();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 24,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        color: Theme.of(context).cardColor,
        child: Text(
          t.common.have.toUpperCase(),
          style: AppTheme.bodySmall.copyWith(
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
      ),
    );
  }
}

class _TopRightText extends StatelessWidget {
  const _TopRightText();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 24,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        color: Theme.of(context).cardColor,
        child: Text(
          t.common.want.toUpperCase(),
          style: AppTheme.bodySmall.copyWith(
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
      ),
    );
  }
}

class SelectedCurrencies extends StatelessWidget {
  const SelectedCurrencies({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: BlocBuilder<P2PQuoteCubit, P2PQuoteState>(
        buildWhen: (previous, current) =>
            previous.fiatCurrency != current.fiatCurrency ||
            previous.cryptoCurrency != current.cryptoCurrency ||
            previous.exchangeType != current.exchangeType,
        builder: (context, state) {
          final (
            Currency firstCurrency,
            Currency secondCurrency,
          ) = state.exchangeType == ExchangeType.onRamp
              ? (state.fiatCurrency, state.cryptoCurrency)
              : (state.cryptoCurrency, state.fiatCurrency);

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectedCurrency(currency: firstCurrency),
              SelectedCurrency(currency: secondCurrency),
            ],
          );
        },
      ),
    );
  }
}

class SelectedCurrency extends StatelessWidget {
  const SelectedCurrency({required this.currency, super.key});

  final Currency currency;

  @override
  Widget build(BuildContext context) {
    final showBottomSheet = isPhone(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (showBottomSheet) {
            _showBottomSheet(context);
            return;
          }
          _showDialog(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Image.asset(currency.assetPath, width: 24, height: 24),
              const SizedBox(width: 8),
              Text(
                currency.displaySymbol,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(
                width: 16,
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showBottomSheet(BuildContext context) {
    return QuoteCurrencySelectorBottomSheet.show(
      context: context,
      value: currency,
      items: currency is FiatCurrency
          ? FiatCurrency.values
          : CryptoCurrency.values,
    );
  }

  Future<void> _showDialog(BuildContext context) {
    return QuoteCurrencySelectorDialog.show(
      context: context,
      value: currency,
      items: currency is FiatCurrency
          ? FiatCurrency.values
          : CryptoCurrency.values,
    );
  }
}
