import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rusher/components/gameplay/rusher.dart';
import 'package:rusher/components/login/login_page.dart';
import 'package:rusher/components/login/register.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rusher/components/menus/main_menu.dart';

import 'authorization.dart';

class EmailLogin extends StatefulWidget {
  final Rusher gameRef;
  const EmailLogin({required this.gameRef, Key? key}) : super(key: key);

  @override
  _EmailLoginState createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  final _formKey = GlobalKey<FormState>();
  bool isUserSignedIn = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.enterEmail),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!
                            .pleaseEnterSomeText;
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
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.password),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!
                            .pleaseEnterSomeText;
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
                      Text(
                        AppLocalizations.of(context)!.noAccount,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            maximumSize: const Size(120, 50)),
                        onPressed: () {
                          super.widget.gameRef.overlays.remove(LoginPage.id);
                          super.widget.gameRef.overlays.add(Register.id);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.register,
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
                                          super
                                              .widget
                                              .gameRef
                                              .overlays
                                              .remove(LoginPage.id),
                                          super
                                              .widget
                                              .gameRef
                                              .overlays
                                              .add(MainMenu.id)
                                        }
                                      else
                                        {log("Error signing in")}
                                    });
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.submit,
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
