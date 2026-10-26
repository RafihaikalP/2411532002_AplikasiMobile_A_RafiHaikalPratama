import 'package:flutter/material.dart';

import '../db/database_helper.dart';
import '../models/app_user.dart';
import '../models/transaction_item.dart';
import '../utils/format.dart';
import 'transaction_detail_screen.dart';

/// Dashboard = gabungan UI Praktikum 1 (Greeting + Balance Card),
/// Praktikum 2 (Tombol aksi + Transaksi Terakhir) dan Praktikum 4/5 (navigasi).
/// Perbedaan: data sekarang dibaca dari SQLite, bukan data statis.
class DashboardScreen extends StatefulWidget {
  final AppUser user;
  const DashboardScreen({super.key, required this.user});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _balance = 0;
  List<TransactionItem> _recent = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final db = DatabaseHelper.instance;
    final balance = await db.getBalance(widget.user.id!);
    final recent = await db.getTransactions(widget.user.id!, limit: 5);
    if (!mounted) return;
    setState(() {
      _balance = balance;
      _recent = recent;
      _loading = false;
    });
  }

  /// Buka form tambah transaksi (named route) lalu refresh data.
  Future<void> _openAdd({String type = 'expense', String? category}) async {
    await Navigator.pushNamed(context, '/add',
        arguments: {'type': type, 'category': category});
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Keuangan'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black87,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black87,
        child: const Icon(Icons.add),
        onPressed: () => _openAdd(),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _GreetingWidget(user: widget.user),
                    const SizedBox(height: 20),
                    _BalanceCardWidget(balance: _balance),
                    const SizedBox(height: 20),
                    _buildActionButtons(),
                    const SizedBox(height: 20),
                    const Text('Transaksi Terakhir',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    _buildTransactionList(),
                  ],
                ),
              ),
            ),
    );
  }

  // ---- Tombol aksi (Row) - Praktikum 2 ----
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton(Icons.arrow_downward, 'Masuk', Colors.green,
            () => _openAdd(type: 'income')),
        _buildActionButton(Icons.arrow_upward, 'Keluar', Colors.red,
            () => _openAdd(type: 'expense')),
        _buildActionButton(Icons.swap_horiz, 'Transfer', Colors.blue,
            () => _openAdd(type: 'expense', category: 'Transfer')),
      ],
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  // ---- Daftar transaksi (Column + ListTile) - Praktikum 2 & 4 ----
  Widget _buildTransactionList() {
    if (_recent.isEmpty) {
      return const Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Center(
            child: Text('Belum ada transaksi.\nTekan tombol + untuk menambah.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey)),
          ),
        ),
      );
    }
    return Card(
      elevation: 2,
      child: Column(
        children: [
          for (var i = 0; i < _recent.length; i++) ...[
            if (i > 0) const Divider(height: 1),
            _buildTile(_recent[i]),
          ],
        ],
      ),
    );
  }

  Widget _buildTile(TransactionItem t) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: categoryColor(t),
        child: Icon(categoryIcon(t.category), color: Colors.white),
      ),
      title: Text(t.title),
      subtitle: Text(formatDateShort(t.date)),
      trailing: Text(
        formatSigned(t),
        style: TextStyle(
          color: t.isIncome ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        // NAVIGASI PUSH DENGAN DATA (Passing Data via constructor)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailScreen(
              title: t.title,
              amount: formatSigned(t),
              category: t.category,
              date: formatDate(t.date),
              isIncome: t.isIncome,
            ),
          ),
        );
      },
    );
  }
}

// ---- STATELESS WIDGET: Sapaan (Praktikum 1) ----
class _GreetingWidget extends StatelessWidget {
  final AppUser user;
  const _GreetingWidget({required this.user});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Halo, ${user.name}',
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                user.email, // informasi email dari akun yang login
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        CircleAvatar(
          radius: 24,
          backgroundColor: Colors.amber,
          child: const Icon(Icons.person, size: 30, color: Colors.white),
        ),
      ],
    );
  }
}

// ---- STATEFUL WIDGET: Kartu Saldo + toggle mata (Praktikum 1) ----
class _BalanceCardWidget extends StatefulWidget {
  final int balance;
  const _BalanceCardWidget({required this.balance});

  @override
  State<_BalanceCardWidget> createState() => _BalanceCardWidgetState();
}

class _BalanceCardWidgetState extends State<_BalanceCardWidget> {
  bool _isBalanceVisible = true;

  void _toggleVisibility() {
    setState(() {
      _isBalanceVisible = !_isBalanceVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.amber,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Saldo Utama',
                    style: TextStyle(fontSize: 16, color: Colors.black54)),
                IconButton(
                  icon: Icon(
                    _isBalanceVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black87,
                  ),
                  onPressed: _toggleVisibility,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              _isBalanceVisible ? formatRupiah(widget.balance) : 'Rp *********',
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
