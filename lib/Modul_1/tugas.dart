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
      title: 'Tugas Praktikum',

      theme: ThemeData(
        primarySwatch: Colors.teal,
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
        title: const Text('Tugas Praktikum 1'),
        backgroundColor: Colors.teal,
      ),

      body: const Padding(
        padding: EdgeInsets.all(16.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Widget sapaan
            GreetingWidget(),

            SizedBox(height: 20),

            // Widget kartu saldo
            BalanceCardWidget(),
          ],
        ),
      ),
    );
  }
}

// STATELESS WIDGET
class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // Ikon profil
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.teal,

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
class BalanceCardWidget extends StatefulWidget {
  const BalanceCardWidget({super.key});

  @override
  State<BalanceCardWidget> createState() =>
      _BalanceCardWidgetState();
}

class _BalanceCardWidgetState
    extends State<BalanceCardWidget> {

  // Menyimpan kondisi saldo
  bool _isBalanceVisible = true;

  // Fungsi untuk menampilkan atau menyembunyikan saldo
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

      // TUGAS 1
      // Mengubah warna kartu menjadi hijau emerald/teal
      color: Colors.teal,

      child: Padding(
        padding: const EdgeInsets.all(20.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            // Baris saldo utama dan tombol mata
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

                // Tombol tampil/sembunyikan saldo
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

            // Nominal saldo
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

            // TUGAS 2
            // Menambahkan nomor rekening
            const SizedBox(height: 8),

            const Text(
              'No. Rekening: 1234-5678',

              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}