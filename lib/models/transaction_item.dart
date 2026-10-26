class TransactionItem {
  final int? id;
  final int userId;
  final String title;
  final int amount; // selalu positif
  final String type; // 'income' | 'expense'
  final String category;
  final DateTime date;

  const TransactionItem({
    this.id,
    required this.userId,
    required this.title,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
  });

  bool get isIncome => type == 'income';

  Map<String, Object?> toMap() => {
        'id': id,
        'user_id': userId,
        'title': title,
        'amount': amount,
        'type': type,
        'category': category,
        'date': date.toIso8601String(),
      };

  factory TransactionItem.fromMap(Map<String, Object?> m) => TransactionItem(
        id: m['id'] as int?,
        userId: m['user_id'] as int,
        title: m['title'] as String,
        amount: m['amount'] as int,
        type: m['type'] as String,
        category: m['category'] as String,
        date: DateTime.parse(m['date'] as String),
      );
}
