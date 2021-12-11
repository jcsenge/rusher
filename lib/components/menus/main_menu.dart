import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rusher/components/login/login_page.dart';
import 'package:rusher/components/menus/menu_wrapper.dart';
import 'package:rusher/components/gameplay/rusher.dart';
import 'package:rusher/components/menus/settings_menu.dart';

import '../gameplay/infobar.dart';

class MainMenu extends StatelessWidget {
  static const id = 'MainMenu';
  final Rusher gameRef;

  const MainMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    return MenuWrapper(
      menuItems: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Rusher",
            style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.w800,
                color: Colors.brown[200]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(80, 50)),
              onPressed: () {
                gameRef.startGamePlay();
                gameRef.overlays.remove(MainMenu.id);
                gameRef.overlays.add(InfoBar.id);
              },
              child: const Text(
                'Play',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(80, 50)),
              onPressed: () {
                gameRef.overlays.remove(MainMenu.id);
                gameRef.overlays.add(SettingsMenu.id);
              },
              child: const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(80, 50)),
              onPressed: () {
                auth.signOut().then((value) => {
                      gameRef.overlays.remove(MainMenu.id),
                      gameRef.overlays.add(LoginPage.id),
                    });
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
