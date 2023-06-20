import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:reservation_apps/app/common/constants/constants.dart';
import 'package:reservation_apps/app/common/constants/themes.dart';
import 'package:reservation_apps/app/common/helper/common_util.dart';
import 'package:reservation_apps/app/controllers/auth_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final authC = Get.put(AuthController());

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: authC.streamAuthStatus,
        builder: (context, snapshot) {
          authC.dataEmail.value = snapshot.data?.email ?? '';
          if (authC.dataEmail.value != "") {
            authC.isAdmin();
          }
          if (snapshot.connectionState == ConnectionState.active) {
            return GetMaterialApp(
              theme: mainTheme,
              title: "Application",
              initialRoute: CommonUtil.falsyChecker(snapshot.data)
                  ? Routes.LOGIN
                  : Routes.HOME,
              getPages: AppPages.routes,
              debugShowCheckedModeBanner: false,
            );
          }
          return const MaterialApp(home: LoadingScreen());
        });
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(LottieAssetConstants.lottie.loadingSoccer,
                height: 250),
            const Text(
              'Loading',
              style: TextStyle(
                  color: Color.fromARGB(255, 184, 6, 6),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
