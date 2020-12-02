import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Row(
          children: [
          CircleAvatar(
          radius: 50,
          ),
            Text('name')],
        ),
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
