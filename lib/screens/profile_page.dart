import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:one_in_million/models/global.dart';
import 'package:one_in_million/services/firebase_auth.dart';
import 'package:one_in_million/services/firestore_data.dart';
import 'package:one_in_million/utils/colors.dart';
import 'package:one_in_million/utils/constants.dart';
import 'package:one_in_million/utils/internet_connectivity.dart';
import 'package:one_in_million/utils/message_notifier.dart';
import 'package:one_in_million/utils/text_style.dart';
import 'package:one_in_million/widgets/app_button.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  late FirebaseAuthentication _firebaseAuth;
  FirebaseAuth auth = FirebaseAuth.instance;
  late FireStoreData _fireStoreData;
  User? user;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late PhoneNumber personNumber;

  String password = '';

  RegExp passwordValidation = RegExp(r"(?=.*\W)(?=.*[A-Z])");
  //A function that validate when user entered password
  bool validatePassword(String pass) {
    String password = pass.trim();
    if (passwordValidation.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

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
    Globals.context = context;
    phoneNumController.text = user!.phoneNumber ?? '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
            child: Text(
          'Edit Profile',
          style: TextStyle(color: AppColor.iconBlue),
        )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColor.iconBlue,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Icon(
            Icons.menu,
            color: Colors.white,
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          _TextFeild(readOnly: true, hintText: Globals.userData!.phoneNumber!),
          _TextFeild(controller: nameController),
          _TextFeild(readOnly: true, controller: emailController),
          Form(
              key: _formKey,
              child: Column(children: [
                _TextFeild(
                  onChanged: (value) {
                    password = value;
                  },
                  validate: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Please Enter New Password';
                    } else if (value!.length < 8) {
                      return "Password must be atleast 8 characters long";
                    } else {
                      //call function to check password
                      bool result = validatePassword(value);
                      if (result) {
                        // create account event
                        return null;
                      } else {
                        return "Password must be 1 Capital and 1 Special Character";
                      }
                    }
                  },
                  hintText: 'Enter New Password',
                  controller: passwordController,
                ),
              ])),
          const SizedBox(
            height: 10,
          ),
          AppButton(
            onPressed: () async {
              late Flush flush;
              if (await getInternetUsingInternetConnectivity()) {
                if (_formKey.currentState!.validate()) {
                  await _firebaseAuth.updateProfile(nameController.text, emailController.text, passwordController.text);
                }
              } else {
                flush = Flush(context);
                flush.message(Constants.noInternet);
              }
            },
            boxColor: AppColor.iconBlue,
            text: Constants.submit.toUpperCase(),
            textColor: AppColor.defaultWhite,
          ),
        ],
      ),
    );
  }
}

class _TextFeild extends StatelessWidget {
  const _TextFeild({super.key, this.hintText, this.onChanged, this.controller, this.validate, this.readOnly = false});
  final String? hintText;
  final void Function(String)? onChanged;
  final String? Function(String?)? validate;
  final TextEditingController? controller;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextFormField(
        onChanged: onChanged,
        validator: validate,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: regularTextStyle(color: AppColor.iconBlue),
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
        controller: controller,
      ),
    );
  }
}
