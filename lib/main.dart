import 'package:flutter/material.dart';
import 'package:tutor4u/screens/center_page.dart';
import 'package:tutor4u/screens/home.dart';
import 'package:tutor4u/screens/profile_page.dart';
import 'package:tutor4u/screens/registration_page.dart';
import 'package:tutor4u/wrapper.dart';
import 'screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(tutor4u());
}

// ignore: camel_case_types
class tutor4u extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      initialRoute: wrapper.id,
      routes: {
        login_Page.id: (context) => login_Page(),
        Registration_Page.id: (context) => Registration_Page(),
        wrapper.id: (context) => wrapper(),
        home_Page.id: (context) => home_Page(),
        Profile_Page.id: (context) => Profile_Page(),
        CenterPage.id: (context) =>CenterPage(),
      },
    );
  }
}
