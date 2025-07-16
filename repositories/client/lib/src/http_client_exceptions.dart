/// Exception thrown when an HTTP client error occurs.
class HttpClientException implements Exception {
  /// Creates a new [HttpClientException] instance.
  const HttpClientException(this.message, this.statusCode);

  /// The error message.
  final String message;

  /// The HTTP status code.
  final int statusCode;

  /// Returns a string representation of the [HttpClientException].
  @override
  String toString() => 'HttpClientException: $message (Status: $statusCode)';
}
