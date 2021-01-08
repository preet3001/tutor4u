import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tutor4u/screens/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class teacher_profile extends StatelessWidget {
  static const String id = 'teacher_profile';
  final teacherid;
  final firestoreInstance = FirebaseFirestore.instance;
  var firebaseUser = FirebaseAuth.instance.currentUser;
  teacher_profile({Key key,  this.teacherid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Teacher Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white70,
          child: Column(
            children: [
              Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
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
          ),
        ),
      ),
    );
  }
  Widget buildItem(BuildContext context, DocumentSnapshot document) {
    if (document.data()['id']==teacherid ) {
      return Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(document.data()['photoUrl']),
                radius: 100,
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 500.0,
              child: Divider(
                color: Colors.black,
              ),
            ),
            FlatButton(
              child: Icon(Icons.message_rounded),
              onPressed: (){
                print('teacher id : $teacherid');
                Navigator.push(context, MaterialPageRoute(builder: (context){return Chat(peerId: document.data()['id'],peerAvatar:document.data()['photoUrl'] ,);}));              },
            ),
            SizedBox(
              height: 20.0,
              width: 500.0,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Teaching Subjects',
                style: TextStyle(
                  fontSize: 30
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 500.0,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Text(
              ' ${document.data()['Subjects']}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 500.0,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Qualification',
                style: TextStyle(
                    fontSize: 30
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 500.0,
              child: Divider(
                color: Colors.black,
              ),
            ),
            Text(
              ' ${document.data()['Qualification']}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 20.0,
              width: 500.0,
              child: Divider(
                color: Colors.black,
              ),
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),

      );
    } else {
      return Container();
    }
  }
}
