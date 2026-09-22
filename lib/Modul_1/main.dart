import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// WIDGET UTAMA
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      home: const DashboardScreen(),
    );
  }
}

// HALAMAN UTAMA
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Praktikum 1: Widgets'),
        backgroundColor: Colors.blue,
      ),

      body: const Padding(
        padding: EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Memanggil StatelessWidget
            GreetingWidget(),

            // Memberikan jarak
            SizedBox(height: 20),

            // Memanggil StatefulWidget
            BalanceCardWidget(),
          ],
        ),
      ),
    );
  }
}

// STATELESS WIDGET
// Widget sapaan pengguna

class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // Ikon profil
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.blueAccent,

          child: Icon(
            Icons.person,
            size: 30,
            color: Colors.white,
          ),
        ),

        SizedBox(width: 12),

        // Teks sapaan
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, Budi',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              'Selamat datang kembali!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// STATEFUL WIDGET
// Kartu saldo dengan tombol tampil/sembunyikan saldo
class BalanceCardWidget extends StatefulWidget {
  const BalanceCardWidget({super.key});

  @override
  State<BalanceCardWidget> createState() =>
      _BalanceCardWidgetState();
}

class _BalanceCardWidgetState
    extends State<BalanceCardWidget> {

  // Menyimpan kondisi tampilan saldo
  bool _isBalanceVisible = true;

  // Fungsi untuk mengubah tampilan saldo
  void _toggleVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),

      // Warna kartu
      color: Colors.blueAccent,

      child: Padding(
        padding: const EdgeInsets.all(20.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Baris Saldo Utama dan tombol mata
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,

              children: [
                const Text(
                  'Saldo Utama',

                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),

                // Tombol mata
                IconButton(
                  icon: Icon(
                    _isBalanceVisible
                        ? Icons.visibility
                        : Icons.visibility_off,

                    color: Colors.white,
                  ),

                  onPressed: _toggleVisibility,
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Menampilkan saldo
            Text(
              _isBalanceVisible
                  ? 'Rp 5.000.000'
                  : 'Rp *********',

              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}