import 'package:flutter/material.dart';

import '../utils/text_style.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.boxColor,
    required this.text,
    this.textColor = Colors.black,
  });

  final VoidCallback onPressed;
  final Color boxColor;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: regularBoldTextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
