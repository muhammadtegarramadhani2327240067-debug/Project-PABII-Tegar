import 'package:cloud_firestore/cloud_firestore.dart';

class Transaksi {
  String? id;
  String title;
  double amount;
  String type; // 'pemasukan' atau 'pengeluaran'
  DateTime date;
  String? imageBase64;
  String userId;
  DateTime createdAt;

  Transaksi({
    this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.date,
    this.imageBase64,
    required this.userId,
    required this.createdAt,
  });

  factory Transaksi.fromFirestore(DocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return Transaksi(
      id: doc.id,
      title: d['title'] ?? '',
      amount: (d['amount'] ?? 0).toDouble(),
      type: d['type'] ?? 'pengeluaran',
      date: (d['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      imageBase64: d['image_base64'],
      userId: d['user_id'] ?? '',
      createdAt: (d['created_at'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() => {
    'title': title,
    'amount': amount,
    'type': type,
    'date': Timestamp.fromDate(date),
    'image_base64': imageBase64,
    'user_id': userId,
    'created_at': Timestamp.fromDate(createdAt),
  };

  bool get isPemasukan => type == 'pemasukan';
}
