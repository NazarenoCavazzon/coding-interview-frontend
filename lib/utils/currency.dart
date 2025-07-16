import 'package:client/client.dart';

extension CurrencyExtension on Currency {
  String get displaySymbol => switch (this) {
    CryptoCurrency.usdt => 'USDT',
    FiatCurrency.brl => 'BRL',
    FiatCurrency.cop => 'COP',
    FiatCurrency.pen => 'PEN',
    FiatCurrency.ves => 'VES',
  };

  String get assetPath => switch (this) {
    CryptoCurrency.usdt => 'assets/cripto_currencies/TATUM-TRON-USDT.png',
    FiatCurrency.brl => 'assets/fiat_currencies/BRL.png',
    FiatCurrency.cop => 'assets/fiat_currencies/COP.png',
    FiatCurrency.pen => 'assets/fiat_currencies/PEN.png',
    FiatCurrency.ves => 'assets/fiat_currencies/VES.png',
  };
}
