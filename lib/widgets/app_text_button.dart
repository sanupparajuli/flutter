import 'package:flutter/material.dart';

import '../utils/text_style.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textColor = Colors.black,
    this.alignment = Alignment.center,
  });

  final Alignment alignment;
  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: regularBoldTextStyle(color: textColor),
        ),
      ),
    );
  }
}
