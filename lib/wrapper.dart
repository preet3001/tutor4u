import 'package:flutter/material.dart';
import 'package:tutor4u/screens/center_page.dart';
import 'package:tutor4u/services/authentication.dart';
import 'screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class wrapper extends StatelessWidget {
  static const String id = 'wrapper';
  @override
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
