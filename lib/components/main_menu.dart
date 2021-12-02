import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rusher/components/rusher.dart';
import 'infobar.dart';
import 'settings_menu.dart';

class MainMenu extends StatelessWidget {
  static const id = 'MainMenu';
  final Rusher gameRef;

  const MainMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.white10,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rusher',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      gameRef.startGamePlay();
                      gameRef.overlays.remove(MainMenu.id);
                      gameRef.overlays.add(InfoBar.id);
                    },
                    child: Text(
                      'Play',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      gameRef.overlays.remove(MainMenu.id);
                      gameRef.overlays.add(SettingsMenu.id);
                    },
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
