import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:one_in_million/models/global.dart';
import 'package:one_in_million/utils/message_notifier.dart';

class FirebaseAuthentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  late final flush = Flush(Globals.context!);

  Future<String> registration(String userEmail, String userPassword, String userName, String userPhone) async {
    try {
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      User? user = userCredential.user;
      await user?.updateDisplayName(userName);
      await user?.sendEmailVerification();

      if (kDebugMode) {
        print('--->>>>>success registeration: ${userCredential.user}');
      }
      flush.message("Success");
      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return flush.message("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        return flush.message("The account already exists for that email.");
      }
      return flush.message(e.toString());
    }
  }

  Future<String> loginUser(String userEmail, String userPassword) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      Globals.userCredential = userCredential.user!.email;
      if (kDebugMode) {
        print('USer is : $userCredential');
      }
      if (userCredential.user!.emailVerified) {
        return 'success';
      } else {
        return 'Verify Your Email';
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        flush.message("No user found for that email.");
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        flush.message("Wrong password provided for that user.");
        return 'Wrong password provided for that user.';
      }
      return e.toString();
    }
  }

  Future<String> sendEmailVerification() async {
    try {
      User? user = _auth.currentUser;
      await user!.sendEmailVerification();
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> updateProfile(String name, String email, String password) async {
    try {
      User? user = _auth.currentUser;
      await user!.updateDisplayName(name);
      await user.updatePassword(password);
      flush.message("Profile Updated Successfully");
    } catch (e) {
      flush.message(e.toString());
      debugPrint(e.toString());
    }
  }

  Future<String> updateInitialProfile(String name, String email) async {
    try {
      User? user = _auth.currentUser;
      await user!.updateDisplayName(name);
      flush.message("Profile Updated Successfully");
      return 'success';
    } catch (e) {
      flush.message(e.toString());
      debugPrint(e.toString());
      return e.toString();
    }
  }
}
