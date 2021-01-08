import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor4u/screens/pro.dart';
import 'package:tutor4u/screens/login_page.dart';
import 'package:tutor4u/services/authentication.dart';
import 'package:cached_network_image/cached_network_image.dart';
import'package:tutor4u/services/location.dart';

// ignore: camel_case_types
class home_Page extends StatefulWidget {
  static const String id = 'home_page';
  final String currentUserId;

  home_Page({Key key, this.currentUserId}) : super(key: key);
  @override
  _home_PageState createState() =>
      _home_PageState(currentUserId: currentUserId);
}

// ignore: camel_case_types
class _home_PageState extends State<home_Page> {
  final authentication auth = authentication();
  _home_PageState({Key key, this.currentUserId});
  final String currentUserId;
  Location location = Location();
  var firebaseUser = FirebaseAuth.instance.currentUser;
  Map<String,dynamic> Data;
  Future<dynamic> fetchUserData() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Data=documentSnapshot.data();
        print ('1234 : $Data');
        print ('longitude : ${Data['longitude']}');
        print ('latitude : ${Data['lattitude']}');

      } else {
        print('Document does not exist on the database');
      }
    });
  }
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SUTA',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.teal,
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, login_Page.id);
                },
                child: Icon(
                  Icons.logout,
                  size: 26.0,
                ),
              )
          ),
        ],
      ),
      backgroundColor: Colors.white70,
      body: WillPopScope(
          onWillPop: null,
          child: Stack(
            children: <Widget>[
              // List
              Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      print("1");
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      );
                    } else {
                      print("2");
                      return ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemBuilder: (context, index) =>
                            buildItem(context, snapshot.data.documents[index]),
                        itemCount: snapshot.data.documents.length,
                      );
                    }
                  },
                ),
              ),
            ],
          )),
    );
  }

  Widget buildItem(BuildContext context, DocumentSnapshot document,) {
    print("3");
    if (document.data()['id'] != currentUserId ) {
      print("4");
      double a=location.getDistance(double.parse(Data['lattitude']),double.parse(Data['longitude']),double.parse(document.data()['lattitude']),double.parse(document.data()['longitude']));
      double x=double.parse(document.data()['area']);
      print('value of a : $a');
      print('value of x : $x');
      if (x>=a){
        return Container(
          child: FlatButton(
            child: Row(
              children: <Widget>[
                Material(
                  child: document.data()['photoUrl'] != null
                      ? CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor:
                        AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                      width: 50.0,
                      height: 50.0,
                      padding: EdgeInsets.all(15.0),
                    ),
                    imageUrl: document.data()['photoUrl'],
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  )
                      : Icon(
                    Icons.account_circle,
                    size: 50.0,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  clipBehavior: Clip.hardEdge,
                ),
                Flexible(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Nickname: ${document.data()['nickname']}',
                            style: TextStyle(color: Colors.white),
                          ),
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                        ),
                        Container(
                          child: Text(
                            'About me: ${document.data()['aboutMe'] ?? 'Not available'}',
                            style: TextStyle(color: Colors.white),
                          ),
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(left: 20.0),
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){return teacher_profile(teacherid:document.data()['id']);}));          },
            color: Colors.teal,
            padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          ),
          margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
        );
      }
    } else {
      return Container(
      );
    }
  }
}
