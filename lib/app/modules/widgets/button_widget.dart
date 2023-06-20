import 'package:flutter/material.dart';
import 'package:reservation_apps/app/common/constants/constants.dart';
import 'package:reservation_apps/app/modules/widgets/separator_widget.dart';

import 'typography.dart';

class ButtonWidget {
  static Widget basic(
    BuildContext context,
    String text, {
    double? width,
    double? height = 42,
    action,
    double? borderRadius,
    Color? backgroundColor,
    Color? textColor,
    EdgeInsets? contentPadding = const EdgeInsets.all(10),
  }) {
    return TextButton(
      onPressed: action,
      // ignore: sort_child_properties_last
      child: Container(
        padding: contentPadding,
        width: width,
        height: height,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyleConstants.textStyleHeadingH7XxSmall
              .copyWith(color: textColor ?? Colors.black),
        ),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor:
            MaterialStateProperty.all(backgroundColor ?? ConstColors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
        ),
      ),
    );
  }

  static Widget withPressed(
    BuildContext context,
    String text, {
    double? width,
    double? height = 42,
    action,
    double? borderRadius,
    Color? defaultColor,
    Color? pressedColor,
    Color? textColor,
  }) {
    return TextButton(
      onPressed: action,
      // ignore: sort_child_properties_last
      child: Container(
        padding: const EdgeInsets.all(10),
        width: width,
        height: height,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyleConstants.textStyleHeadingH7XxSmall
              .copyWith(color: textColor ?? Colors.black),
        ),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed) || action == null) {
              return pressedColor ?? ConstColors.gray30;
            }
            return defaultColor ?? ConstColors.blue30;
          },
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
        ),
      ),
    );
  }

  static Widget imageOnLeft(
    BuildContext context,
    String text,
    String asset, {
    double? width,
    double? height = 42,
    action,
    MainAxisAlignment? alignment = MainAxisAlignment.center,
    double? borderRadius,
    Color? backgroundColor,
    Color? textColor,
    Color? iconColor,
  }) {
    return TextButton(
      onPressed: action,
      // ignore: sort_child_properties_last
      child: Container(
        padding: const EdgeInsets.all(10),
        width: width,
        child: Row(
          mainAxisAlignment: alignment!,
          children: [
            Image.asset(asset,
                width: 20, height: 20, color: iconColor ?? ConstColors.dark50),
            Container(width: 10),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyleConstants.textStyleHeadingH7XxSmall
                  .copyWith(color: textColor ?? ConstColors.dark50),
            ),
          ],
        ),
      ),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor:
            MaterialStateProperty.all(backgroundColor ?? ConstColors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
        ),
      ),
    );
  }

  static Widget imageOnCenter(
    BuildContext context,
    String asset, {
    double? width,
    double? height = 42,
    action,
    double? borderRadius,
    Color? backgroundColor,
    Color? iconColor,
  }) {
    return TextButton(
      onPressed: action,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor:
            MaterialStateProperty.all(backgroundColor ?? ConstColors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: width,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(asset,
                width: 14, color: iconColor ?? ConstColors.gray20),
          ],
        ),
      ),
    );
  }

  static Widget prefixedButton({
    double? width,
    double? height = 42,
    Function()? action,
    required String text,
    required Widget prefix,
    Color? color,
    Color? textColor,
    double? borderRadius,
  }) {
    return TextButton(
      onPressed: action,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: width,
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefix,
            SeparatorWidget.width10(),
            BodyText(text, color: textColor, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  static Widget outlined(
    BuildContext context, {
    double? width,
    double? height = 42,
    Function()? action,
    required String text,
    Color? color,
    Color outlineColor = Colors.white,
    Color titleColor = Colors.white,
    double? borderRadius,
  }) {
    return TextButton(
      onPressed: action,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor: MaterialStateProperty.all(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
            side: BorderSide(color: outlineColor),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        //width: width ?? MediaQuery.of(context).size.width,
        width: width,

        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(color: titleColor),
        ),
      ),
    );
  }

  static Widget suffixIconedButton({
    required String text,
    required Widget suffix,
    double? width,
    double? height = 42,
    Function()? onTap,
    Color buttonColor = ConstColors.gray20,
    Color textColor = ConstColors.dark40,
    double? borderRadius,
  }) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        backgroundColor: MaterialStateProperty.all(buttonColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
        ),
      ),
      child: SizedBox(
        width: width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BodyText(text, color: textColor, textAlign: TextAlign.center),
            SeparatorWidget.width6(),
            suffix,
          ],
        ),
      ),
    );
  }

  static Widget customWithBorder(
    BuildContext context,
    String text, {
    double? width,
    double? height,
    action,
    double? borderRadius,
    double? borderSide,
    Color? backgroundColor,
    Color? textColor,
  }) {
    return TextButton(
      onPressed: action,
      style: OutlinedButton.styleFrom(
        fixedSize: Size.fromHeight(height ?? 42),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        side: BorderSide(
            width: borderSide ?? 2.0, color: backgroundColor ?? Colors.blue),
      ),
      child: Container(
        padding: const EdgeInsets.all(2),
        width: width,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyleConstants.textStyleHeadingH7XxSmall
              .copyWith(color: textColor ?? ConstColors.blue40),
        ),
      ),
    );
  }

  static Widget onProgress(BuildContext context, String? text,
      {double? width, action, Color? textColor, Color? progressColor}) {
    return ElevatedButton(
      onPressed: action,
      style: ButtonStyle(
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor: MaterialStateProperty.all(ConstColors.gray40),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        //width: width ?? MediaQuery.of(context).size.width,
        width: width,
        height: 42,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                color: progressColor ?? ConstColors.blue40,
                strokeWidth: 2.0,
              ),
            ),
            Container(width: 10),
            Text(
              text ?? 'loading...',
              textAlign: TextAlign.center,
              style: TextStyleConstants.textStyleHeadingH7XxSmall
                  .copyWith(color: textColor ?? ConstColors.dark50),
            ),
          ],
        ),
      ),
    );
  }
}
