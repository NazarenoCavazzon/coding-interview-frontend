import 'package:client/src/models/offer.dart';
import 'package:equatable/equatable.dart';

/// Recommendation data model.
class Recommendation extends Equatable {
  /// Creates a new [Recommendation] instance.
  const Recommendation({
    required this.byPrice,
    required this.bySpeed,
    required this.byReputation,
  });

  /// Creates a new [Recommendation] instance from a JSON map.
  factory Recommendation.fromJson(Map<dynamic, dynamic> json) {
    final data = (json['data'] as Map<dynamic, dynamic>)
        .cast<String, dynamic>();

    return Recommendation(
      byPrice: Offer.fromJson(data['byPrice'] as Map<dynamic, dynamic>? ?? {}),
      bySpeed: Offer.fromJson(data['bySpeed'] as Map<dynamic, dynamic>? ?? {}),
      byReputation: Offer.fromJson(
        data['byReputation'] as Map<dynamic, dynamic>? ?? {},
      ),
    );
  }

  /// The offer by price.
  final Offer byPrice;

  /// The offer by speed.
  final Offer bySpeed;

  /// The offer by reputation.
  final Offer byReputation;

  @override
  List<Object?> get props => [byPrice, bySpeed, byReputation];
}
