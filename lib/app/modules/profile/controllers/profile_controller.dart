import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservation_apps/app/controllers/auth_controller.dart';

class ProfileController extends GetxController {
  final authC = Get.find<AuthController>();
  final email = TextEditingController().obs;


  Future<void> createAdmin() {
    return FirebaseFirestore.instance
        .runTransaction((transaction) async {})
        // ignore: avoid_print
        .then((value) => print("Follower count updated to $value"))
        .catchError(
            // ignore: avoid_print
            (error) => print("Failed to update user followers: $error"));
  }

  void create() async {
   try {
      await FirebaseFirestore.instance
        .collection('administrator')
        .doc(email.value.text)
        .set({"email": email.value.text});

      Get.back();

   } catch (e) {
    //  print(e);
   }
  }
}
