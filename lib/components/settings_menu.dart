import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusher/components/menu_wrapper.dart';
import 'package:rusher/components/rusher.dart';

import '/models/settings.dart';
import 'main_menu.dart';

class SettingsMenu extends StatelessWidget {
  static const id = 'SettingsMenu';
  final Rusher gameRef;

  const SettingsMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: gameRef.settings,
      child: MenuWrapper(
        asd: TextButton(
          onPressed: () {
            gameRef.overlays.remove(SettingsMenu.id);
            gameRef.overlays.add(MainMenu.id);
          },
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.arrow_back_ios_rounded),
            Text(
              "Back",
              style: TextStyle(fontSize: 30),
            ),
          ]),
        ),
      ),
    );
  }
}
