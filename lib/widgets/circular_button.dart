import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    this.bgColor = Colors.white,
    this.buttonScale = 1,
    this.child = const Text(""),
  });

  final Color bgColor;
  // final
  final double buttonScale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    double height = 40;
    double width = 40;
    return Container(
      height: height * buttonScale,
      width: width * buttonScale,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
