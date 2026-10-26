class AppUser {
  final int? id;
  final String name;
  final String email;
  final String passwordHash;
  final String salt;

  const AppUser({
    this.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    required this.salt,
  });

  Map<String, Object?> toMap() => {
        'id': id,
        'name': name,
        'email': email,
        'password_hash': passwordHash,
        'salt': salt,
        'created_at': DateTime.now().toIso8601String(),
      };

  factory AppUser.fromMap(Map<String, Object?> m) => AppUser(
        id: m['id'] as int?,
        name: m['name'] as String,
        email: m['email'] as String,
        passwordHash: m['password_hash'] as String,
        salt: m['salt'] as String,
      );
}
