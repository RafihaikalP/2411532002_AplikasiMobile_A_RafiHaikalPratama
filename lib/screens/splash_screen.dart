import 'package:flutter/material.dart';

import '../services/auth_service.dart';

/// Mengecek apakah user sudah login (sesi tersimpan) lalu mengarahkan
/// ke halaman utama atau halaman login.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    final user = await AuthService.currentUser();
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, user == null ? '/login' : '/home');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
