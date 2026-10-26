import 'package:flutter/material.dart';

import '../models/transaction_item.dart';

const _bulan = [
  'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
  'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
];

/// 5000000 -> "Rp 5.000.000"
String formatRupiah(int value) {
  final s = value.abs().toString();
  final buf = StringBuffer();
  for (var i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buf.write('.');
    buf.write(s[i]);
  }
  return '${value < 0 ? '-' : ''}Rp $buf';
}

/// "+ Rp 5.000.000" / "- Rp 50.000"
String formatSigned(TransactionItem t) =>
    '${t.isIncome ? '+' : '-'} ${formatRupiah(t.amount)}';

/// 13 September 2026
String formatDate(DateTime d) => '${d.day} ${_bulan[d.month - 1]} ${d.year}';

/// "Hari ini" jika tanggalnya hari ini, selain itu tanggal lengkap
String formatDateShort(DateTime d) {
  final now = DateTime.now();
  if (d.year == now.year && d.month == now.month && d.day == now.day) {
    return 'Hari ini';
  }
  return formatDate(d);
}

IconData categoryIcon(String category) {
  switch (category) {
    case 'Makanan':
      return Icons.fastfood;
    case 'Transportasi':
      return Icons.directions_car;
    case 'Hiburan':
      return Icons.movie;
    case 'Transfer':
      return Icons.swap_horiz;
    case 'Gaji':
    case 'Bonus':
      return Icons.attach_money;
    default:
      return Icons.receipt_long;
  }
}

Color categoryColor(TransactionItem t) {
  if (t.isIncome) return Colors.green;
  switch (t.category) {
    case 'Makanan':
      return Colors.orange;
    case 'Transportasi':
      return Colors.blue;
    case 'Hiburan':
      return Colors.purple;
    case 'Transfer':
      return Colors.teal;
    default:
      return Colors.redAccent;
  }
}
