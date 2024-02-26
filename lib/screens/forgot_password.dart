import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_in_million/utils/colors.dart';
import 'package:one_in_million/utils/constants.dart';
import 'package:one_in_million/utils/internet_connectivity.dart';
import 'package:one_in_million/utils/text_style.dart';
import 'package:one_in_million/widgets/app_button.dart';
import 'package:one_in_million/widgets/back_button.dart';
import 'package:one_in_million/widgets/textField.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    super.key,
  });

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppBackButton(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Constants.resetPassword,
              textAlign: TextAlign.center,
              style: regularBoldTextStyle1(),
            ),
            const SizedBox(
              height: 5,
            ),
            AppTextField(
              controller: emailController,
              textFieldIcon: Icon(Icons.person, color: AppColor.iconBlue),
              hintText: Constants.email,
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              onPressed: () async {
                if (await getInternetUsingInternetConnectivity()) {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
                }
              },
              boxColor: AppColor.iconBlue,
              text: Constants.submit.toUpperCase(),
              textColor: AppColor.defaultWhite,
            ),
          ],
        ),
      ),
    );
  }
}
