import 'package:flutter/material.dart';
class teacher_profile extends StatelessWidget {
  static const String id = 'teacher_profile';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Profile'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            CircleAvatar(
              radius: 100,
            ),
            Expanded(
              child: GestureDetector(
                child: Icon(Icons.message_rounded),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
