import 'package:flutter/material.dart';
import 'package:tutor4u/registration_fields.dart';
// ignore: camel_case_types
class Registration_Page extends StatefulWidget {
  static const String id = 'registration_page';
  @override
  _Registration_PageState createState() => _Registration_PageState();
}

// ignore: camel_case_types
class _Registration_PageState extends State<Registration_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REGISTRATION'),
      ),
      backgroundColor: Colors.teal,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Fields(
                text: 'NAME',
                inti: 1,
              ),
            ),
            Expanded(
              child: Fields(
                text: 'Qualification',
                inti: 2,
              ),
            ),
            Expanded(
              child: Fields(
                text: 'email',
                inti: 3,
              ),
            ),
            Expanded(
              child: Fields(
                text: 'NAME',
              ),
            ),
            Expanded(
              child: Fields(
                text: 'NAME',
              ),
            ),
            SizedBox(
              height: 200,
            ),
          ],
        ),
      ),
    );
  }
}
