/// Exchange type model.
enum ExchangeType {
  /// Crypto to fiat.
  cryptoToFiat(0),

  /// Fiat to crypto.
  fiatToCrypto(1);

  const ExchangeType(this.value);

  /// The value of the exchange type.
  final int value;
}
