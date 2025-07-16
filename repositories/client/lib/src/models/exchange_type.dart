/// Exchange type model.
enum ExchangeType {
  /// Off ramp.
  offRamp(0),

  /// On ramp.
  onRamp(1);

  const ExchangeType(this.value);

  /// The value of the exchange type.
  final int value;
}
