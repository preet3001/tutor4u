import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tutor4u/screens/center_page.dart';
import 'package:tutor4u/screens/home.dart';
//import 'package:tutor4u/constants.dart';

class Profile_Page extends StatefulWidget {
  static const String id = 'Profile_Page';
  @override
  _Profile_PageState createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final QualificationController = TextEditingController();
  final DBRef = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.teal,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: "Enter Name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Name';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: QualificationController,
                      decoration: InputDecoration(
                        labelText: "Enter Qualification",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Qualification';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.lightBlue,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                DBRef.push().set({
                                  "name": nameController.text,
                                  "Qualification": QualificationController.text,
                                }).then((_) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Successfully Added')));
                                  nameController.clear();
                                  QualificationController.clear();
                                }).catchError((onError) {
                                  Scaffold.of(context).showSnackBar(
                                      SnackBar(content: Text(onError)));
                                });
                              }
                            },
                            child: Text('Submit'),
                          ),
                          RaisedButton(
                            color: Colors.amber,
                            onPressed: () {
                              Navigator.pushNamed(context, CenterPage.id);
                            },
                            child: Text('Navigate'),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
