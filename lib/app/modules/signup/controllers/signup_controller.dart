// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservation_apps/app/common/constants/constants.dart';
import 'package:reservation_apps/app/controllers/auth_controller.dart';

class SignupController extends GetxController {
  final authC = Get.find<AuthController>();

  final email = TextEditingController().obs;
  final password = TextEditingController().obs;
  final confirmPassword = TextEditingController().obs;
  final address = TextEditingController().obs;
  final phoneNumber = TextEditingController().obs;

  final visibilityPass = true.obs;
  final visibilityPassConfirm = true.obs;
  @override
  void onInit() {
    super.onInit();
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
    if (!RegularExpressions.email.hasMatch(email.value.toString()) &&
        RegularExpressions.password.hasMatch(password.value.toString()) &&
        password.value.text == confirmPassword.value.text) {
      await authC.register(
        email.value.text,
        password.value.text,
        address.value.text,
        phoneNumber.value.text,
      );
    }
  }
}
