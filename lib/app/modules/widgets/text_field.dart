import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:reservation_apps/app/common/constants/constants.dart';
import 'package:reservation_apps/app/common/enum/enum.dart';
import 'package:reservation_apps/app/modules/widgets/container_widget.dart';
import 'package:sprintf/sprintf.dart';

const _errorStyleNoLabel = TextStyle(
  color: Colors.red,
  height: 0,
);
const _defaultStyle = TextStyle(
  fontSize: 16.0,
  color: Colors.black,
  fontFamily: openSansRegular,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
);

class TextFormFieldWidget {
  static Widget textWithLabelHeight40(String label, String hint,
      {TextFieldType type = TextFieldType.normal,
      TextEditingController? controller,
      VoidCallback? onTap,
      List<TextInputFormatter>? inputFormatters,
      bool enabled = true,
      EdgeInsets? contentPadding = const EdgeInsets.fromLTRB(10, 10, 10, 10),
      FocusNode? focusNode,
      int? maxLines = 1,
      int? maxLength,
      FormFieldValidator<String>? validator,
      AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
      TextStyle textStyle = textStyleTextDefault,
      VoidCallback? onEditingComplete,
      TextInputType keyboardType = TextInputType.text,
      Function(String? value)? onChanged,
      TextInputAction textInputAction = TextInputAction.done,
      Function(String)? onFieldSubmitted,
      InputDecoration? decoration,
      double? height = 48}) {
    Widget textForm = TextFormField(
      controller: controller,
      enableSuggestions: true,
      validator: validator,
      onEditingComplete: onEditingComplete,
      autovalidateMode: autovalidateMode,
      focusNode: focusNode,
      enabled: enabled,
      onChanged: onChanged,
      style: textStyleTextDefault.copyWith(color: Colors.black),
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: decoration ??
          _Border._defaultInputDecoration(
            style: textStyle,
            contentPadding: contentPadding,
            enable: enabled,
            hint: hint,
          ),
    );
    switch (type) {
      case TextFieldType.dropdown:
        textForm = dropdown(hint,
            controller: controller,
            onTap: onTap,
            readOnly: true,
            enabled: true,
            autovalidateMode: autovalidateMode,
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 22,
            ),
            validator: validator,
            style: textStyle,
            onChanged: onChanged);
        break;
      case TextFieldType.normal:
      default:
        break;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: textStyle),
        const SizedBox(height: 8),
        SizedBox(
          height: height,
          child: textForm,
        ),
      ],
    );
  }

  static Widget mainNumeric(
    String hint, {
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    FocusNode? focusNode,
    VoidCallback? onEditingComplete,
    bool enabled = true,
    List<TextInputFormatter>? inputFormatters,
    Function(String? value)? onChanged,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) {
    return textHeight48(
      hint,
      controller: controller,
      autovalidateMode: autovalidateMode,
      enabled: enabled,
      onEditingComplete: onEditingComplete,
      validator: validator,
      keyboardType: TextInputType.number,
      inputFormatters: inputFormatters,
      focusNode: focusNode,
      onChanged: onChanged,
    );
  }

  static Widget password(
    String hint,
    bool isObscureText, {
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isObscureText,
      enableSuggestions: false,
      autocorrect: false,
      autovalidateMode: autovalidateMode,
      style: textStyleTextLarge.copyWith(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        border: _Border._defaultBorder(),
        focusedBorder: _Border._focusedBorder(),
        enabledBorder: _Border._enabledBorder(),
        errorBorder: _Border._errorBorder(),
        filled: false,
        fillColor: Colors.white,
        hintText: hint,
        focusColor: Colors.red,
        errorStyle: _errorStyleNoLabel,
      ),
    );
  }

  static Widget passwordWithVisibillityIcon(String hint,
      {TextEditingController? controller,
      FormFieldValidator<String>? validator,
      AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
      bool isObscureText = false,
      bool enabled = true,
      Function()? onVisibillityTap,
      Function(String? value)? onChanged,
      OutlineInputBorder? focusBorder,
      Color? visibleIconColor,
      double? height = 48}) {
    IconData icon = Icons.visibility_off;
    Color color = ConstColors.dark40;
    if (!isObscureText) {
      icon = Icons.visibility;
      color = visibleIconColor ?? ConstColors.blue30;
    }
    return Container(
      constraints: BoxConstraints(minHeight: height ?? 48),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: isObscureText,
        enableSuggestions: false,
        enabled: enabled,
        autovalidateMode: autovalidateMode,
        autocorrect: false,
        style: textStyleTextLarge.copyWith(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          border: _Border._defaultBorder(),
          focusedBorder: focusBorder ?? _Border._focusedBorder(),
          enabledBorder: _Border._enabledBorder(),
          errorBorder: _Border._errorBorder(),
          filled: true,
          fillColor: enabled ? Colors.white : ConstColors.gray20,
          hintText: hint,
          focusColor: Colors.red,
          errorStyle: _errorStyleNoLabel,
          suffixIcon: GestureDetector(
            onTap: onVisibillityTap,
            child: Icon(icon, color: color, size: 19),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }

  static Widget dropdown(
    String hint, {
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    Widget? suffixIcon,
    VoidCallback? onTap,
    bool readOnly = false,
    bool enabled = false,
    TextStyle style = textStyleTextDefault,
    Function(String? value)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      enableSuggestions: false,
      autocorrect: false,
      enabled: enabled,
      readOnly: readOnly,
      autovalidateMode: autovalidateMode,
      onTap: onTap,
      style: style.copyWith(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        border: _Border._defaultBorder(),
        focusedBorder: _Border._focusedBorder(),
        enabledBorder: _Border._enabledBorder(),
        errorBorder: _Border._errorBorder(),
        suffixIcon: suffixIcon,
        filled: false,
        fillColor: Colors.white,
        hintText: hint,
        focusColor: Colors.red,
        errorStyle: _errorStyleNoLabel,
      ),
      onChanged: onChanged,
    );
  }

  static Widget phone(
    String hint, {
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    FocusNode? focusNode,
    OutlineInputBorder? focusBorder,
    Function(String? value)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      enableSuggestions: false,
      focusNode: focusNode,
      autocorrect: false,
      keyboardType: TextInputType.number,
      autovalidateMode: autovalidateMode,
      maxLength: 15,
      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      style: textStyleTextLarge.copyWith(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        border: _Border._defaultBorder(),
        focusedBorder: focusBorder ?? _Border._focusedBorder(),
        enabledBorder: _Border._enabledBorder(),
        errorBorder: _Border._errorBorder(),
        counterText: '',
        filled: false,
        fillColor: Colors.white,
        hintText: hint,
        focusColor: Colors.red,
        errorStyle: _errorStyleNoLabel,
      ),
      onChanged: onChanged,
    );
  }

  static Widget isAlpha(
    String hint, {
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    FocusNode? focusNode,
    VoidCallback? onEditingComplete,
    bool enable = true,
    TextInputType keyboardType = TextInputType.text,
    int? maxLines = 1,
    int? maxLength,
    EdgeInsets? contentPadding = const EdgeInsets.fromLTRB(10, -10, 10, -10),
    List<TextInputFormatter>? inputFormatters,
    Function(String? value)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onEditingComplete: onEditingComplete,
      focusNode: focusNode,
      enabled: enable,
      style: _defaultStyle,
      onChanged: onChanged,
      maxLines: maxLines,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]'))
      ],
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        border: _Border._transparentBorder(),
        focusedBorder: _Border._focusedBorder(),
        enabledBorder: _Border._enabledBorder(),
        errorBorder: _Border._errorBorder(),
        errorStyle: _errorStyleNoLabel,
        filled: true,
        fillColor: enable ? Colors.white : Colors.grey,
        hintText: hint,
        counterText: "",
      ),
    );
  }

  static Widget search(
    String hint,
    onClear, {
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    OutlineInputBorder? focusBorder,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback? onEditingComplete,
    Function(String? value)? onChanged,
  }) {
    return Stack(
      children: [
        TextFormField(
          autovalidateMode: autovalidateMode,
          textInputAction: TextInputAction.search,
          controller: controller,
          enableSuggestions: true,
          validator: validator,
          onEditingComplete: onEditingComplete,
          style: textStyleTextLarge.copyWith(color: Colors.black),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(10, -10, 10, -10),
            focusedBorder: focusBorder ?? _Border._focusedBorder(),
            enabledBorder: _Border._enabledBorder(),
            errorBorder: _Border._errorBorder(),
            errorStyle: _errorStyleNoLabel,
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
          ),
          onChanged: onChanged,
        ),
        Positioned(
          right: 0,
          child: IconButton(
            icon: const Icon(Icons.highlight_remove),
            iconSize: 20,
            onPressed: onClear,
          ),
        ),
      ],
    );
  }

  static Widget suffixed(String hint,
      {TextEditingController? controller,
      FormFieldValidator<String>? validator,
      AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
      VoidCallback? onEditingComplete,
      required Widget suffix,
      bool readOnly = false,
      bool enabled = true,
      bool enableInteractiveSelection = true,
      FocusNode? focusNode,
      VoidCallback? onTap,
      Function(String? value)? onChanged,
      OutlineInputBorder? focusBorderColor,
      double? height = 48}) {
    return Container(
      constraints: BoxConstraints(minHeight: height ?? 48),
      child: TextFormField(
        autovalidateMode: autovalidateMode,
        focusNode: focusNode,
        textInputAction: TextInputAction.search,
        readOnly: readOnly,
        enabled: enabled,
        controller: controller,
        validator: validator,
        onEditingComplete: onEditingComplete,
        enableInteractiveSelection: enableInteractiveSelection,
        onTap: onTap,
        style: textStyleTextDefault.copyWith(color: ConstColors.dark50),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(10, -10, 10, -10),
          border: _Border._transparentBorder(),
          focusedBorder: focusBorderColor ?? _Border._focusedBorder(),
          enabledBorder: _Border._enabledBorder(),
          errorBorder: _Border._errorBorder(),
          errorStyle: _errorStyleNoLabel,
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          suffixIcon: suffix,
        ),
        onChanged: onChanged,
      ),
    );
  }

  static Widget phoneWithCode({
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    OutlineInputBorder? focusBorder,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    String code = '+62',
    FocusNode? focusNode,
    Function(String? value)? onChanged,
  }) {
    return Row(
      children: <Widget>[
        ContainerWidget.roundedGrey(
          Center(
            child: Text(code),
          ),
        ),
        Container(width: 10),
        Expanded(
          child: phone(
            sprintf('Masukkan %s', ['Nomor Telepon']),
            autovalidateMode: autovalidateMode,
            controller: controller,
            validator: validator,
            focusNode: focusNode,
            focusBorder: focusBorder,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  static Widget textHeight48(
    String hint, {
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    FocusNode? focusNode,
    VoidCallback? onEditingComplete,
    bool enabled = true,
    TextInputType keyboardType = TextInputType.text,
    int? maxLines = 1,
    int? maxLength,
    EdgeInsets? contentPadding = const EdgeInsets.fromLTRB(10, 0, 10, 0),
    List<TextInputFormatter>? inputFormatters,
    TextStyle textStyle = textStyleTextDefault,
    bool? isObscureText,
    Function(String? value)? onChanged,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 48),
      child: TextFormField(
        obscureText: isObscureText ?? false,
        controller: controller,
        enableSuggestions: true,
        validator: validator,
        onEditingComplete: onEditingComplete,
        focusNode: focusNode,
        enabled: enabled,
        style: textStyle.copyWith(color: Colors.black),
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        autovalidateMode: autovalidateMode,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: _Border._defaultInputDecoration(
          style: textStyle,
          contentPadding: contentPadding,
          enable: enabled,
          hint: hint,
        ),
        onChanged: onChanged,
      ),
    );
  }

  static Widget textHeight40(
    String hint, {
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    String? initialValue,
    FocusNode? focusNode,
    VoidCallback? onEditingComplete,
    bool enable = true,
    TextInputType keyboardType = TextInputType.text,
    int? maxLines = 1,
    int? maxLength,
    EdgeInsets? contentPadding = const EdgeInsets.fromLTRB(10, 0, 10, 0),
    List<TextInputFormatter>? inputFormatters,
    TextStyle textStyle = textStyleTextDefault,
    bool? isObscureText,
    OutlineInputBorder? focusBorderColor,
    Function(String? value)? onChanged,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 40),
      child: TextFormField(
        autovalidateMode: autovalidateMode,
        obscureText: isObscureText ?? false,
        controller: controller,
        initialValue: initialValue,
        enableSuggestions: true,
        validator: validator,
        onEditingComplete: onEditingComplete,
        focusNode: focusNode,
        enabled: enable,
        style: textStyle.copyWith(color: Colors.black),
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: _Border._defaultInputDecoration(
          style: textStyle,
          contentPadding: contentPadding,
          focusBorderColor: focusBorderColor,
          enable: true,
          hint: hint,
        ),
        onChanged: onChanged,
      ),
    );
  }

  static Widget textHeight40WithPreffixSearch(
    String hint, {
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    String? initialValue,
    FocusNode? focusNode,
    VoidCallback? onEditingComplete,
    bool enable = true,
    TextInputType keyboardType = TextInputType.text,
    int? maxLines = 1,
    int? maxLength,
    EdgeInsets? contentPadding = const EdgeInsets.fromLTRB(10, 0, 10, 0),
    List<TextInputFormatter>? inputFormatters,
    TextStyle textStyle = textStyleTextDefault,
    bool? isObscureText,
    OutlineInputBorder? focusBorderColor,
    Function(String? value)? onChanged,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 40),
      child: TextFormField(
        autovalidateMode: autovalidateMode,
        obscureText: isObscureText ?? false,
        controller: controller,
        initialValue: initialValue,
        enableSuggestions: true,
        validator: validator,
        onEditingComplete: onEditingComplete,
        focusNode: focusNode,
        enabled: enable,
        style: textStyle.copyWith(color: Colors.black),
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          border: _Border._defaultBorder(),
          focusedBorder: focusBorderColor ?? _Border._focusedBorder(),
          enabledBorder: _Border._enabledBorder(),
          prefixIcon: const Icon(Icons.search),
          errorBorder: _Border._errorBorder(),
          errorStyle: _errorStyleNoLabel,
          filled: true,
          fillColor: enable ? Colors.white : ConstColors.gray20,
          hintText: hint,
          counterText: '',
        ),
        onChanged: onChanged,
      ),
    );
  }

  static Widget textHeight40WithCollorBG(
    String hint, {
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    String? initialValue,
    FocusNode? focusNode,
    VoidCallback? onEditingComplete,
    bool enable = true,
    TextInputType keyboardType = TextInputType.text,
    int? maxLines = 1,
    int? maxLength,
    EdgeInsets? contentPadding = const EdgeInsets.fromLTRB(10, 0, 10, 0),
    List<TextInputFormatter>? inputFormatters,
    TextStyle textStyle = textStyleTextDefault,
    bool? isObscureText,
    Color? fillColor,
    Color? textCollor,
    Function(String? value)? onChanged,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 40),
      child: TextFormField(
        autovalidateMode: autovalidateMode,
        obscureText: isObscureText ?? false,
        controller: controller,
        initialValue: initialValue,
        enableSuggestions: true,
        validator: validator,
        onEditingComplete: onEditingComplete,
        focusNode: focusNode,
        enabled: enable,
        style: textStyle.copyWith(color: textCollor ?? Colors.black),
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: InputDecoration(
          contentPadding: contentPadding,
          border: _Border._defaultBorder(),
          focusedBorder: _Border._focusedBorder(),
          enabledBorder: _Border._enabledBorder(),
          errorBorder: _Border._errorBorder(),
          errorStyle: _errorStyleNoLabel,
          filled: true,
          fillColor: fillColor ?? Colors.white,
          hintText: hint,
          counterText: '',
        ),
        onChanged: onChanged,
      ),
    );
  }

  static Widget textAddressWithCollorBG(
    String hint, {
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    String? initialValue,
    FocusNode? focusNode,
    VoidCallback? onEditingComplete,
    bool enable = true,
    TextInputType keyboardType = TextInputType.text,
    int? maxLines = 1,
    int? maxLength,
    EdgeInsets? contentPadding = const EdgeInsets.fromLTRB(10, 0, 10, 0),
    List<TextInputFormatter>? inputFormatters,
    TextStyle textStyle = textStyleTextDefault,
    bool? isObscureText,
    Color? fillCollor,
    Function(String? value)? onChanged,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 40),
      child: TextFormField(
        autovalidateMode: autovalidateMode,
        obscureText: isObscureText ?? false,
        controller: controller,
        initialValue: initialValue,
        enableSuggestions: true,
        validator: validator,
        onEditingComplete: onEditingComplete,
        focusNode: focusNode,
        enabled: enable,
        style: textStyle.copyWith(color: Colors.black),
        maxLines: maxLines,
        inputFormatters: inputFormatters,
        keyboardType: keyboardType,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: InputDecoration(
            border: _Border._defaultBorder(), fillColor: fillCollor),
        onChanged: onChanged,
      ),
    );
  }

  static Widget textHeight40PriceFormat(
    String hint, {
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    FocusNode? focusNode,
    VoidCallback? onEditingComplete,
    bool enable = true,
    int? maxLines = 1,
    int? maxLength,
    EdgeInsets? contentPadding = const EdgeInsets.fromLTRB(10, 0, 10, 0),
    List<TextInputFormatter>? inputFormatters,
    TextStyle textStyle = textStyleTextDefault,
    bool? isObscureText,
    Function(String? value)? onChanged,
    TextInputAction textInputAction = TextInputAction.done,
    Function(String)? onFieldSubmitted,
  }) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        autovalidateMode: autovalidateMode,
        obscureText: isObscureText ?? false,
        controller: controller,
        enableSuggestions: true,
        validator: validator,
        onEditingComplete: onEditingComplete,
        focusNode: focusNode,
        enabled: enable,
        style: textStyle.copyWith(color: Colors.black),
        maxLines: maxLines,
        keyboardType: TextInputType.number,
        maxLength: maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        decoration: _Border._defaultInputDecoration(
          style: textStyle,
          contentPadding: contentPadding,
          enable: true,
          hint: hint,
        ),
        inputFormatters: [ThousandsFormatter()],
        onChanged: onChanged,
      ),
    );
  }

  static Widget textHeightDynamic(
    Key key,
    String hint, {
    String? initialValue,
    Function(String value)? onChanged,
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    FocusNode? focusNode,
    VoidCallback? onEditingComplete,
    bool enable = true,
    TextInputType keyboardType = TextInputType.multiline,
    int? maxLines,
    int? maxLength,
    EdgeInsets? contentPadding = const EdgeInsets.fromLTRB(10, 10, 10, 10),
    List<TextInputFormatter>? inputFormatters,
    TextStyle textStyle = textStyleTextDefault,
    bool? isObscureText,
    Function(String)? onFieldSubmitted,
    TextInputAction textInputAction = TextInputAction.done,
    OutlineInputBorder? focusOutlineBorder,
    bool autofocus = false,
  }) {
    return TextFormField(
      key: key,
      autovalidateMode: autovalidateMode,
      initialValue: initialValue,
      obscureText: isObscureText ?? false,
      controller: controller,
      enableSuggestions: true,
      validator: validator,
      onEditingComplete: onEditingComplete,
      focusNode: focusNode,
      onChanged: onChanged,
      enabled: enable,
      style: textStyle.copyWith(color: Colors.black),
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      maxLength: maxLength,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      decoration: _Border._defaultInputDecoration(
        style: textStyle,
        contentPadding: contentPadding,
        focusBorderColor: focusOutlineBorder,
        enable: true,
        hint: hint,
      ),
    );
  }
}

class _Border {
  //default border
  static OutlineInputBorder _defaultBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: ConstColors.gray30,
        width: .5,
      ),
    );
  }

  static OutlineInputBorder _transparentBorder() {
    final defaultBorder = _defaultBorder();
    return defaultBorder.copyWith(
      borderSide: defaultBorder.borderSide.copyWith(
        color: Colors.transparent,
      ),
    );
  }

  static OutlineInputBorder _focusedBorder() {
    return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(
        color: ConstColors.blue30,
        width: .5,
      ),
    );
  }

  static OutlineInputBorder _enabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: ConstColors.gray30,
        width: .5,
      ),
    );
  }

  static OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(
        color: Colors.red,
        width: 1.0,
      ),
    );
  }

  static InputDecoration _defaultInputDecoration({
    EdgeInsetsGeometry? contentPadding,
    String? hint,
    bool enable = true,
    OutlineInputBorder? focusBorderColor,
    required TextStyle style,
  }) {
    return InputDecoration(
      contentPadding: contentPadding,
      border: _Border._defaultBorder(),
      focusedBorder: focusBorderColor ?? _Border._focusedBorder(),
      enabledBorder: _Border._enabledBorder(),
      errorBorder: _Border._errorBorder(),
      errorStyle: _errorStyleNoLabel,
      filled: true,
      fillColor: enable ? Colors.white : ConstColors.gray20,
      hintText: hint,
      counterText: '',
    );
  }
}
