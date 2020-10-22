import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tutor4u/constants.dart';

class Profile_Page extends StatefulWidget {
  static const String id = 'Profile_Page';
  @override
  _Profile_PageState createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final DBRef = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REGISTRATION'),
      ),
      backgroundColor: Colors.teal,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text(
                          'NAME',
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: nameController,
                          textAlign: TextAlign.end,
                          decoration: kTextFieldDecoration,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'enter value';
                            }
                            return null;
                          },
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'email',
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: emailController,
                          textAlign: TextAlign.end,
                          decoration: kTextFieldDecoration,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'enter value';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 200,
                      ),
                      RaisedButton(
                          color: Colors.lightBlue,
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              DBRef.push().set({
                                "name": nameController.text,
                                "email": emailController.text,
                              }).then((_) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Successfully Added')));
                                emailController.clear();
                                nameController.clear();
                              }).catchError((onError) {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text(onError)));
                              });
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
