import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_in_million/models/global.dart';
import 'package:one_in_million/screens/appversion.dart';
import 'package:one_in_million/screens/forgot_password.dart';
import 'package:one_in_million/screens/signup_page.dart';
import 'package:one_in_million/screens/update_profile_screen.dart';
import 'package:one_in_million/services/firebase_auth.dart';
import 'package:one_in_million/services/firestore_data.dart';
import 'package:one_in_million/utils/colors.dart';
import 'package:one_in_million/utils/constants.dart';
import 'package:one_in_million/utils/internet_connectivity.dart';
import 'package:one_in_million/utils/message_notifier.dart';
import 'package:one_in_million/utils/text_style.dart';
import 'package:one_in_million/widgets/app_button.dart';
import 'package:one_in_million/widgets/app_text_button.dart';
import 'package:one_in_million/widgets/back_button.dart';
import 'package:one_in_million/widgets/horizontal_logo.dart';
import 'package:one_in_million/widgets/responsive.dart';
import 'package:one_in_million/widgets/textField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late FirebaseAuthentication _firebaseAuth;
  late FireStoreData _fireStoreData;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool isChecked = false;
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
    createOpenBox();
    _firebaseAuth = FirebaseAuthentication();
    _fireStoreData = FireStoreData();
    super.initState();
  }

  void createOpenBox() async {
    Globals.loginData = await Hive.openBox('logindata');
    getData();
  }

  void getData() async {
    if (Globals.loginData!.get('email') != null) {
      emailController.text = Globals.loginData!.get('email');
      isChecked = true;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Globals.context = context;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: Responsive.height(100, context) * 15.0,
                ),
                buildHorizontalLogo(context),
                const SizedBox(
                  height: 20,
                ),
                AppTextField(
                  controller: emailController,
                  textFieldIcon: Icon(Icons.person, color: AppColor.iconBlue),
                  hintText: Constants.email,
                ),
                Form(
                    key: _formKey,
                    child: Column(children: [
                      PasswordFeild(
                        controller: passwordController,
                        onChanged: (value) {
                          password = value!;
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
                        textFieldIcon: Icon(
                          showPassword ? Icons.visibility : Icons.visibility_off,
                          color: AppColor.iconBlue,
                        ),
                        isPasswordField: !showPassword,
                        onPressed: () {
                          setState(() {
                            if (kDebugMode) {
                              print(showPassword);
                            }
                            showPassword = !showPassword;
                          });
                        },
                        hintText: Constants.password,
                      ),
                    ])),
                Column(
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          activeColor: AppColor.iconBlue,
                          value: isChecked,
                          onChanged: (value) {
                            isChecked = !isChecked;
                            setState(() {});
                          },
                        ),
                        const Text(
                          'Remember Me',
                        ),
                        SizedBox(
                          width: Responsive.width(100, context) * 30,
                        ),
                        AppTextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: ((context) => const ForgotPassword())));
                          },
                          text: Constants.forgotPassword,
                          alignment: Alignment.topRight,
                        ),
                      ],
                    ),
                  ],
                ),
                AppButton(
                  onPressed: () async {
                    if (await getInternetUsingInternetConnectivity()) {
                      if (_formKey.currentState!.validate()) {
                        String? response;
                        if (isChecked) {
                          Globals.loginData!.put('email', emailController.value.text);
                          response = await _firebaseAuth.loginUser(
                            emailController.text,
                            passwordController.text,
                          );
                        } else {
                          response = await _firebaseAuth.loginUser(
                            emailController.text,
                            passwordController.text,
                          );
                        }

                        switch (response) {
                          case 'success':
                            final flush = Flush(context);
                            flush.message("Successful Login");
                            if (context.mounted) {
                              _fireStoreData.readUserData().then((value) {
                                try {
                                  if (Globals.userData!.uid!.isNotEmpty) {
                                    _fireStoreData.readInitialData().then((value) =>
                                        Navigator.pushNamedAndRemoveUntil(context, '/homePage', (route) => false));
                                  }
                                } catch (e) {
                                  Navigator.push(
                                      context, MaterialPageRoute(builder: ((context) => const UpdatePhoneNumber())));
                                }
                              });
                            }
                            break;
                          case 'Verify Your Email':
                            if (context.mounted) {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: ((context) => const VerifyYourEmail())));
                            }
                            break;
                          default:
                            if (kDebugMode) {
                              print('error on login auth : $e');
                            }
                        }
                      }
                    } else {
                      final flush = Flush(context);
                      flush.message(Constants.noInternet);
                    }
                  },
                  boxColor: AppColor.iconBlue,
                  text: Constants.login.toUpperCase(),
                  textColor: AppColor.defaultWhite,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppTextButton(
                      onPressed: () {},
                      text: Constants.dontHaveAnAccount,
                    ),
                    AppTextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: ((context) => const SignUpPage())));
                      },
                      text: Constants.signUp,
                      textColor: AppColor.iconBlue,
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const AppVersion()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class VerifyYourEmail extends StatelessWidget {
  const VerifyYourEmail({
    super.key,
  });

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
              Constants.yourEmailNotVerified,
              textAlign: TextAlign.center,
              style: regularBoldTextStyle1(),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              Constants.clickBelowToResendVerificationEmail,
              textAlign: TextAlign.center,
              style: regularTextStyle(),
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              onPressed: () async {
                String response = await firebaseAuth.sendEmailVerification();
                if (response == 'success') {
                  final flush = Flush(context);
                  flush.message("Email Verified");
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                } else {
                  final flush = Flush(context);
                  flush.message("Email Verification Failed");
                  if (kDebugMode) {
                    print('error on sending verification email : $e');
                  }
                }
              },
              boxColor: AppColor.iconBlue,
              text: Constants.resendEmail.toUpperCase(),
              textColor: AppColor.defaultWhite,
            ),
          ],
        ),
      ),
    );
  }
}
