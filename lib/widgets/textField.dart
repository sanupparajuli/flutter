import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/text_style.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.textFieldIcon,
    required this.hintText,
    this.decoration = true,
    this.onPressed,
    this.isPasswordField = false,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final Icon textFieldIcon;
  final String hintText;
  final bool decoration;
  final VoidCallback? onPressed;
  final bool isPasswordField;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    bool obscureText = false;
    bool enableSuggestions = true;
    bool autoCorrect = true;

//conditon for the password field
    if (isPasswordField) {
      obscureText = true;
      enableSuggestions = false;
      autoCorrect = false;
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        obscureText: obscureText,
        enableSuggestions: enableSuggestions,
        autocorrect: autoCorrect,
        style: regularBoldTextStyle(color: AppColor.iconBlue),
        decoration: (decoration)
            ? InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: AppColor.defaultGrey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: AppColor.iconBlue,
                    width: 2,
                  ),
                ),
                prefixIcon: IconButton(onPressed: onPressed, icon: textFieldIcon),
                hintText: hintText,
                hintStyle: regularTextStyle(color: AppColor.defaultWhite),
                // errorText: Constants.fieldCantBeEmpty,
                // errorStyle: regularTextStyle(color: AppColor.defaultRed),
              )
            : InputDecoration(
                prefixIcon: IconButton(onPressed: onPressed, icon: textFieldIcon),
                hintText: hintText,
                hintStyle: regularTextStyle(color: AppColor.defaultWhite),
                // errorText: Constants.fieldCantBeEmpty,
                // errorStyle: regularTextStyle(color: AppColor.defaultRed),
              ),
      ),
    );
  }
}
