import 'package:flutter/foundation.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

Future<bool> getInternetUsingInternetConnectivity() async {
  if (kIsWeb) {
    return Future(() {
      return true;
    });
  }
  bool result = await InternetConnectionChecker().hasConnection;
  return result;
}
