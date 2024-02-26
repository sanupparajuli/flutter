import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:one_in_million/services/firebase_auth.dart';
import 'package:one_in_million/utils/colors.dart';
import 'package:one_in_million/utils/constants.dart';
import 'package:one_in_million/utils/text_style.dart';
import 'package:one_in_million/widgets/app_button.dart';
import 'package:one_in_million/widgets/back_button.dart';

import '../services/firestore_data.dart';

class UpdatePhoneNumber extends StatefulWidget {
  const UpdatePhoneNumber({
    super.key,
  });

  @override
  State<UpdatePhoneNumber> createState() => _UpdatePhoneNumberState();
}

class _UpdatePhoneNumberState extends State<UpdatePhoneNumber> {
  late FirebaseAuthentication _firebaseAuth;
  late FireStoreData _fireStoreData;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late PhoneNumber personNumber;

  @override
  void initState() {
    _firebaseAuth = FirebaseAuthentication();
    _fireStoreData = FireStoreData();
    user = auth.currentUser;
    if (kDebugMode) {
      print('the current user + $user');
    }
    nameController.text = (user!.displayName != null) ? user!.displayName! : 'Welcome User';
    emailController.text = user!.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuthentication firebaseAuth = FirebaseAuthentication();
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
              'Please Add Your Phone Number',
              textAlign: TextAlign.center,
              style: regularBoldTextStyle1(),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: IntlPhoneField(
                controller: phoneNumController,
                decoration: InputDecoration(
                  hintText: Constants.phone,
                  hintStyle: regularTextStyle(color: AppColor.defaultWhite),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: AppColor.iconBlue,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                      color: AppColor.iconBlue,
                      width: 2,
                    ),
                  ),
                ),
                initialCountryCode: 'AU',
                onChanged: (phone) {
                  debugPrint(phone.completeNumber);
                  personNumber = phone;
                },
              ),
            ),
            _TextFeild(readOnly: true, controller: nameController),
            _TextFeild(readOnly: true, controller: emailController),
            AppButton(
              onPressed: () async {
                String phoneNumber = personNumber.completeNumber;

                String response = await _firebaseAuth.updateInitialProfile(nameController.text, emailController.text);
                _fireStoreData.uploadingData(phoneNumber, emailController.text);

                if (response == 'success') {
                  if (context.mounted) {
                    _fireStoreData
                        .readInitialData()
                        .then((value) => Navigator.pushNamedAndRemoveUntil(context, '/homePage', (route) => false));
                  }
                } else {
                  if (kDebugMode) {
                    print('error on sending verification email : ');
                  }
                }
              },
              boxColor: AppColor.iconBlue,
              text: 'SUBMIT',
              textColor: AppColor.defaultWhite,
            ),
          ],
        ),
      ),
    );
  }
}

class _TextFeild extends StatelessWidget {
  const _TextFeild({super.key, this.hintText, this.onChanged, this.controller, this.readOnly = false});
  final String? hintText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: regularTextStyle(color: AppColor.defaultWhite),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: AppColor.iconBlue,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: AppColor.iconBlue,
              width: 2,
            ),
          ),
        ),
        onChanged: onChanged,
        controller: controller,
      ),
    );
  }
}
