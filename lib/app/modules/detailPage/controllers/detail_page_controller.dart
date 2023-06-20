import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reservation_apps/app/controllers/auth_controller.dart';
import 'package:reservation_apps/app/models/field_soccer/field_soccer.dart';
import 'package:reservation_apps/app/models/field_soccer/price.dart';
import 'package:reservation_apps/app/models/transaction.dart' as tr;

final now = DateTime.now();

class DetailPageController extends GetxController {
  final authC = Get.find<AuthController>();
  final fire = FirebaseFirestore.instance;

  final datePick = DateTime(now.year, now.month, now.day).obs;
  final dateUnavailable = <DateAvail>[].obs;

  final weekEnd = false.obs;

  final rangeStartTime = 0.obs;
  final timeOrder = 0.obs;
  final totalOrder = 0.obs;

  final status = false.obs;
  final invoice = "".obs;
  final f = DateFormat('yyyy-MM-dd');

  final ff = DateFormat('yyMMdd');

  @override
  void onInit() {
    super.onInit();
    initial();
    if (datePick.value.weekday == 6 || datePick.value.weekday == 7) {
      weekEnd.value = true;
    }
  }

  void initial() {
    dateUnavailable.value = [
      DateAvail(date: '7:00', avail: true),
      DateAvail(date: '8:00', avail: true),
      DateAvail(date: '9:00', avail: true),
      DateAvail(date: '10:00', avail: true),
      DateAvail(date: '11:00', avail: true),
      DateAvail(date: '12:00', avail: true),
      DateAvail(date: '13:00', avail: true),
      DateAvail(date: '14:00', avail: true),
      DateAvail(date: '15:00', avail: true),
      DateAvail(date: '16:00', avail: true),
      DateAvail(date: '17:00', avail: true),
      DateAvail(date: '18:00', avail: true),
      DateAvail(date: '19:00', avail: true),
      DateAvail(date: '20:00', avail: true),
      DateAvail(date: '21:00', avail: true),
      DateAvail(date: '22:00', avail: true),
      DateAvail(date: '23:00', avail: true),
    ];
    invoice.value = "${ff.format(datePick.value)}${Random().nextInt(1000)}";
  }

  void updateDate(date, fieldId) async {
    initial();
    await fire
        .collection('transaksi')
        .where('date', isEqualTo: date)
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var data in querySnapshot.docs) {
        if (data['status'] == true && data['field_id'] == fieldId) {
          for (var i = 0; i < data['duration']; i++) {
            dateUnavailable[dateUnavailable.indexWhere((element) =>
                    element.date == '${int.parse(data['time']) + i}:00')] =
                DateAvail(
                    date: '${int.parse(data['time']) + i}:00', avail: false);
          }
        }
      }
    });
  }

  void validateOrder(FieldSoccer fieldSoccer) {
    bool isValidate = false;
    List<bool> validate = [];

    //VALIDASI WAKTU TERSEDIA
    for (var i = 0; i < timeOrder.value; i++) {
      // print(rangeStartTime.value + i );
      var contain = dateUnavailable.where((element) =>
          element.date == "${rangeStartTime.value + i}:00" &&
          element.avail == true);
      if (contain.isEmpty) {
        // print("sudah penuh");
        validate.add(false);
      } else {
        // print("kosong");
        validate.add(true);
      }
    }
    //validasi waktu tambahan
    var contain = validate.where((element) => element == false);
    if (contain.isEmpty) {
      // print("sudah penuh");
      isValidate = true;
    } else {
      // print("kosong");
      isValidate = false;
    }

    final data = tr.Transaction(
      date: f.format(datePick.value).toString(),
      time: rangeStartTime.value.toString(),
      duration: timeOrder.value,
      price: totalOrder.value,
      email: authC.dataEmail.value,
      name: authC.dataEmail.value,
      fieldId: fieldSoccer.id,
      fieldName: fieldSoccer.nama,
      invoice: invoice.value,
      id: "",
      status: false,
    );

    if (isValidate) {
      FirebaseFirestore.instance.collection('transaksi').add(data.toMap());
      status.value = true;
    } else {}
  }

  void validatePrice(Price price) {
    if (weekEnd.value == false) {
      switch (rangeStartTime.value) {
        case 7:
          totalOrder.value = (price.weekday7sd13! * timeOrder.value);
          break;
        case 8:
          totalOrder.value = (price.weekday7sd13! * timeOrder.value);
          break;
        case 9:
          totalOrder.value = (price.weekday7sd13! * timeOrder.value);
          break;
        case 10:
          totalOrder.value = (price.weekday7sd13! * timeOrder.value);
          break;
        case 11:
          totalOrder.value = (price.weekday7sd13! * timeOrder.value);
          break;
        case 12:
          totalOrder.value = (price.weekday7sd13! * timeOrder.value);
          break;
        case 13:
          totalOrder.value = (price.weekday7sd13! * timeOrder.value);
          break;
        case 14:
          totalOrder.value = (price.weekday14sd18! * timeOrder.value);
          break;
        case 15:
          totalOrder.value = (price.weekday14sd18! * timeOrder.value);
          break;
        case 16:
          totalOrder.value = (price.weekday14sd18! * timeOrder.value);
          break;
        case 17:
          totalOrder.value = (price.weekday14sd18! * timeOrder.value);
          break;
        case 18:
          totalOrder.value = (price.weekday18sd00! * timeOrder.value);
          break;
        case 19:
          totalOrder.value = (price.weekday18sd00! * timeOrder.value);
          break;
        case 20:
          totalOrder.value = (price.weekday18sd00! * timeOrder.value);
          break;
        case 21:
          totalOrder.value = (price.weekday18sd00! * timeOrder.value);
          break;
        case 22:
          totalOrder.value = (price.weekday18sd00! * timeOrder.value);
          break;
        case 23:
          totalOrder.value = (price.weekday18sd00! * timeOrder.value);
          break;
        default:
          totalOrder.value = 0;
      }
    } else {
      switch (rangeStartTime.value) {
        case 7:
          totalOrder.value = (price.weekend7sd13! * timeOrder.value);
          break;
        case 8:
          totalOrder.value = (price.weekend7sd13! * timeOrder.value);
          break;
        case 9:
          totalOrder.value = (price.weekend7sd13! * timeOrder.value);
          break;
        case 10:
          totalOrder.value = (price.weekday7sd13! * timeOrder.value);
          break;
        case 11:
          totalOrder.value = (price.weekend7sd13! * timeOrder.value);
          break;
        case 12:
          totalOrder.value = (price.weekend7sd13! * timeOrder.value);
          break;
        case 13:
          totalOrder.value = (price.weekend7sd13! * timeOrder.value);
          break;
        case 14:
          totalOrder.value = (price.weekend14sd18! * timeOrder.value);
          break;
        case 15:
          totalOrder.value = (price.weekend14sd18! * timeOrder.value);
          break;
        case 16:
          totalOrder.value = (price.weekend14sd18! * timeOrder.value);
          break;
        case 17:
          totalOrder.value = (price.weekend14sd18! * timeOrder.value);
          break;
        case 18:
          totalOrder.value = (price.weekend18sd00! * timeOrder.value);
          break;
        case 19:
          totalOrder.value = (price.weekend18sd00! * timeOrder.value);
          break;
        case 20:
          totalOrder.value = (price.weekend18sd00! * timeOrder.value);
          break;
        case 21:
          totalOrder.value = (price.weekend18sd00! * timeOrder.value);
          break;
        case 22:
          totalOrder.value = (price.weekend18sd00! * timeOrder.value);
          break;
        case 23:
          totalOrder.value = (price.weekend18sd00! * timeOrder.value);
          break;
        default:
          totalOrder.value = 0;
      }
    }
  }
}

class DateAvail {
  late String date;
  late bool avail;
  DateAvail({required this.date, required this.avail});
}
