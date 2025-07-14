/// User model.
class User {
  /// Creates a new [User] instance.
  const User({required this.id, required this.username});

  /// Creates a new [User] instance from a JSON map.
  factory User.fromJson(Map<dynamic, dynamic> json) {
    return User(
      id: json['id'] as String? ?? '',
      username: json['username'] as String? ?? '',
    );
  }

  /// The user's ID.
  final String id;

  /// The user's username.
  final String username;
}
