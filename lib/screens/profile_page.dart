import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:tutor4u/screens/center_page.dart';
import 'package:tutor4u/services/authentication.dart';
//import 'package:tutor4u/constants.dart';

// ignore: camel_case_types
class Profile_Page extends StatefulWidget {
  static const String id = 'Profile_Page';
  @override
  _Profile_PageState createState() => _Profile_PageState();
}

// ignore: camel_case_types
class _Profile_PageState extends State<Profile_Page> {
  String _myActivity;
  String _myActivityResult;
  final _formKey = GlobalKey<FormState>();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final authentication auth = authentication();
  // ignore: non_constant_identifier_names
  final QualificationController = TextEditingController();
  // ignore: non_constant_identifier_names
  final SubjectsController = TextEditingController();
  // ignore: non_constant_identifier_names
  final DBRef = FirebaseDatabase.instance.reference();
  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
  }
  _saveForm() {
    if (_formKey.currentState.validate()) {
      setState(() {
        _myActivityResult = _myActivity;
      });
      return _myActivityResult;
    }
  }
  reset() {
    if (_myActivityResult == _myActivity) {
      setState(() {
        _myActivity = '';
        _myActivityResult = '';
      });
      return _myActivityResult;
    }
  }
  @override
  Widget build(BuildContext context) {
    bool _enabled =false;
    var menu_book;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.teal,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: firstnameController,
                            decoration: InputDecoration(
                              labelText: "First Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'First Name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: lastnameController,
                            decoration: InputDecoration(
                              labelText: "Last Name",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            // The validator receives the text that the user has entered.
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Last Name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: DropDownFormField(
                      titleText: 'Qualification',
                      hintText: 'Enter Highest Qualification',
                      value: _myActivity,
                      onSaved: (value) {
                        setState(() {
                          _myActivity = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _myActivity = value;
                        });
                      },
                      dataSource: [
                        {
                          "display": "UNDER GRADUATE",
                          "value": "UNDER GRADUATE",
                        },
                        {
                          "display": "POST GRADUATE",
                          "value": "POST GRADUATE",
                        },
                        {
                          "display": "SCHOOL",
                          "value": "SCHOOL",
                        },
                        {
                          "display": "Phd",
                          "value": "Phd",
                        },
                        {
                          "display": "DIPLOMA",
                          "value": "DIPLOMA",
                        },
                      ],
                      textField: 'display',
                      valueField: 'value',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      controller: emailController,
                      enabled: _enabled,
                      decoration: InputDecoration(
                        icon: Icon(Icons.mail_outline),
                        labelText: "Enter Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      decoration: InputDecoration(
                        hintText: 'eg - 1234',
                        icon: Icon(Icons.phone),
                        labelText: "Enter PhoneNumber",
                        border: OutlineInputBorder(
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
                    child: TextFormField(
                      controller: SubjectsController,
                      maxLines: 10,
                      decoration: InputDecoration(
                        icon: Icon(Icons.menu),
                        labelText: "Enter Teaching Subjects",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Enter Teaching Subjects';
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
                                  "Firstname": firstnameController.text,
                                  "Lastname": lastnameController.text,
                                  "Qualification": _saveForm(),
                                  "PhoneNumber": phoneController.text,
                                  "Subjects": SubjectsController.text,
                                }).then((_) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Successfully Added')));
                                  firstnameController.clear();
                                  lastnameController.clear();
                                  reset();
                                  phoneController.clear();
                                  SubjectsController.clear();
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
                            child: Text('Back To Home'),
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