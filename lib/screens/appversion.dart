import 'package:flutter/material.dart';
import 'package:one_in_million/utils/colors.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion extends StatefulWidget {
  const AppVersion({super.key});

  @override
  State<AppVersion> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  String? _version;

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  void _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final version = packageInfo.version;

    setState(() {
      _version = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Version ${_version ?? '-'}',
          style: TextStyle(color: AppColor.iconBlue),
        ),
      ],
    );
  }
}
