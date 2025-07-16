import 'package:challenge_eldorado/p2p_quote/cubit/p2p_quote_cubit.dart';
import 'package:challenge_eldorado/utils/currency.dart';
import 'package:client/client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i18n/i18n.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ui/ui.dart';

class QuoteInfoSection extends StatelessWidget {
  const QuoteInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<P2PQuoteCubit, P2PQuoteState>(
      builder: (context, state) {
        final quote = state.recommendation;
        final amount = state.amount;
        final fiatCurrency = state.fiatCurrency;
        final cryptoCurrency = state.cryptoCurrency;

        final rateSymbol = fiatCurrency.displaySymbol;
        final amountSymbol = state.exchangeType == ExchangeType.onRamp
            ? cryptoCurrency.displaySymbol
            : fiatCurrency.displaySymbol;

        var exchangeRate = '?';
        var totalAmount = '?';
        var releaseTimeString = '?';

        if (quote != null && amount != null && state.isSuccess) {
          final releaseTime = quote.bySpeed.offerMakerStats.releaseTime;

          exchangeRate = quote.byPrice.fiatToCryptoExchangeRate;
          totalAmount = state.exchangeType == ExchangeType.offRamp
              ? (amount * num.parse(exchangeRate)).toStringAsFixed(2)
              : (amount / num.parse(exchangeRate)).toStringAsFixed(2);
          releaseTimeString = releaseTime < 1.0
              ? '> 1 Min'
              : '${releaseTime.floor()} min';
        } else if (state.isNoData) {
          exchangeRate = t.quote.no_quote;
          totalAmount = t.quote.no_quote;
          releaseTimeString = t.quote.no_quote;
        } else if (state.isError) {
          exchangeRate = t.common.error;
          totalAmount = t.common.error;
          releaseTimeString = t.common.error;
        }

        if (state.isLoading) {
          return Shimmer.fromColors(
            baseColor: AppTheme.getShimmerBaseColor(context),
            highlightColor: AppTheme.getShimmerHighlightColor(context),
            child: QuoteInfo(
              loading: true,
              exchangeRate: exchangeRate,
              totalAmount: totalAmount,
              releaseTimeString: releaseTimeString,
              rateSymbol: rateSymbol,
              amountSymbol: amountSymbol,
            ),
          );
        }

        return QuoteInfo(
          exchangeRate: exchangeRate,
          totalAmount: totalAmount,
          releaseTimeString: releaseTimeString,
          rateSymbol: rateSymbol,
          amountSymbol: amountSymbol,
        );
      },
    );
  }
}

class QuoteInfo extends StatelessWidget {
  const QuoteInfo({
    required this.exchangeRate,
    required this.totalAmount,
    required this.releaseTimeString,
    required this.rateSymbol,
    required this.amountSymbol,
    this.loading = false,
    super.key,
  });

  final String exchangeRate;
  final String totalAmount;
  final String releaseTimeString;
  final String rateSymbol;
  final String amountSymbol;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children:
          [
                QuoteInfoItem(
                  title: t.quote.estimated_rate,
                  value: exchangeRate,
                  suffix: rateSymbol,
                ),
                QuoteInfoItem(
                  title: t.quote.you_will_receive,
                  value: totalAmount,
                  suffix: amountSymbol,
                ),
                QuoteInfoItem(
                  title: t.quote.estimated_time,
                  value: releaseTimeString,
                  suffix: 'min',
                ),
              ]
              .map(
                (child) => ColoredBox(
                  color: Theme.of(context).cardColor,
                  child: child,
                ),
              )
              .toList(),
    );
  }
}

class QuoteInfoItem extends StatelessWidget {
  const QuoteInfoItem({
    required this.title,
    required this.value,
    required this.suffix,
    super.key,
  });

  final String title;
  final String value;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    final isSuccess = context.read<P2PQuoteCubit>().state.isSuccess;

    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(height: 1),
        ),
        const Spacer(),
        Text(
          isSuccess ? '≈ $value ' : value,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontWeight: isSuccess ? FontWeight.w500 : FontWeight.w400,
            height: 1,
          ),
        ),
        Text(
          isSuccess ? suffix : '',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1),
        ),
      ],
    );
  }
}
