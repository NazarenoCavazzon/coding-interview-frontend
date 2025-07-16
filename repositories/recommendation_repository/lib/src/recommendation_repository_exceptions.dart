/// Exception thrown when no recommendation data is found.
class NoRecommendationDataFoundException implements Exception {
  /// Creates a new [NoRecommendationDataFoundException] instance.
  const NoRecommendationDataFoundException();

  @override
  String toString() =>
      'NoRecommendationDataFoundException: No recommendation data found';
}

/// Exception thrown when recommendation data parsing fails.
class RecommendationParsingException implements Exception {
  /// Creates a new [RecommendationParsingException] instance.
  const RecommendationParsingException(this.message);

  /// The error message.
  final String message;

  @override
  String toString() => 'RecommendationParsingException: $message';
}
