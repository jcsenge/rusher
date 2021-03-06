import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';

Future<bool> checkIfUserIsSignedIn(
    GoogleSignIn _googleSignIn, FirebaseAuth _auth) async {
  var userSignedIn = false;
  if (!kIsWeb) {
     userSignedIn = await _googleSignIn.isSignedIn();
  } else {
    return false;
  }
  if (!userSignedIn) {
    bool isSignedInWithEmail = _auth.currentUser != null;
    userSignedIn = isSignedInWithEmail;
  }
  return userSignedIn;
}

FutureOr<UserCredential> signInWithGoogle(googleUser, googleAuth) async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<UserCredential> signInWithEmailAndPassword(
    String email, String password) async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  return await auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}
