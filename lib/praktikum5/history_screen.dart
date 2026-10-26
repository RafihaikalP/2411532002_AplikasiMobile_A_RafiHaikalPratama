import 'package:flutter/material.dart';
 
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
 
  // Data contoh. Ganti dengan data transaksi dari project Anda
  // (list/database) bila sudah tersedia.
  static const List<Map<String, dynamic>> _transactions = [
    {'title': 'Makan Siang', 'amount': 50000, 'isExpense': true, 'date': '26 Okt 2026'},
    {'title': 'Gaji Bulanan', 'amount': 5000000, 'isExpense': false, 'date': '25 Okt 2026'},
    {'title': 'Transport', 'amount': 20000, 'isExpense': true, 'date': '25 Okt 2026'},
    {'title': 'Belanja Buku', 'amount': 150000, 'isExpense': true, 'date': '24 Okt 2026'},
    {'title': 'Uang Saku', 'amount': 500000, 'isExpense': false, 'date': '23 Okt 2026'},
  ];
 
  String _formatRupiah(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buffer.write('.');
      buffer.write(s[i]);
    }
    return 'Rp ${buffer.toString()}';
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.white,
      ),
      body: _transactions.isEmpty
          ? const Center(child: Text('Belum ada transaksi'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _transactions.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final t = _transactions[index];
                final isExpense = t['isExpense'] as bool;
                final color = isExpense ? Colors.red : Colors.green;
 
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color.withOpacity(0.15),
                    child: Icon(
                      isExpense ? Icons.arrow_upward : Icons.arrow_downward,
                      color: color,
                    ),
                  ),
                  title: Text(t['title'] as String),
                  subtitle: Text(t['date'] as String),
                  trailing: Text(
                    '${isExpense ? '-' : '+'} ${_formatRupiah(t['amount'] as int)}',
                    style: TextStyle(
                        color: color, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
    );
  }
}
 