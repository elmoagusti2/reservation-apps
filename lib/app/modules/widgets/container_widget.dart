import 'package:flutter/material.dart';
import 'package:reservation_apps/app/common/constants/constants.dart';

class ContainerWidget {
  static Widget roundedGrey(Widget child,
      {double? width, double? height, EdgeInsets? padding}) {
    return Container(
      width: width ?? dimensButtonHeight,
      height: height ?? dimensButtonHeight,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        color: ConstColors.gray20,
      ),
      padding: padding ?? const EdgeInsets.all(10.0),
      child: child,
    );
  }

  static Widget selectDate({
    double? width,
    double? height,
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    VoidCallback? actionClick,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: actionClick,
      child: SizedBox(
        width: width ?? dimensButtonHeight,
        height: height ?? dimensButtonHeight,
        child: Stack(
          children: [
            TextFormField(
              controller: controller,
              enableSuggestions: true,
              validator: validator,
              enabled: false,
              style: textStyleTextLarge,
              decoration: InputDecoration(
                hintText: 'Pilih Tanggal',
                contentPadding: const EdgeInsets.fromLTRB(10, -10, 10, -10),
                border: _defaultBorder(),
                focusedBorder: _focusedBorder(),
                enabledBorder: _enabledBorder(),
                errorBorder: _errorBorder(),
                errorStyle: const TextStyle(
                  fontSize: 0,
                  color: Colors.red,
                  height: 0,
                ),
                filled: true,
                fillColor: ConstColors.white,
              ),
            ),
            Positioned(
              right: 10,
              top: 0,
              bottom: 0,
              child: Image.asset(
                IconAssetConstants.calendar,
                width: 20,
                color: iconColor ?? ConstColors.gray30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget selectDateCustom({
    double? width,
    double? height,
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    VoidCallback? actionClick,
    Color? iconColor,
  }) {
    return InkWell(
      onTap: actionClick,
      child: SizedBox(
        width: width ?? dimensButtonHeight,
        height: height ?? dimensButtonHeight,
        child: Stack(
          children: [
            TextFormField(
              controller: controller,
              enableSuggestions: true,
              validator: validator,
              enabled: true,
              style: textStyleTextLarge,
              decoration: InputDecoration(
                hintText: 'Pilih Tanggal',
                contentPadding: const EdgeInsets.fromLTRB(10, -10, 10, -10),
                border: _defaultBorder(),
                focusedBorder: _focusedBorder(),
                enabledBorder: _enabledBorder(),
                errorBorder: _errorBorder(),
                errorStyle: const TextStyle(
                  fontSize: 0,
                  color: Colors.red,
                  height: 0,
                ),
                filled: true,
                fillColor: ConstColors.white,
              ),
            ),
            Positioned(
              right: 10,
              top: 0,
              bottom: 0,
              child: Image.asset(
                IconAssetConstants.calendar,
                width: 20,
                color: iconColor ?? ConstColors.gray30,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static _defaultBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: ConstColors.gray30,
        width: .5,
      ),
    );
  }

  static Widget roundedWhiteBorderGrey(Widget child,
      {double? width, double? height, EdgeInsets? padding}) {
    return Container(
      width: width ?? dimensButtonHeight,
      height: height ?? dimensButtonHeight,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: ConstColors.white,
        border: Border.all(
          color: ConstColors.dark40,
          width: 1,
        ),
      ),
      padding: padding ?? const EdgeInsets.all(10.0),
      child: child,
    );
  }

  static Widget rounded(Widget child,
      {Color? backgroundColor,
      Color? borderColor,
      double? width,
      double? height,
      EdgeInsets? padding}) {
    return Container(
      width: width ?? dimensButtonHeight,
      height: height ?? dimensButtonHeight,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: backgroundColor ?? Colors.white,
        border: Border.all(
          color: borderColor ?? ConstColors.gray40,
          width: 1,
        ),
      ),
      padding: padding ?? const EdgeInsets.all(10.0),
      child: child,
    );
  }

  static _focusedBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(
        color: ConstColors.blue30,
        width: .5,
      ),
    );
  }

  static _enabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: ConstColors.gray30,
        width: .5,
      ),
    );
  }

  static _errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1.0,
      ),
    );
  }
}
