import 'package:flutter/material.dart';
 
class ProfileScreen extends StatelessWidget {
  final String email;
  const ProfileScreen({super.key, required this.email});
 
  // Nama diambil dari bagian sebelum '@' pada email
  String get _name {
    final raw = email.split('@').first;
    return raw.isEmpty ? 'Pengguna' : raw[0].toUpperCase() + raw.substring(1);
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 56,
                backgroundColor: Colors.amber[200],
                child: const Icon(Icons.person, size: 64, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Text(
                _name,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(email, style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  onPressed: () {
                    // Kembali ke login dan hapus semua halaman sebelumnya
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/login', (route) => false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}