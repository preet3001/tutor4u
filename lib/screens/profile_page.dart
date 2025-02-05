import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tutor4u/screens/center_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tutor4u/services/location.dart';
// ignore: camel_case_types
class Profile_Page extends StatefulWidget {
  static const String id = 'Profile_Page';
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  Map Data;
  Future<dynamic> fetchUserData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document data: ${documentSnapshot.data()}');
        Data=documentSnapshot.data();
      } else {
        print('Document does not exist on the database');
      }
    });
  }
  Profile_Page(){
    fetchUserData();
  }
  @override
  _Profile_PageState createState() => _Profile_PageState(data: Data);
}

// ignore: camel_case_types
class _Profile_PageState extends State<Profile_Page> {
  _Profile_PageState({Key key, @required this.data});
  Map data;
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  String _myActivity;
  String _myActivityResult;
  final _formKey = GlobalKey<FormState>();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final areaController = TextEditingController();
  final enrollController = TextEditingController();
  final phoneController = TextEditingController();
  final adressController = TextEditingController();
  // ignore: non_constant_identifier_names
  final QualificationController = TextEditingController();
  // ignore: non_constant_identifier_names
  final SubjectsController = TextEditingController();
  // ignore: non_constant_identifier_names
  Location location = Location();
  SharedPreferences prefs;
  User currentUser;
  @override
  void initState() {
    super.initState();
    getlocation();
    firstnameController.text=data['firstname'];
    print(firstnameController.text);
    _myActivity = '';
    _myActivityResult = '';
  }
  void getlocation()async{
    await location.getCurrentLocation();
    print(location.longitude);
    print(location.latitude);
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
    bool _enabled = false;

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
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(firebaseUser.photoURL),
                      radius: 100.0,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      child: Icon(Icons.gps_fixed_sharp),
                      onPressed: (){
                        setState(() {
                          print(data['Firstname']);
                          print(location.longitude);
                          print(location.latitude);
                        });
                      },
                      disabledColor: Colors.blue,
                      focusColor: Colors.blueGrey,
                    ),
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
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: areaController,
                      decoration: InputDecoration(
                        labelText: "area in meters",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'area to search';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: enrollController,
                      decoration: InputDecoration(
                        labelText: "enroll as student or techer",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'enroll';
                        }
                        return null;
                      },
                    ),
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
                      controller: adressController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.home),
                        labelText: "Enter address",
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
                              firestoreInstance
                                  .collection("users")
                                  .doc(firebaseUser.uid)
                                  .set({
                                "Firstname": firstnameController.text,
                                "Lastname": lastnameController.text,
                                "area": areaController.text,
                                "enroll": enrollController.text,
                                "Qualification": _saveForm(),
                                "PhoneNumber": phoneController.text,
                                "Subjects": SubjectsController.text,
                                "longitude": location.longitude.toString(),
                                "lattitude": location.latitude.toString(),
                                'nickname': firebaseUser.displayName,
                                'photoUrl': firebaseUser.photoURL,
                                'id': firebaseUser.uid,
                                'createdAt': DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                'chattingWith': null,
                              });
                              Fluttertoast.showToast(msg: "Sign in success");
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
