import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor4u/screens/pro.dart';
import 'package:tutor4u/screens/login_page.dart';
import 'package:tutor4u/screens/profile_page.dart';
import 'package:tutor4u/services/authentication.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: camel_case_types
class home_Page extends StatefulWidget {
  static const String id = 'home_page';
  final String currentUserId;

  home_Page({Key key,  this.currentUserId}) : super(key: key);
  @override
  _home_PageState createState() => _home_PageState(currentUserId: currentUserId);
}

// ignore: camel_case_types
class _home_PageState extends State<home_Page> {
  final authentication auth = authentication();
  _home_PageState({Key key,  this.currentUserId});
  final String currentUserId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SUTA',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.white12,
      ),
      backgroundColor: Colors.white70,
      body: WillPopScope(
        onWillPop: null,
        child: Stack(
            children: <Widget>[
        // List
        Container(
        child: StreamBuilder(
            stream:
            FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            );
          } else {
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
    )
      ),
    );
  }
  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    if (document.data()['id'] == currentUserId) {
      return Container();
    } else {
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
            Navigator.pushNamed(context, teacher_profile.id);
          },
          color: Colors.red,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    }
  }
}
