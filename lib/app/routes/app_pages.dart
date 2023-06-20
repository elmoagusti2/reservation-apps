import 'package:get/get.dart';
import 'package:reservation_apps/app/modules/report/bindings/report_bindings.dart';
import 'package:reservation_apps/app/modules/report/views/report_view.dart';

import '../modules/detailPage/bindings/detail_page_binding.dart';
import '../modules/detailPage/views/detail_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/transactionPage/bindings/transaction_page_binding.dart';
import '../modules/transactionPage/views/transaction_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PAGE,
      page: () => DetailPageView(data: Get.arguments),
      binding: DetailPageBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTION_PAGE,
      page: () => TransactionPageView(),
      binding: TransactionPageBinding(),
    ),
    GetPage(
      name: _Paths.REPORT_PAGE,
      page: () => ReportPage(),
      binding: ReportBinding(),
    ),
  ];
}
