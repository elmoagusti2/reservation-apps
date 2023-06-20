// ignore_for_file: unnecessary_overrides, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservation_apps/app/routes/app_pages.dart';

class AuthController extends GetxController {
  final auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();
  final dataEmail = ''.obs;
  final admin = false.obs;

  Future isAdmin() async {
    await FirebaseFirestore.instance
        .collection('administrator')
        .doc(dataEmail.value)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        admin.value = true;
      }
    });
  }

  Future login(email, password) async {
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        dataEmail.value = value.user!.email!;
      });
      await isAdmin();

      // Get.off(() => const LoadingScreen());
      // await Future.delayed(
      //   const Duration(seconds: 1),
      //   () {
      Get.offNamed(AppPages.INITIAL);
      // },
      // );
      Get.snackbar('Login', 'Login Success',
          backgroundColor: const Color.fromARGB(255, 159, 208, 161),
          icon: const Icon(Icons.done));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      Get.snackbar('Error', e.code.toString(),
          backgroundColor: const Color.fromARGB(255, 214, 134, 134),
          icon: const Icon(Icons.details));
    }
  }

  Future register(email, password, address, phone) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = FirebaseAuth.instance.currentUser;
      await user?.updatePhotoURL(address).then((value) => user.updateDisplayName(phone));
      Get.offNamed(AppPages.INITIAL);
      Get.snackbar('Register', 'Register Success',
          backgroundColor: const Color.fromARGB(255, 159, 208, 161),
          icon: const Icon(Icons.done));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      Get.snackbar('Error', e.code.toString(),
          backgroundColor: const Color.fromARGB(255, 214, 134, 134),
          icon: const Icon(Icons.details));
    }
  }

  void logout() async {
    await auth.signOut();
    dataEmail.value = '';
    admin.value = false;
    Get.offNamed(Routes.LOGIN);
  }
}
