import 'package:flutter/material.dart';
import 'package:tutor4u/services/authentication.dart';
import 'package:flutter/cupertino.dart';
import 'MatchCard.dart';
// ignore: camel_case_types
class home_Page extends StatefulWidget {
  static const String id = 'home_page';
  @override
  _home_PageState createState() => _home_PageState();
}

// ignore: camel_case_types
class _home_PageState extends State<home_Page> {
  final authentication auth = authentication();


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
      body:(
    Child: Stack(
      alignment: Alignment.center,
          children: _getMatchCard(),
      ),
    );
    }
    void setState(Null Function() param0) {
    }
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RaisedButton(
                child: Text('profile'),
                onPressed: () {
                  Navigator.pushNamed(context, Profile_Page.id);
                }),
            RaisedButton(
                child: Text('SIGN OUT'),
                onPressed: () async {
                  await auth.signoutgoogle();
                  Navigator.pushNamed(context, login_Page.id);
                })
          ],
        ),
      ),
    );
  }
}

