import 'package:contacts_proj/ui/common/app_colors.dart';
import 'package:contacts_proj/ui/common/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

// ignore: must_be_immutable
class HintInputWidget extends StatelessWidget {
  final String label;
  final TextInputAction textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;
  FormFieldSetter<String>? onSaved;
  final TextEditingController? controller;
  final String identifier;
  int maxLines;
  bool obscureText;
  String initialValues = '';
  Color textColor;
  int? maxLenght;
  Widget? icon;
  Widget? suffixIcon;
  FocusNode? focusNode;
  Function(String)? onChange;
  Function(String)? onSubmitted;
  void Function()? onEditingComplete;
  Function()? onTap;
  bool isEnabled;
  final EdgeInsetsGeometry contentPadding;
  final Color focusBorderColor;

  HintInputWidget({
    super.key,
    required this.label,
    required this.textInputAction,
    required this.keyboardType,
    this.validator,
    this.onSaved,
    this.controller,
    this.initialValues = '',
    this.obscureText = false,
    this.maxLines = 1,
    this.textColor = Colors.white,
    this.maxLenght,
    this.icon,
    this.onChange,
    this.onTap,
    this.focusNode,
    this.suffixIcon,
    this.onSubmitted,
    this.isEnabled = true,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
    this.onEditingComplete,
    required this.identifier,
    this.inputFormatters,
    this.focusBorderColor = const Color(0xFFDDDDDD),
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      identifier: identifier,
      child: TextFormField(
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        controller: controller ??
            (initialValues.isNotEmpty
                ? TextEditingController(text: initialValues)
                : null),
        validator: validator,
        autofocus: false,
        maxLength: maxLenght,
        onSaved: onSaved,
        onChanged: onChange,
        enabled: isEnabled,
        onEditingComplete: onEditingComplete,
        onFieldSubmitted: onSubmitted,
        onTap: onTap,
        focusNode: focusNode,
        style: TextStyle(
          fontSize: 15.sp,
          color: Colors.black,
        ),
        cursorColor: Colors.black,
        cursorWidth: 2,
        cursorHeight: 18,
        decoration: InputDecoration(
          fillColor: Colors.black.withOpacity(0.05),
          filled: true,
          suffixIcon: suffixIcon,
          prefixIcon: icon,
          contentPadding: contentPadding,
          hintText: label,
          errorStyle: kcBodyBoldStyle.copyWith(
            color: kcRedColor,
          ),
          hintStyle: kcBodyStyle.copyWith(
            color: Colors.black.withOpacity(0.4),
          ),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: kcRedColor,
                width: 0.5,
              )),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFDDDDDD), width: 0)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: kcRedColor,
                width: 0.5,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: focusBorderColor, width: 0)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Color(0xFFDDDDDD), width: 0)),
          errorMaxLines: 4,
        ),
      ),
    );
  }
}
