import 'package:flutter/cupertino.dart';

class Responsive {
  static height(double p, BuildContext context) {
    return MediaQuery.of(context).size.height / p;
  }

  static width(double p, BuildContext context) {
    return MediaQuery.of(context).size.width / p;
  }

  static textScale(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }
}
