import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.black.withAlpha(100),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Selector<Settings, bool>(
                      selector: (_, settings) => settings.bgm,
                      builder: (context, bgm, __) {
                        return SwitchListTile(
                          title: Text(
                            'Music',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          value: bgm,
                          onChanged: (bool value) {
                            Provider.of<Settings>(context, listen: false).bgm =
                                value;
                          },
                        );
                      },
                    ),
                    Selector<Settings, bool>(
                      selector: (_, settings) => settings.sfx,
                      builder: (context, sfx, __) {
                        return SwitchListTile(
                          title: Text(
                            'Effects',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          value: sfx,
                          onChanged: (bool value) {
                            Provider.of<Settings>(context, listen: false).sfx =
                                value;
                          },
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        gameRef.overlays.remove(SettingsMenu.id);
                        gameRef.overlays.add(MainMenu.id);
                      },
                      child: Icon(Icons.arrow_back_ios_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
