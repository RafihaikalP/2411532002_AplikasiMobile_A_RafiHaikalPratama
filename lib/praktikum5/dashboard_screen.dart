import 'package:flutter/material.dart';

// Halaman Beranda — dibuat mandiri khusus Praktikum 5
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Keuangan'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
        onPressed: () {
          // Memanggil rute yang sudah didaftarkan di main.dart
          Navigator.pushNamed(context, '/add');
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Halo, Budi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildBalanceCard(),
            const SizedBox(height: 20),
            const Text('Transaksi Terakhir',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Card(
      elevation: 4,
      color: Colors.amber[700],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saldo Utama',
                style: TextStyle(fontSize: 16, color: Colors.white70)),
            SizedBox(height: 8),
            Text('Rp 5.000.000',
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    return const Card(
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Icon(Icons.fastfood, color: Colors.white)),
            title: Text('Makan Siang'),
            subtitle: Text('Hari ini'),
            trailing: Text('- Rp 50.000',
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold)),
          ),
          Divider(height: 1),
          ListTile(
            leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.attach_money, color: Colors.white)),
            title: Text('Gaji Bulanan'),
            subtitle: Text('1 September 2026'),
            trailing: Text('+ Rp 5.000.000',
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}