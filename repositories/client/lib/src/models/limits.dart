import 'package:equatable/equatable.dart';

/// Currency limits model.
class CurrencyLimits extends Equatable {
  /// Creates a new [CurrencyLimits] instance.
  const CurrencyLimits({
    required this.maxLimit,
    required this.minLimit,
    required this.marketSize,
    required this.availableSize,
  });

  /// Creates a new [CurrencyLimits] instance from a JSON map.
  factory CurrencyLimits.fromJson(Map<dynamic, dynamic> json) {
    return CurrencyLimits(
      maxLimit: json['maxLimit'] as String? ?? '',
      minLimit: json['minLimit'] as String? ?? '',
      marketSize: json['marketSize'] as String? ?? '',
      availableSize: json['availableSize'] as String? ?? '',
    );
  }

  /// Creates a new [CurrencyLimits] instance.
  final String maxLimit;

  /// The min limit.
  final String minLimit;

  /// The market size.
  final String marketSize;

  /// The available size.
  final String availableSize;

  @override
  List<Object?> get props => [maxLimit, minLimit, marketSize, availableSize];
}

/// Limits model.
class Limits {
  /// Creates a new [Limits] instance.
  const Limits({required this.crypto, required this.fiat});

  /// Creates a new [Limits] instance from a JSON map.
  factory Limits.fromJson(Map<dynamic, dynamic> json) {
    return Limits(
      crypto: CurrencyLimits.fromJson(json['crypto'] as Map<dynamic, dynamic>),
      fiat: CurrencyLimits.fromJson(json['fiat'] as Map<dynamic, dynamic>),
    );
  }

  /// The fiat limits.
  final CurrencyLimits fiat;

  /// The crypto limits.
  final CurrencyLimits crypto;
}
