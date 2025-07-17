/// Exception thrown when an HTTP client error occurs.
class ElDoradoApiClientException implements Exception {
  /// Creates a new [ElDoradoApiClientException] instance.
  const ElDoradoApiClientException(this.message, this.statusCode);

  /// The error message.
  final String message;

  /// The HTTP status code.
  final int statusCode;

  /// Returns a string representation of the [ElDoradoApiClientException].
  @override
  String toString() => 'HttpClientException: $message (Status: $statusCode)';
}
