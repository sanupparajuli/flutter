import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:one_in_million/utils/colors.dart';

class Flush {
  final BuildContext _context;
  Flush(this._context);
  message(String message) {
    _flush(message);
  }

  _flush(String message) {
    Flushbar(
      backgroundColor: AppColor.iconBlue,
      message: message,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: AppColor.iconGreen,
      ),
      duration: const Duration(seconds: 1),
      leftBarIndicatorColor: AppColor.iconGreen,
    ).show(_context);
  }
}
