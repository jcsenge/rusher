import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authorization.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.blue[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Rusher",
                style: TextStyle(color: Colors.blue, fontSize: 50),
              ),
            ),
            IconButton(
              onPressed: () async => {
                await signInWithGoogle(_googleSignIn, _auth),
                Navigator.pop(context),
                Navigator.pushNamed(context, '/home')
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
