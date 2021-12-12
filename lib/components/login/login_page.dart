import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rusher/components/gameplay/rusher.dart';
import 'package:rusher/components/login/email_login.dart';
import 'package:rusher/components/menus/main_menu.dart';
import 'package:rusher/components/menus/menu_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return Material(
      color: Colors.brown[800],
      child: MenuWrapper(
        menuItems: Center(
          child: SizedBox(
            height: 400,
            width: 500,
            child: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(
                  width: double.maxFinite,
                  height: 350,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      EmailLogin(
                        gameRef: gameRef,
                      ),
                      if (!kIsWeb)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.logInWith}: ',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            IconButton(
                              onPressed: () async => {
                                await signInWithGoogle(_googleSignIn, _auth),
                                gameRef.overlays.remove(LoginPage.id),
                                gameRef.overlays.add(MainMenu.id)
                              },
                              iconSize: 50,
                              icon: SvgPicture.asset(
                                  'assets/images/google_btn.svg'),
                            ),
                          ],
                        )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
