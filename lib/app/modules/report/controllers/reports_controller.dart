import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reservation_apps/app/controllers/auth_controller.dart';
import 'package:reservation_apps/app/data/third_party/module_excel.dart';
import 'package:reservation_apps/app/models/transaction.dart' as t;

class ReportController extends GetxController {
  final fire = FirebaseFirestore.instance;
  final authC = Get.find<AuthController>();
  final listTransaction = <t.Transaction>[].obs;

  final f = DateFormat('yyyy-MM-dd');
  final date = DateTime.now();

  final time = ''.obs;
  @override
  void onInit() {
    doGetTransactionReport(1);
    super.onInit();
  }

  void doGetTransactionReport(int n) async {
    final thirtyDaysFromNow = f.format(date.subtract(const Duration(days: 30)));
    final sevenDaysFromNow = f.format(date.subtract(const Duration(days: 7)));
    final oneYearsFromNow = f.format(date.subtract(const Duration(days: 365)));
    await fire
        .collection('transaksi')
        .where('date',
            isGreaterThanOrEqualTo: n == 1
                ? sevenDaysFromNow
                : n == 2
                    ? thirtyDaysFromNow
                    : oneYearsFromNow)
        .where('date', isLessThanOrEqualTo: f.format(date))
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<t.Transaction> data = [];
      for (var tr in querySnapshot.docs) {
        data.add(t.Transaction.fromMap(tr.data() as Map<String, dynamic>));
      }
      listTransaction.clear();
      listTransaction.value = data;
      time.value = n == 1
          ? '$sevenDaysFromNow - ${f.format(date)}'
          : n == 2
              ? '$thirtyDaysFromNow - ${f.format(date)}'
              : '$oneYearsFromNow - ${f.format(date)}';
    });
  }

  void doCreateExcel() async {
     await ExcelModule().doCreateExcel(listTransaction, time.value);    
  }
}


