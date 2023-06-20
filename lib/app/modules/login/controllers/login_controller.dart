// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservation_apps/app/common/constants/constants.dart';
import 'package:reservation_apps/app/controllers/auth_controller.dart';

class LoginController extends GetxController with StateMixin {
  final email = TextEditingController().obs;
  final pass = TextEditingController().obs;
  final authC = Get.find<AuthController>();

  final buttonStatus = true.obs;
  final visibilityPass = true.obs;
  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.success());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void check() async {
    buttonStatus.value = false;
    if (!RegularExpressions.email.hasMatch(email.value.toString())) {
      await authC.login(email.value.text, pass.value.text);
    }
    buttonStatus.value = true;
  }
}
