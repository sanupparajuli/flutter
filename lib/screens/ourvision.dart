import 'package:flutter/material.dart';
import 'package:one_in_million/utils/text_style.dart';
import 'package:one_in_million/widgets/horizontal_logo.dart';
import 'package:one_in_million/widgets/responsive.dart';

class OurVision extends StatelessWidget {
  const OurVision({super.key});

  @override
  Widget build(BuildContext context) {
    const double imageWidth = 80.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: buildLogo(context),
                  ),
                ],
              ),
              Image.asset(
                'assets/logo/cha2.jpeg',
                width: Responsive.width(100, context) * imageWidth,
              ),
              Text(
                'Our vision for 1inaMillion..',
                style: regularBoldTextStyle1(),
              ),
              Text(
                'Together we will tackle the big issues',
                style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'SourceSansPro',
                  color: Colors.teal.shade100,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'We know that sustainable change cannot be achieved alone which is why we are on a mission to get 1 million people around the world to sign up and give 1 dollor a month (taken as a 12 dollor annual payment)\n'
                  'Every year, new community members ask 1 friend to join the 1inaMillion global community so that by 2030, we have 8 million members, collectively raising 96 dollor million annually supporting 3,840 schools and over 3 million children.\nIt all starts with you...',
                  style: regularTextStyle(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
