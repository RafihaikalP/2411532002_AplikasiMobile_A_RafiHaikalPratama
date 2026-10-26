import 'package:flutter/material.dart';

import '../db/database_helper.dart';
import '../models/app_user.dart';
import '../models/transaction_item.dart';
import '../utils/format.dart';
import 'transaction_detail_screen.dart';

/// Halaman Riwayat (latihan Praktikum 5): semua transaksi dari SQLite.
/// Geser item ke kiri/kanan untuk menghapus.
class HistoryScreen extends StatefulWidget {
  final AppUser user;
  const HistoryScreen({super.key, required this.user});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<TransactionItem> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final items = await DatabaseHelper.instance.getTransactions(widget.user.id!);
    if (!mounted) return;
    setState(() {
      _items = items;
      _loading = false;
    });
  }

  Future<void> _delete(TransactionItem t) async {
    await DatabaseHelper.instance.deleteTransaction(t.id!);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('"${t.title}" dihapus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black87,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? const Center(
                  child: Text('Belum ada transaksi',
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final t = _items[index];
                    return Dismissible(
                      key: ValueKey(t.id),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) {
                        setState(() => _items.removeAt(index));
                        _delete(t);
                      },
                      child: Card(
                        elevation: 2,
                        margin: EdgeInsets.zero,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: categoryColor(t),
                            child: Icon(categoryIcon(t.category),
                                color: Colors.white),
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
                          onTap: () => Navigator.push(
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
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
