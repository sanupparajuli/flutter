import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    // required this.onPressed,
    this.alignment = Alignment.topLeft,
    this.iconSize = 48,
    this.iconColor = Colors.black,
  });

  final Alignment alignment;
  // final VoidCallback onPressed;
  // final Icon icon;
  final Color iconColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
