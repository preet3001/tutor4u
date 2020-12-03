import 'package:flutter/material.dart';
import 'package:tutor4u/screens/chat.dart';

class teacher_profile extends StatelessWidget {
  static const String id = 'teacher_profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Teacher Profile'),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white70,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
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
                Navigator.pushNamed(context, Chat.id);
              },
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
              ),
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
      ),
    );
  }
}
