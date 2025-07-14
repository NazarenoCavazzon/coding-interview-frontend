/// Abstract class for managing currency.
sealed class Currency {
  /// The ID of the currency.
  String get id;
}

/// Crypto currency model.
enum CryptoCurrency implements Currency {
  /// USDT.
  usdt('TATUM-TRON-USDT');

  const CryptoCurrency(this.id);

  @override
  final String id;
}

/// Fiat currency model.
enum FiatCurrency implements Currency {
  /// Brazilian real.
  brl('BRL'),

  /// Colombian peso.
  cop('COP'),

  /// Peruvian sol.
  pen('PEN'),

  /// Venezuelan bolívar.
  ves('VES');

  const FiatCurrency(this.id);

  @override
  final String id;
}
