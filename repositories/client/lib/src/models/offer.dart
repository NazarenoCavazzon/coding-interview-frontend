import 'package:client/src/models/limits.dart';
import 'package:client/src/models/offer_maker_stats.dart';
import 'package:client/src/models/user.dart';
import 'package:equatable/equatable.dart';

/// Offer model.
class Offer extends Equatable {
  /// Creates a new [Offer] instance.
  const Offer({
    required this.offerId,
    required this.user,
    required this.offerStatus,
    required this.offerType,
    required this.createdAt,
    required this.description,
    required this.cryptoCurrencyId,
    required this.fiatCurrencyId,
    required this.maxLimit,
    required this.minLimit,
    required this.marketSize,
    required this.availableSize,
    required this.limits,
    required this.isDepleted,
    required this.fiatToCryptoExchangeRate,
    required this.offerMakerStats,
    required this.paymentMethods,
    required this.usdRate,
    required this.paused,
    required this.userStatus,
    required this.userLastSeen,
    required this.display,
    required this.visibility,
    required this.paymentMethodFilter,
    required this.orderRequestEnabled,
    required this.offerTransactionsEnabled,
    required this.escrow,
    required this.allowsThirdPartyPayments,
    this.chain,
  });

  /// Creates a new [Offer] instance from a JSON map.
  factory Offer.fromJson(Map<dynamic, dynamic> json) {
    return Offer(
      offerId: json['offerId'] as String? ?? '',
      user: User.fromJson(json['user'] as Map<dynamic, dynamic>),
      offerStatus: json['offerStatus'] as int? ?? 0,
      offerType: json['offerType'] as int? ?? 0,
      createdAt: json['createdAt'] as String? ?? '',
      description: json['description'] as String? ?? '',
      cryptoCurrencyId: json['cryptoCurrencyId'] as String? ?? '',
      chain: json['chain'] as String?,
      fiatCurrencyId: json['fiatCurrencyId'] as String? ?? '',
      maxLimit: json['maxLimit'] as String? ?? '',
      minLimit: json['minLimit'] as String? ?? '',
      marketSize: json['marketSize'] as String? ?? '',
      availableSize: json['availableSize'] as String? ?? '',
      limits: Limits.fromJson(json['limits'] as Map<dynamic, dynamic>),
      isDepleted: json['isDepleted'] as bool? ?? false,
      fiatToCryptoExchangeRate:
          json['fiatToCryptoExchangeRate'] as String? ?? '',
      offerMakerStats: OfferMakerStats.fromJson(
        json['offerMakerStats'] as Map<dynamic, dynamic>,
      ),
      paymentMethods: List<String>.from(
        json['paymentMethods'] as List<dynamic>,
      ),
      usdRate: json['usdRate'] as String? ?? '',
      paused: json['paused'] as bool? ?? false,
      userStatus: json['user_status'] as String? ?? '',
      userLastSeen: json['user_lastSeen'] as String? ?? '',
      display: json['display'] as bool? ?? false,
      visibility: json['visibility'] as String? ?? '',
      paymentMethodFilter: List<String>.from(
        json['paymentMethodFilter'] as List<dynamic>,
      ),
      orderRequestEnabled: json['orderRequestEnabled'] as bool? ?? false,
      offerTransactionsEnabled:
          json['offerTransactionsEnabled'] as bool? ?? false,
      escrow: json['escrow'] as String? ?? '',
      allowsThirdPartyPayments:
          json['allowsThirdPartyPayments'] as bool? ?? false,
    );
  }

  /// The offer ID.
  final String offerId;

  /// The user.
  final User user;

  /// The offer status.
  final int offerStatus;

  /// The offer type.
  final int offerType;

  /// The created at.
  final String createdAt;

  /// The description.
  final String description;

  /// The crypto currency ID.
  final String cryptoCurrencyId;

  /// The chain.
  final String? chain;

  /// The fiat currency ID.
  final String fiatCurrencyId;

  /// The max limit.
  final String maxLimit;

  /// The min limit.
  final String minLimit;

  /// The market size.
  final String marketSize;

  /// The available size.
  final String availableSize;

  /// The limits.
  final Limits limits;

  /// The is depleted.
  final bool isDepleted;

  /// The fiat to crypto exchange rate.
  final String fiatToCryptoExchangeRate;

  /// The offer maker stats.
  final OfferMakerStats offerMakerStats;

  /// The payment methods.
  final List<String> paymentMethods;

  /// The USD rate.
  final String usdRate;

  /// The paused.
  final bool paused;

  /// The user status.
  final String userStatus;

  /// The user last seen.
  final String userLastSeen;

  /// The display.
  final bool display;

  /// The visibility.
  final String visibility;

  /// The payment method filter.
  final List<String> paymentMethodFilter;

  /// The order request enabled.
  final bool orderRequestEnabled;

  /// The offer transactions enabled.
  final bool offerTransactionsEnabled;

  /// The escrow.
  final String escrow;

  /// The allows third party payments.
  final bool allowsThirdPartyPayments;

  @override
  List<Object?> get props => [
    offerId,
    user,
    offerStatus,
    offerType,
    createdAt,
    description,
    cryptoCurrencyId,
    chain,
    fiatCurrencyId,
    maxLimit,
    minLimit,
    marketSize,
    availableSize,
    limits,
    isDepleted,
    fiatToCryptoExchangeRate,
    offerMakerStats,
    paymentMethods,
    usdRate,
    paused,
    userStatus,
    userLastSeen,
    display,
    visibility,
    paymentMethodFilter,
    orderRequestEnabled,
    offerTransactionsEnabled,
    escrow,
    allowsThirdPartyPayments,
  ];
}
