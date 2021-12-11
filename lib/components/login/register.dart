import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rusher/components/gameplay/rusher.dart';
import 'package:rusher/components/menus/menu_wrapper.dart';

import 'authorization.dart';
import 'login_page.dart';

class Register extends StatefulWidget {
  static const id = 'Register';
  final Rusher gameRef;
  const Register(this.gameRef, {Key? key}) : super(key: key);

  @override
  RegisterState createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isUserSignedIn = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();
  late bool success;
  late String userEmail;

  @override
  void initState() {
    super.initState();
    initApp();
  }

  void initApp() async {
    checkSignIn();
  }

  void checkSignIn() async {
    setState(() {
      isUserSignedIn = checkIfUserIsSignedIn(_googleSignIn, _auth) != null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.brown[800],
      child: MenuWrapper(
        menuItems: Center(
          child: SizedBox(
            width: 400,
            child: ListView(
              shrinkWrap: true,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Form(
                        key: _formKey,
                        child: Center(
                          child: SizedBox(
                            width: 400,
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  height: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                          labelText: 'Enter your email'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter some text';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: TextFormField(
                                      obscureText: true,
                                      controller: _passwordController,
                                      decoration: const InputDecoration(
                                          labelText: 'Password'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        if (value !=
                                            _passwordConfirmController.text) {
                                          return 'The passwords did not match.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 60,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0),
                                    child: TextFormField(
                                      obscureText: true,
                                      controller: _passwordConfirmController,
                                      decoration: const InputDecoration(
                                          labelText: 'Password again'),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        if (value != _passwordController.text) {
                                          return 'The passwords did not match.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0, right: 5),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          maximumSize: const Size(150, 50),
                                        ),
                                        onPressed: () {
                                          super
                                              .widget
                                              .gameRef
                                              .overlays
                                              .remove(Register.id);
                                          super
                                              .widget
                                              .gameRef
                                              .overlays
                                              .add(LoginPage.id);
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          maximumSize: const Size(150, 50),
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _register();
                                          }
                                        },
                                        child: const Text(
                                          'Register',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black87),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() async {
    final User? user = (await _auth
            .createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            )
            // ignore: invalid_return_type_for_catch_error
            .catchError((error) => {log("Error registering user")}))
        .user;
    if (user != null) {
      setState(() {
        success = true;
        super.widget.gameRef.overlays.remove(Register.id);
        super.widget.gameRef.overlays.add(LoginPage.id);
      });
    } else {
      setState(() {
        success = true;
      });
    }
  }
}
