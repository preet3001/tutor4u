import 'package:flutter/material.dart';
import 'package:tutor4u/constants.dart';
import 'package:tutor4u/services/authentication.dart';

import 'center_page.dart';

// ignore: camel_case_types
class login_Page extends StatefulWidget {
  static const String id = 'login_page';
  @override
  _login_PageState createState() => _login_PageState();
}

// ignore: camel_case_types
class _login_PageState extends State<login_Page> {
  String email;
  String password;
  final authentication auth = authentication();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:Text(
          'login',
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            keyboardType: TextInputType.emailAddress,

            textAlign: TextAlign.center,
            onChanged: (value) {
              email = value;
            },
            decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
          ),
          TextField(
            obscureText: true,
            textAlign: TextAlign.center,
            onChanged: (value) {
              password = value;
            },
            decoration:
                kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
          ),
          RaisedButton(
            child: Text('login'),
            onPressed: null,
          ),
          RaisedButton(
            child: Text('Sign in from Google'),
            onPressed: () async {
              await auth.signinwithgoogle();
              Navigator.pushNamed(context, CenterPage.id);
            },
          ),
        ],
      ),
    );
  }
}
