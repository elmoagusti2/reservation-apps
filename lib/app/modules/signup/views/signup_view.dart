import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reservation_apps/app/common/constants/constants.dart';
import 'package:reservation_apps/app/modules/widgets/labelled_widget.dart';
import 'package:reservation_apps/app/modules/widgets/separator_widget.dart';
import 'package:reservation_apps/app/modules/widgets/text_field.dart';
import 'package:reservation_apps/app/modules/widgets/typography.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [ConstColors.customRed, Colors.black],
                      begin: FractionalOffset.topLeft,
                      end: FractionalOffset.bottomRight,
                      stops: [0.0, 0.8],
                      tileMode: TileMode.mirror)),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Heading.h2XLarge('Register Account',
                        color: ConstColors.white),
                    SeparatorWidget.height32(),
                    LabelledWidget(
                      label: 'Email',
                      separatorHeight: 8,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      child: TextFormFieldWidget.textHeight48(
                        'Input Email',
                        controller: controller.email.value,
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
                      label: "Password",
                      separatorHeight: 8,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      child: TextFormFieldWidget.passwordWithVisibillityIcon(
                        "Input Password",
                        isObscureText: controller.visibilityPass.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onVisibillityTap: () {
                          controller.visibilityPass.value =
                              controller.visibilityPass.value == true
                                  ? false
                                  : true;
                        },
                        controller: controller.password.value,
                        validator: (text) {
                          // Temporary hide
                          if (!RegularExpressions.password
                              .hasMatch(text.toString())) {
                            return "Input Uppercase, Lowercase, Number and Special Character";
                          }
                          return null;
                        },
                      ),
                    ),
                    SeparatorWidget.height24(),
                    LabelledWidget(
                      label: "Confirm Password",
                      separatorHeight: 8,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      child: TextFormFieldWidget.passwordWithVisibillityIcon(
                        "Input Confirm Password",
                        isObscureText: controller.visibilityPassConfirm.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onVisibillityTap: () {
                          controller.visibilityPassConfirm.value =
                              controller.visibilityPassConfirm.value == true
                                  ? false
                                  : true;
                        },
                        controller: controller.confirmPassword.value,
                        validator: (text) {
                          // Temporary hide
                          if (text != controller.password.value.text) {
                            return "Please Check Password";
                          }
                          return null;
                        },
                      ),
                    ),
                    SeparatorWidget.height24(),
                    LabelledWidget(
                      label: 'Phone Number',
                      separatorHeight: 8,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      child: TextFormFieldWidget.textHeight48(
                        'Input Number',
                        controller: controller.phoneNumber.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textStyle: textStyleTextLarge,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SeparatorWidget.height24(),
                    LabelledWidget(
                      label: 'Address',
                      separatorHeight: 8,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      child: TextFormFieldWidget.textHeight40(
                        'Address',
                        controller: controller.address.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textStyle: textStyleTextLarge,
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SeparatorWidget.height32(),
                    SeparatorWidget.height32(),
                    GestureDetector(
                      onTap: () => controller.check(),
                      child: Container(
                          width: Get.width,
                          height: 50,
                          decoration: BoxDecoration(
                              color: ConstColors.customRed,
                              borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                              child: Heading.h7XXSmall(
                            'REGISTER',
                            color: ConstColors.white,
                          ))),
                    )
                  ],
                ),
              )),
        ));
  }
}
