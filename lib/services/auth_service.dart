import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/database_helper.dart';
import '../models/app_user.dart';

/// Register, login, logout. Data user disimpan di SQLite,
/// sesi login (id user) disimpan di SharedPreferences.
class AuthService {
  static const _sessionKey = 'logged_in_user_id';

  static String _generateSalt() {
    final rnd = Random.secure();
    return base64UrlEncode(List<int>.generate(16, (_) => rnd.nextInt(256)));
  }

  static String _hash(String password, String salt) =>
      sha256.convert(utf8.encode('$salt$password')).toString();

  /// Mengembalikan null jika berhasil, atau pesan error jika gagal.
  static Future<String?> register(
      String name, String email, String password) async {
    final db = DatabaseHelper.instance;
    final cleanEmail = email.trim().toLowerCase();

    if (await db.getUserByEmail(cleanEmail) != null) {
      return 'Email sudah terdaftar';
    }
    final salt = _generateSalt();
    await db.insertUser(AppUser(
      name: name.trim(),
      email: cleanEmail,
      passwordHash: _hash(password, salt),
      salt: salt,
    ));
    return null;
  }

  /// Mengembalikan null jika berhasil, atau pesan error jika gagal.
  static Future<String?> login(String email, String password) async {
    final user =
        await DatabaseHelper.instance.getUserByEmail(email.trim().toLowerCase());
    if (user == null || user.passwordHash != _hash(password, user.salt)) {
      return 'Email atau password salah';
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_sessionKey, user.id!);
    return null;
  }

  static Future<int?> currentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_sessionKey);
  }

  static Future<AppUser?> currentUser() async {
    final id = await currentUserId();
    if (id == null) return null;
    return DatabaseHelper.instance.getUserById(id);
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
  }
}
