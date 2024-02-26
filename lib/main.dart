import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:one_in_million/models/global.dart';
import 'package:one_in_million/screens/chat/chat.dart';
import 'package:one_in_million/screens/home_page.dart';
import 'package:one_in_million/screens/login_page.dart';
import 'package:one_in_million/screens/signup_page.dart';
import 'package:one_in_million/utils/colors.dart';

Future    main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await createOpenBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1INAMILLION',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        colorScheme: ThemeData().colorScheme.copyWith(primary: AppColor.defaultBlue),
      ),
      routes: <String, WidgetBuilder>{
        '/loginPage': (BuildContext context) => const LoginPage(),
        '/chatScreen': (BuildContext context) => const ChatDashboard(),
        '/signUpPage': (BuildContext context) => const SignUpPage(),
        '/homePage': (BuildContext context) => const HomePage(),
      },
      home: const LoginPage(),
    );
  }
}

Future<void> createOpenBox() async {
  Globals.loginData = await Hive.openBox('logindata');
}
