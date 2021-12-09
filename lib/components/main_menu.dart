import 'package:flutter/material.dart';
import 'package:rusher/components/menu_wrapper.dart';
import 'package:rusher/components/rusher.dart';
import 'package:rusher/components/settings_menu.dart';

import 'infobar.dart';

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
