import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:one_in_million/models/global.dart';
import 'package:one_in_million/screens/login_page.dart';
import 'package:one_in_million/services/firebase_auth.dart';
import 'package:one_in_million/utils/colors.dart';
import 'package:one_in_million/utils/constants.dart';
import 'package:one_in_million/utils/internet_connectivity.dart';
import 'package:one_in_million/utils/message_notifier.dart';
import 'package:one_in_million/utils/text_style.dart';
import 'package:one_in_million/widgets/app_button.dart';
import 'package:one_in_million/widgets/app_text_button.dart';
import 'package:one_in_million/widgets/back_button.dart';

import '../widgets/textField.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late FirebaseAuthentication _firebaseAuth;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String password = '';
  String confirmPassword = '';

  bool showPassword = false;
  bool showConfirmPassword = false;

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    late Flush flush;
    Globals.context = context;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppBackButton(),
                  Text(
                    Constants.letsGetStarted,
                    style: regularBoldTextStyle1(),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AppTextField(
                    controller: nameController,
                    textFieldIcon: Icon(
                      Icons.person,
                      color: AppColor.iconBlue,
                    ),
                    hintText: Constants.name,
                  ),
                  AppTextField(
                    controller: emailController,
                    textFieldIcon: Icon(
                      Icons.email,
                      color: AppColor.iconBlue,
                    ),
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
                        PasswordFeild(
                          controller: confirmPasswordController,
                          onChanged: (value) {
                            confirmPassword = value!;
                          },
                          validate: (value) {
                            if (value != null && value.isEmpty) {
                              return 'Please Re-Enter New Password';
                            } else if (value!.length < 8) {
                              return "Password must be atleast 8 characters long";
                            } else if (value != password) {
                              return 'Password must be same as above';
                            }
                            return null;
                          },
                          textFieldIcon: Icon(
                            showConfirmPassword ? Icons.visibility : Icons.visibility_off,
                            color: AppColor.iconBlue,
                          ),
                          isPasswordField: !showConfirmPassword,
                          onPressed: () {
                            setState(() {
                              if (kDebugMode) {
                                print(showConfirmPassword);
                              }
                              showConfirmPassword = !showConfirmPassword;
                            });
                          },
                          hintText: Constants.confirmPassword,
                        ),
                      ])),
                  AppButton(
                    onPressed: () async {
                      late Flush flush;
                      if (await getInternetUsingInternetConnectivity()) {
                        if (_formKey.currentState!.validate()) {
                          String response = await _firebaseAuth.registration(emailController.text,
                              passwordController.text, nameController.text, phoneNumController.text);
                          if (response == 'success') {
                            if (context.mounted) {
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
                            }
                          } else {
                            if (kDebugMode) {
                              print('---->>>>>error response: $response');
                            }
                          }
                        }
                      } else {
                        flush = Flush(context);
                        flush.message(Constants.noInternet);
                      }
                    },
                    boxColor: AppColor.iconBlue,
                    text: Constants.create,
                    textColor: AppColor.defaultWhite,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextButton(
                        onPressed: () {},
                        text: Constants.alreadyHaveAnAccount,
                      ),
                      AppTextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: Constants.loginHere,
                        textColor: AppColor.iconBlue,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordFeild extends StatelessWidget {
  const PasswordFeild({
    super.key,
    required this.controller,
    required this.textFieldIcon,
    required this.hintText,
    this.decoration = true,
    this.onPressed,
    this.isPasswordField = false,
    this.readOnly = false,
    this.validate,
    this.onChanged,
  });
  final TextEditingController controller;
  final Icon textFieldIcon;
  final String hintText;
  final bool decoration;
  final VoidCallback? onPressed;
  final bool isPasswordField;
  final bool readOnly;
  final String? Function(String?)? validate;
  final String? Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    bool obscureText = false;
    bool enableSuggestions = true;
    bool autoCorrect = true;

    if (isPasswordField) {
      obscureText = true;
      enableSuggestions = false;
      autoCorrect = false;
    }
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextFormField(
        onChanged: onChanged,
        validator: validate,
        controller: controller,
        readOnly: readOnly,
        obscureText: obscureText,
        enableSuggestions: enableSuggestions,
        autocorrect: autoCorrect,
        style: regularBoldTextStyle(color: AppColor.iconBlue),
        decoration: (decoration)
            ? InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: AppColor.defaultGrey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(
                    color: AppColor.iconBlue,
                    width: 2,
                  ),
                ),
                prefixIcon: IconButton(onPressed: onPressed, icon: textFieldIcon),
                hintText: hintText,
                hintStyle: regularTextStyle(color: AppColor.defaultWhite),
              )
            : InputDecoration(
                prefixIcon: IconButton(onPressed: onPressed, icon: textFieldIcon),
                hintText: hintText,
                hintStyle: regularTextStyle(color: AppColor.defaultWhite),
              ),
      ),
    );
  }
}
