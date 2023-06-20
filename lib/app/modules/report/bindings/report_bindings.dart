import 'package:get/get.dart';
import 'package:reservation_apps/app/modules/report/controllers/reports_controller.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportController>(
      () => ReportController(),
    );
  }
}
