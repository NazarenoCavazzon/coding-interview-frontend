/// Exchange type model.
enum ExchangeType {
  /// On ramp.
  offRamp(0),

  /// Off ramp.
  onRamp(1);

  const ExchangeType(this.value);

  /// The value of the exchange type.
  final int value;
}
