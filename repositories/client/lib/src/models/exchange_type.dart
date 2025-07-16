/// Exchange type model.
enum ExchangeType {
  /// User exchanges crypto for fiat.
  offRamp(0),

  /// User exchanges fiat for crypto.
  onRamp(1);

  const ExchangeType(this.value);

  /// The value of the exchange type.
  final int value;
}
