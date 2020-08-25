import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:meta/meta.dart';

import 'user.dart';

class Authentication_Repo {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  Authentication_Repo({
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      // Once signed in, return the UserCredential
      await _firebaseAuth.signInWithCredential(credential);
    } on Exception {
      throw GoogleLoginFailure();
    }
  }

  Future<void> signInWithEmailPassword(
      {@required String email, @required String password}) async {
    assert(email != null && password != null);

    try {
      print('signing in with: $email and $password');
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      print(_firebaseAuth.currentUser.signedInUser.email);
    } catch (error) {
      LogInWithEmailFailure(error);
    }
  }

  User get CurrentUser {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } on Exception {
      throw SignOutFailure();
    }
  }

  Future<void> delete() async {
    try {
      await Future.wait([
        //lol
        _firebaseAuth.currentUser.delete(),
        _googleSignIn.disconnect(),
      ]);
    } on Exception {
      throw SignOutFailure();
    }
  }
}

extension on User {
  LoggedUser get signedInUser {
    return LoggedUser(
        id: uid, email: email, name: displayName, photo: photoURL);
  }
}

class SignOutFailure implements Exception {}

class GoogleLoginFailure implements Exception {}

class LogOutFailure implements Exception {}

class LogInWithEmailFailure implements Exception {
  String error;
  LogInWithEmailFailure(this.error);

  @override
  String toString() {
    // TODO: implement toString
    return 'Login failed';
  }
}

class FireBaseInitFailure implements Exception {}
