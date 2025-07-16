part of 'p2p_quote_cubit.dart';

enum P2PQuoteStatus { initial, loading, success, noData, error }

const defaultFiatCurrency = FiatCurrency.ves;
const defaultCryptoCurrency = CryptoCurrency.usdt;

class P2PQuoteState extends Equatable {
  const P2PQuoteState({
    this.status = P2PQuoteStatus.initial,
    this.exchangeType = ExchangeType.onRamp,
    this.fiatCurrency = defaultFiatCurrency,
    this.cryptoCurrency = defaultCryptoCurrency,
    this.recommendation,
    this.amount,
  });

  final P2PQuoteStatus status;
  final ExchangeType exchangeType;
  final FiatCurrency fiatCurrency;
  final CryptoCurrency cryptoCurrency;
  final Recommendation? recommendation;
  final num? amount;

  bool get isLoading => status == P2PQuoteStatus.loading;
  bool get isSuccess => status == P2PQuoteStatus.success;
  bool get isNoData => status == P2PQuoteStatus.noData;
  bool get isError => status == P2PQuoteStatus.error;

  P2PQuoteState copyWith({
    P2PQuoteStatus? status,
    ExchangeType? exchangeType,
    FiatCurrency? fiatCurrency,
    CryptoCurrency? cryptoCurrency,
    Recommendation? recommendation,
    num? amount,
  }) {
    return P2PQuoteState(
      status: status ?? this.status,
      exchangeType: exchangeType ?? this.exchangeType,
      fiatCurrency: fiatCurrency ?? this.fiatCurrency,
      cryptoCurrency: cryptoCurrency ?? this.cryptoCurrency,
      recommendation: recommendation ?? this.recommendation,
      amount: amount ?? this.amount,
    );
  }

  @override
  List<Object?> get props => [
    status,
    exchangeType,
    fiatCurrency,
    cryptoCurrency,
    recommendation,
    amount,
  ];

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'P2PQuoteState(status: $status, exchangeType: $exchangeType, fiatCurrency: $fiatCurrency, cryptoCurrency: $cryptoCurrency, amount: $amount)';
  }
}
