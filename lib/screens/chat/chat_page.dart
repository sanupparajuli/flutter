import 'package:flutter/material.dart';
import 'package:one_in_million/screens/chat/component/utilities/faq.dart';
import 'package:one_in_million/utils/colors.dart';
import 'package:one_in_million/widgets/app_button.dart';
import 'package:one_in_million/widgets/horizontal_logo.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
            child: Column(children: [
          Column(
            children: [
              const SizedBox(height: 20),
              buildHorizontalLogo(context),
              const SizedBox(height: 5),
              Text(
                "Welcome to 1inaMillion Guide",
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 300,
            child: Image.asset(
              'assets/logo/faq_image.png',
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 10),

          ///Can be used in future for Customized Chatbot
          // ElevatedButton(
          //   style: ElevatedButton.styleFrom(
          //     padding: const EdgeInsets.all(0.0),
          //     elevation: 5,
          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
          //   ),
          //   onPressed: () {
          //     Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChatDashboard()));
          //   },
          //   child: Ink(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(10),
          //       gradient: LinearGradient(
          //           colors: [AppColor.iconLightGreen, AppColor.iconBlue],
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter),
          //     ),
          //     child: Container(
          //       padding: const EdgeInsets.all(10),
          //       constraints: const BoxConstraints(minWidth: 100),
          //       child: const Text('GET STARTED', textAlign: TextAlign.center),
          //     ),
          //   ),
          // )
          //,
          AppButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FaqChat()));
            },
            boxColor: AppColor.iconBlue,
            text: 'Frequently Asked Questions ?',
            textColor: AppColor.defaultWhite,
          ),
        ])),
      ),
    );
  }
}
