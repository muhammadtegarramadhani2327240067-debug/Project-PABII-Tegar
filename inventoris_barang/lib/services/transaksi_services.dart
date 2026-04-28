import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventoris_barang/models/transaksi_models.dart';

class TransaksiService {
  final _col = FirebaseFirestore.instance.collection('transaksi');

  // CREATE
  Future<void> add(Transaksi t) async => await _col.add(t.toFirestore());

  // READ - stream semua transaksi milik user
  Stream<List<Transaksi>> getAll(String userId) {
    return _col
        .where('user_id', isEqualTo: userId)
        .orderBy('date', descending: true)
        .snapshots()
        .map((s) => s.docs.map((d) => Transaksi.fromFirestore(d)).toList());
  }

  // UPDATE
  Future<void> update(Transaksi t) async =>
      await _col.doc(t.id).update(t.toFirestore());

  // DELETE
  Future<void> delete(String id) async => await _col.doc(id).delete();
}
