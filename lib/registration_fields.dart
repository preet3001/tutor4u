import 'package:flutter/material.dart';
import 'package:tutor4u/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'services/authentication.dart';

class Fields extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  final DBRef = FirebaseDatabase.instance.reference();
  Fields({@required this.text, this.inti});
  final String text;
  final int inti;
  authentication auth = authentication();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Expanded(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Text(
                text,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 5,
              child: TextFormField(
                controller: nameController,
                textAlign: TextAlign.end,
                onFieldSubmitted: (value) {
                  DBRef.push().set({text: value});
                },
                decoration: kTextFieldDecoration,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'enter value';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
