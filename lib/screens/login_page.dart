import 'package:flutter/material.dart';
import 'package:tutor4u/constants.dart';
import 'package:tutor4u/services/authentication.dart';
import 'registration_page.dart';
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
          style: TextStyle(
            fontFamily: 'Pacifico',
            fontSize: 30.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,

              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                password = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter your password'),
            ),
          ),
          RaisedButton(
            child: Text('login'),
            onPressed: null,
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    child: Text(
                      'register to login',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, Registration_Page.id);
                    },
                  ),
                ),
              ),
              Expanded(
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    child: Text('Sign in from Google'),
                    onPressed: () async {
                      await auth.signinwithgoogle();
                      Navigator.pushNamed(context, CenterPage.id);
                    },
                  ),
                ) ,)
            ],
          ),
        ],
      ),
    );
  }
}
