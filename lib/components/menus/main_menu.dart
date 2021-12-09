import 'package:flutter/material.dart';
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
    return MenuWrapper(
      asd: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Rusher",
            style: TextStyle(fontSize: 50, color: Colors.blue[900]),
          ),
          TextButton(
            onPressed: () {
              gameRef.startGamePlay();
              gameRef.overlays.remove(MainMenu.id);
              gameRef.overlays.add(InfoBar.id);
            },
            child: const Text(
              'Play',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              gameRef.overlays.remove(MainMenu.id);
              gameRef.overlays.add(SettingsMenu.id);
            },
            child: const Text(
              'Settings',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
