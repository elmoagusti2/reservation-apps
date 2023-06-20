import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:reservation_apps/app/common/constants/constants.dart';
import 'package:reservation_apps/app/modules/widgets/labelled_widget.dart';
import 'package:reservation_apps/app/modules/widgets/separator_widget.dart';
import 'package:reservation_apps/app/modules/widgets/text_field.dart';
import 'package:reservation_apps/app/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final LoginController _controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.only(left: 25, right: 25),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background/soccer_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  LabelledWidget(
                    separatorHeight: 8,
                    style: TextStyleConstants.textStyleTextSmall,
                    child: TextFormFieldWidget.textHeight48(
                      'Input Email',
                      controller: _controller.email.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textStyle: textStyleTextLarge,
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (!RegularExpressions.email
                            .hasMatch(text.toString())) {
                          return "Input Email Format";
                        }
                        return null;
                      },
                    ),
                  ),
                  SeparatorWidget.height24(),
                  LabelledWidget(
                    //  label: "Password",
                    separatorHeight: 8,
                    style: TextStyleConstants.textStyleTextSmall,
                    child: TextFormFieldWidget.passwordWithVisibillityIcon(
                      "Input Password",
                      isObscureText: _controller.visibilityPass.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onVisibillityTap: () {
                        _controller.visibilityPass.value =
                            _controller.visibilityPass.value == true
                                ? false
                                : true;
                      },
                      controller: _controller.pass.value,
                      validator: (text) {
                        return null;
                      },
                    ),
                  ),
                  SeparatorWidget.height6(),
                  SeparatorWidget.height24(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ConstColors.white,
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.SIGNUP);
                        },
                        child: const Text(
                          'REGISTER',
                          style: TextStyle(
                              color: ConstColors.customRed,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SeparatorWidget.width10(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: ConstColors.custom),
                          onPressed: () {
                            _controller.check();
                          },
                          child: controller.buttonStatus.value
                              ? const Text(
                                  'LOGIN',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              : const SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    color: ConstColors.white,
                                  )))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
