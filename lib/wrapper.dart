import 'package:flutter/material.dart';
import 'package:tutor4u/screens/center_page.dart';
import 'package:tutor4u/services/authentication.dart';
import 'screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class wrapper extends StatelessWidget {
  static const String id = 'wrapper';
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    try {
      authentication auth = authentication();
      if (FirebaseAuth.instance.currentUser != null) {
        return CenterPage();
      } else {
        return login_Page();
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
