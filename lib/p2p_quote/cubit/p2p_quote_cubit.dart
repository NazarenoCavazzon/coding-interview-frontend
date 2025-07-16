import 'dart:async';

import 'package:client/client.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recommendation_repository/recommendation_repository.dart';

part 'p2p_quote_state.dart';

class P2PQuoteCubit extends Cubit<P2PQuoteState> {
  P2PQuoteCubit({required this.recommendationRepository})
    : super(const P2PQuoteState());

  final RecommendationRepository recommendationRepository;
  Timer? _debounceTimer;

  void switchExchangeDirection() {
    final newDirection = state.exchangeType == ExchangeType.offRamp
        ? ExchangeType.onRamp
        : ExchangeType.offRamp;
    emit(state.copyWith(exchangeType: newDirection));
    getQuote();
  }

  Future<void> getQuote() async {
    if (state.amount == null) return;

    emit(state.copyWith(status: P2PQuoteStatus.loading));

    try {
      final quote = await recommendationRepository.getRecommendations(
        fiatCurrencyId: state.fiatCurrency.id,
        cryptoCurrencyId: state.cryptoCurrency.id,
        exchangeType: state.exchangeType,
        amount: state.amount!,
        amountCurrencyId: state.fiatCurrency.id,
      );

      emit(
        state.copyWith(status: P2PQuoteStatus.success, recommendation: quote),
      );
    } on NoRecommendationDataFoundException {
      emit(state.copyWith(status: P2PQuoteStatus.noData));
    } on RecommendationParsingException {
      emit(state.copyWith(status: P2PQuoteStatus.error));
    } catch (e) {
      emit(state.copyWith(status: P2PQuoteStatus.error));
    }
  }

  void selectCurrency(Currency currency) {
    if (currency is FiatCurrency) {
      emit(state.copyWith(fiatCurrency: currency));
    } else if (currency is CryptoCurrency) {
      emit(state.copyWith(cryptoCurrency: currency));
    }

    getQuote();
  }

  void setAmount(num amount) {
    if (amount <= 0 || state.amount == amount) return;

    emit(state.copyWith(amount: amount));
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), getQuote);
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
