/// Offer maker stats model.
class OfferMakerStats {
  /// Creates a new [OfferMakerStats] instance.
  const OfferMakerStats({
    required this.userId,
    required this.rating,
    required this.userRating,
    required this.releaseTime,
    required this.payTime,
    required this.responseTime,
    required this.totalOffersCount,
    required this.totalTransactionCount,
    required this.marketMakerTransactionCount,
    required this.marketTakerTransactionCount,
    required this.uniqueTradersCount,
    required this.marketMakerOrderTime,
    required this.marketMakerSuccessRatio,
    required this.userLastSeen,
    required this.userStatus,
  });

  /// Creates a new [OfferMakerStats] instance from a JSON map.
  factory OfferMakerStats.fromJson(Map<dynamic, dynamic> json) {
    return OfferMakerStats(
      userId: json['userId'] as String? ?? '',
      rating: (json['rating'] as num? ?? 0).toDouble(),
      userRating: (json['userRating'] as num? ?? 0).toDouble(),
      releaseTime: (json['releaseTime'] as num? ?? 0).toDouble(),
      payTime: (json['payTime'] as num? ?? 0).toDouble(),
      responseTime: (json['responseTime'] as num? ?? 0).toDouble(),
      totalOffersCount: json['totalOffersCount'] as int? ?? 0,
      totalTransactionCount: json['totalTransactionCount'] as int? ?? 0,
      marketMakerTransactionCount:
          json['marketMakerTransactionCount'] as int? ?? 0,
      marketTakerTransactionCount:
          json['marketTakerTransactionCount'] as int? ?? 0,
      uniqueTradersCount: json['uniqueTradersCount'] as int? ?? 0,
      marketMakerOrderTime: (json['marketMakerOrderTime'] as num? ?? 0)
          .toDouble(),
      marketMakerSuccessRatio: (json['marketMakerSuccessRatio'] as num? ?? 0)
          .toDouble(),
      userLastSeen: json['user_lastSeen'] as String? ?? '',
      userStatus: json['user_status'] as String? ?? '',
    );
  }

  /// The user ID.
  final String userId;

  /// The rating.
  final double rating;

  /// The user rating.
  final double userRating;

  /// The release time.
  final double releaseTime;

  /// The pay time.
  final double payTime;

  /// The response time.
  final double responseTime;

  /// The total offers count.
  final int totalOffersCount;

  /// The total transaction count.
  final int totalTransactionCount;

  /// The market maker transaction count.
  final int marketMakerTransactionCount;

  /// The market taker transaction count.
  final int marketTakerTransactionCount;

  /// The unique traders count.
  final int uniqueTradersCount;

  /// The market maker order time.
  final double marketMakerOrderTime;

  /// The market maker success ratio.
  final double marketMakerSuccessRatio;

  /// The user last seen.
  final String userLastSeen;

  /// The user status.
  final String userStatus;

  /// Converts the [OfferMakerStats] instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'rating': rating,
      'userRating': userRating,
      'releaseTime': releaseTime,
      'payTime': payTime,
      'responseTime': responseTime,
      'totalOffersCount': totalOffersCount,
      'totalTransactionCount': totalTransactionCount,
      'marketMakerTransactionCount': marketMakerTransactionCount,
      'marketTakerTransactionCount': marketTakerTransactionCount,
      'uniqueTradersCount': uniqueTradersCount,
      'marketMakerOrderTime': marketMakerOrderTime,
      'marketMakerSuccessRatio': marketMakerSuccessRatio,
      'user_lastSeen': userLastSeen,
      'user_status': userStatus,
    };
  }
}
