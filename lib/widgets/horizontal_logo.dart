import 'package:flutter/material.dart';
import 'package:one_in_million/utils/colors.dart';
import 'package:one_in_million/widgets/responsive.dart';

Widget buildHorizontalLogo(BuildContext context) {
  String logo = 'assets/logo/logo.png';
  const double imageWidth = 40.0;
  const double imageHeight = 15.0;
  return Center(
    child: Column(
      children: [
        Image.asset(
          logo,
          width: Responsive.width(100, context) * imageWidth,
          height: Responsive.height(100, context) * imageHeight,
        ),
        Text(
          '1 in a million',
          style: TextStyle(
            fontSize: 35,
            color: AppColor.iconBlue,
            fontWeight: FontWeight.bold,
            // letterSpacing: -1.5,
            wordSpacing: -5.5,
          ),
        ),
        Text(
          'a global movement by',
          style: TextStyle(
            fontSize: 14,
            color: AppColor.iconLightGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text.rich(
          TextSpan(
            text: 'so the',
            style: TextStyle(
              fontSize: 18,
              color: AppColor.iconBlue,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'y can',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: AppColor.iconGreen,
                  decorationThickness: 2.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget buildLogo(BuildContext context) {
  String logo = 'assets/logo/logo_vertical.png';
  const double imageWidth = 40.0;
  const double imageHeight = 15.0;
  return Center(
    child: Column(
      children: [
        Image.asset(
          logo,
          width: Responsive.width(100, context) * imageWidth,
          height: Responsive.height(100, context) * imageHeight,
        ),
      ],
    ),
  );
}
