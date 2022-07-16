import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuth {
  static bool _passwordCheck(String password, String confirmPassword) {
    if (password == confirmPassword) {
      return true;
    }
    return false;
  }

  static Future<User?> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      if (_passwordCheck(password, confirmPassword)) {
        UserCredential userCredential = await auth
            .createUserWithEmailAndPassword(email: email, password: password);
        user = userCredential.user;
        await user!.updateDisplayName('$firstName $lastName');
        await user.reload();
        user = auth.currentUser;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully registered!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match!'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email already in use!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Weak password!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  static Future<User?> refreshUser(User user) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await user.reload();
    User? newUser = auth.currentUser;

    return newUser;
  }
}
