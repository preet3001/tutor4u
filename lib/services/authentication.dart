import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class authentication {
  bool isSignin;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // ignore: deprecated_member_use
  User _user;
  String email;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  Future<void> signinwithgoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // ignore: deprecated_member_use
      AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      UserCredential result = (await _auth.signInWithCredential(credential));
      _user = result.user;
      print(_user.displayName);
      isSignin = true;
      print(isSignin);
      email = _user.uid;
      print(email);
    } catch (e) {
      print(e.toString());
      isSignin = false;
    }
  }

  Future<void> signoutgoogle() async {
    try {
      await _auth.signOut().then((value) => _googleSignIn.signOut());
      print('signout success');
      isSignin = false;
      print(isSignin);
    } catch (e) {
      print(e.toString());
      isSignin = true;
    }
  }

  String getuid() {
    return email;
  }
}
