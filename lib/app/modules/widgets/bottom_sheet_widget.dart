import 'package:flutter/material.dart';
import 'package:reservation_apps/app/common/constants/constants.dart';
import 'package:reservation_apps/app/modules/widgets/separator_widget.dart';

import 'button_widget.dart';
import 'typography.dart';

class BottomSheetWidget {
  static Widget _topIndicator() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: ConstColors.gray20,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 5,
        width: 80,
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      ),
    );
  }

  static Widget baseSheet({
    required Widget child,
    EdgeInsets? contentPadding = const EdgeInsets.symmetric(
      horizontal: dimensMarginLeftMainLayout,
    ),
    bool withTopIndicator = true,
  }) {
    return Container(
      color: Colors.transparent,
      padding: EdgeInsets.zero,
      child: Container(
        constraints: const BoxConstraints(minHeight: 150),
        padding: contentPadding,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Visibility(visible: withTopIndicator, child: _topIndicator()),
            Flexible(child: child),
          ],
        ),
      ),
    );
  }

  static Widget imagePickerOptions({
    Function()? onTapCamera,
    Function()? onTapGalery,
  }) {
    return baseSheet(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const BodyText('Ganti Foto'),
            SeparatorWidget.height16(),
            ButtonWidget.suffixIconedButton(
              suffix: Image.asset(IconAssetConstants.camera,
                  color: ConstColors.dark40),
              text: 'Buka kamera',
              onTap: onTapCamera,
            ),
            SeparatorWidget.height8(),
            ButtonWidget.suffixIconedButton(
              suffix: const Icon(
                Icons.image,
                color: ConstColors.dark40,
              ),
              text: 'Pilih dari galeri',
              onTap: onTapGalery,
            ),
            SeparatorWidget.height16(),
          ],
        ),
      ),
    );
  }
}
