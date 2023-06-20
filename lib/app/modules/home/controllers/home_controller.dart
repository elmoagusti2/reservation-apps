import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:reservation_apps/app/controllers/auth_controller.dart';
import 'package:reservation_apps/app/models/field_soccer/field_soccer.dart';

class HomeController extends GetxController {
  final fire = FirebaseFirestore.instance;
  final soccerField = <FieldSoccer>[].obs;
  final authC = Get.find<AuthController>();
  final RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    doGetfieldSoccer();
  }

  void doGetfieldSoccer() async {
    await fire.collection('lapangan').get().then((QuerySnapshot querySnapshot) {
      List<FieldSoccer> data = [];
      for (var doc in querySnapshot.docs) {
        data.add(FieldSoccer.fromJson(doc.data() as Map<String, dynamic>)
            .copyWith(id: doc.id));
      }
      soccerField.value = data;
    });
  }
}
