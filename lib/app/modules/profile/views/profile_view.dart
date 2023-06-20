import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reservation_apps/app/common/constants/constants.dart';
import 'package:reservation_apps/app/controllers/auth_controller.dart';
import 'package:reservation_apps/app/modules/widgets/button_widget.dart';
import 'package:reservation_apps/app/modules/widgets/container_widget.dart';
import 'package:reservation_apps/app/modules/widgets/separator_widget.dart';
import 'package:reservation_apps/app/modules/widgets/typography.dart';
import 'package:reservation_apps/app/routes/app_pages.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);

  final profileC = Get.put(ProfileController());
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(child: Heading.h4Default(('Profile'))),
          SeparatorWidget.height24(),
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.network(
              'https://img.freepik.com/free-vector/isolated-young-handsome-man-different-poses-white-background-illustration_632498-859.jpg?w=900&t=st=1679500948~exp=1679501548~hmac=c843147f7d4bd9e51757361d932d16960447a0a2ea08e36f207a81c3ecf1d757',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
          ),
          SeparatorWidget.height10(),
          StreamBuilder(
            stream: authC.streamAuthStatus,
            builder: (context, snapshot) {
              return Column(
                children: [
                  Center(child: Heading.h4Default(snapshot.data?.email ?? '')),
                  Center(
                      child: Heading.h6XSmall(
                    snapshot.data?.displayName ?? '',
                    color: ConstColors.dark40,
                  )),
                  Center(
                      child: Heading.h6XSmall(
                    snapshot.data?.photoURL ?? '',
                    color: ConstColors.dark40,
                  )),
                ],
              );
            },
          ),
          SeparatorWidget.height32(),
          if (authC.admin.value)
            ContainerWidget.roundedGrey(
                width: Get.width,
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes.REPORT_PAGE);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.data_thresholding_outlined),
                      SeparatorWidget.width12(),
                      const Text("Report")
                    ],
                  ),
                )),
          SeparatorWidget.height16(),
          if (authC.admin.value)
            ContainerWidget.roundedGrey(
                width: Get.width,
                InkWell(
                  onTap: () {
                    Get.defaultDialog(
                        title: 'Add Email SuperAdmin',
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: profileC.email.value,
                              keyboardType: TextInputType.text,
                              maxLines: 1,
                              decoration: const InputDecoration(
                                  labelText: 'Email ',
                                  hintMaxLines: 1,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: ConstColors.customRed,
                                          width: 4.0))),
                            ),
                            SeparatorWidget.height32(),
                            ButtonWidget.basic(context, "Add Administrator",
                                backgroundColor: ConstColors.customRed,
                                width: 600,
                                textColor: Colors.white, action: () {
                              profileC.create();
                            })
                          ],
                        ),
                        radius: 10.0);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.people),
                      SeparatorWidget.width12(),
                      const Text("Administrator Access")
                    ],
                  ),
                )),
          SeparatorWidget.height16(),
          ContainerWidget.roundedGrey(
              width: Get.width,
              InkWell(
                onTap: () async => await launchUrlString(
                    'https://wa.me/628978522848',
                    mode: LaunchMode.externalNonBrowserApplication),
                child: Row(
                  children: [
                    const Icon(Icons.live_help),
                    SeparatorWidget.width12(),
                    const Text("Faq")
                  ],
                ),
              )),
          SeparatorWidget.height16(),
          ContainerWidget.roundedGrey(
              width: Get.width,
              InkWell(
                onTap: () => authC.logout(),
                child: Row(
                  children: [
                    const Icon(Icons.logout),
                    SeparatorWidget.width12(),
                    const Text("Log out")
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
