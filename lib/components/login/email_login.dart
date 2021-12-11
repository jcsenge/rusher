import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rusher/components/gameplay/rusher.dart';
import 'package:rusher/components/login/login_page.dart';
import 'package:rusher/components/login/register.dart';
import 'package:rusher/components/menus/main_menu.dart';

import 'authorization.dart';

class EmailLogin extends StatefulWidget {
  final Rusher gameRef;
  const EmailLogin({required this.gameRef, Key? key}) : super(key: key);

  @override
  _EmailLoginState createState() => _EmailLoginState(gameRef);
}

class _EmailLoginState extends State<EmailLogin> {
  final Rusher gameRef;
  final _formKey = GlobalKey<FormState>();
  bool isUserSignedIn = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _EmailLoginState(this.gameRef);

  void initApp() async {
    checkIfUserIsSignedIn(_googleSignIn, _auth);
  }

  void checkSignedIn() async {
    setState(() {
      isUserSignedIn = checkIfUserIsSignedIn(_googleSignIn, _auth) != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: _emailController,
                    decoration:
                        const InputDecoration(labelText: 'Enter your email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: SizedBox(
                  height: 60,
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Text(
                        "No account? Register:",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            maximumSize: const Size(100, 50)),
                        onPressed: () {
                          gameRef.overlays.remove(LoginPage.id);
                          gameRef.overlays.add(Register.id);
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            maximumSize: const Size(100, 50)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            signInWithEmailAndPassword(_emailController.text,
                                    _passwordController.text)
                                .then((value) => {
                                      if (value != null)
                                        {
                                          gameRef.overlays.remove(LoginPage.id),
                                          gameRef.overlays.add(MainMenu.id)
                                        }
                                      else
                                        {log("Error signing in")}
                                    });
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        )
      ],
    );
  }
}
