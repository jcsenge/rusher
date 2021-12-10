import 'dart:developer';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rusher/components/gameplay/rusher.dart';
import 'package:rusher/components/menus/main_menu.dart';

import 'authorization.dart';

class LoginPage extends StatelessWidget {
  static const id = 'LoginPage';
  final Rusher gameRef;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  LoginPage(
    this.gameRef, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    UserCredential res;
    return Material(
      child: Container(
        width: double.maxFinite,
        color: Colors.blue[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Rusher",
                style: TextStyle(color: Colors.blue, fontSize: 50),
              ),
            ),
            if (!kIsWeb)
              IconButton(
                onPressed: () async => {
                  await signInWithGoogle(_googleSignIn, _auth),
                  gameRef.overlays.remove(LoginPage.id),
                  gameRef.overlays.add(MainMenu.id)
                },
                iconSize: 80,
                icon: const Icon(Icons.ac_unit),
              ),
          ],
        ),
      ),
    );
  }
}
