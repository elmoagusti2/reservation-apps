import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:reservation_apps/app/controllers/auth_controller.dart';
import 'package:reservation_apps/app/models/transaction.dart' as t;

class TransactionPageController extends GetxController {
  final fire = FirebaseFirestore.instance;
  final authC = Get.find<AuthController>();

  final listTransaction = <t.Transaction>[].obs;

  Stream<QuerySnapshot> get transacStream {
    if (authC.admin.value) {
      return fire
          .collection(
            'transaksi',
          )
          .orderBy('date', descending: true)
          .snapshots(includeMetadataChanges: true);
    }
    return fire
        .collection(
          'transaksi',
        )
        .where('email', isEqualTo: authC.dataEmail.value)
        .snapshots(includeMetadataChanges: true);
  }

  @override
  void onInit() {
    super.onInit();
    doGetTransaction();
  }

  void doGetTransaction() async {
    await fire
        .collection('transaksi')
        .where('email', isEqualTo: authC.dataEmail.value)
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<t.Transaction> data = [];
      for (var tr in querySnapshot.docs) {
        data.add(t.Transaction.fromMap(tr.data() as Map<String, dynamic>));
      }
      data.sort(
        (a, b) {
          // return a.compareTo(b);
          return (a.date)!.compareTo(b.date ?? '');
        },
      );

      listTransaction.value = data;
    });
  }

  CollectionReference transactions =
      FirebaseFirestore.instance.collection('transaksi');

  Future<void> updateStats(t.Transaction transact) {
    final a =
        transact.copyWith(status: transact.status == false ? true : false);
    return transactions
        .doc(transact.id)
        .update(a.toMap())
        // ignore: avoid_print
        .then((value) => print("Updated "))
        // ignore: avoid_print
        .catchError((error) => print("Failed to update: $error"));
  }
}
