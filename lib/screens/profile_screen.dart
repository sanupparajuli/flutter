import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:one_in_million/models/global.dart';
import 'package:one_in_million/models/user_profile.dart';
import 'package:one_in_million/screens/profile_page.dart';
import 'package:one_in_million/services/firebase_auth.dart';
import 'package:one_in_million/services/firestore_data.dart';
import 'package:one_in_million/utils/colors.dart';
import 'package:one_in_million/utils/constants.dart';
import 'package:one_in_million/widgets/app_button.dart';
import 'package:one_in_million/widgets/horizontal_logo.dart';
import 'package:one_in_million/widgets/responsive.dart';

import '../utils/text_style.dart';

class ProfilePages extends StatefulWidget {
  const ProfilePages({super.key});

  @override
  State<ProfilePages> createState() => _ProfilePagesState();
}

class _ProfilePagesState extends State<ProfilePages> {
  late FirebaseAuthentication _firebaseAuth;
  FirebaseAuth auth = FirebaseAuth.instance;
  late FireStoreData _fireStoreData;
  User? user;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEditable = false;
  UserData userData = UserData();

  getUserName() {
    nameController.text = user!.displayName != null ? user!.displayName! : 'Welcome User';
  }

  @override
  void initState() {
    _firebaseAuth = FirebaseAuthentication();
    user = auth.currentUser;
    _fireStoreData = FireStoreData();

    if (kDebugMode) {
      print('the current user + $user');
    }
    getUserName();
    emailController.text = user!.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String fullName = nameController.text;
    var names = fullName.split(' ');
    String firstName = names[0];
    String lastName = names[1];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: buildLogo(context),
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: AppColor.iconBlue,
            radius: 50.0,
            child: Text(
              (firstName[0] + lastName[0]).toUpperCase(),
              style: const TextStyle(
                fontFamily: 'SourceSansPro',
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            nameController.text.toUpperCase(),
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'SourceSansPro',
              color: AppColor.iconBlue,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.5,
            ),
          ),
          SizedBox(
            height: 20.0,
            width: 150,
            child: Divider(
              color: Colors.teal.shade100,
            ),
          ),
          Globals.userData!.phoneNumber!.isNotEmpty
              ? InkWell(
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.phone,
                        color: AppColor.iconBlue,
                      ),
                      title: Text(
                        Globals.userData!.phoneNumber!,
                        style: regularTextStyle(),
                      ),
                    ),
                  ),
                  onTap: () {})
              : const SizedBox.shrink(),
          InkWell(
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.email,
                  color: AppColor.iconBlue,
                ),
                title: Text(
                  emailController.text,
                  style: regularTextStyle(),
                ),
              ),
            ),
            onTap: () {},
          ),
          AppButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Profilepage()));
            },
            boxColor: AppColor.iconBlue,
            text: Constants.editProfile,
            textColor: AppColor.defaultWhite,
          ),
          const SizedBox(
            height: 10,
          ),
          AppButton(
            onPressed: () async {
              await auth.signOut();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(context, '/loginPage', (route) => false);
              }
            },
            boxColor: AppColor.iconBlue,
            text: Constants.logout,
            textColor: AppColor.defaultWhite,
          ),
          SizedBox(
            height: Responsive.height(100, context) * 15,
          )
        ],
      ),
    );
  }
}
