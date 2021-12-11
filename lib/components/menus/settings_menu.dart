import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusher/components/menus/menu_wrapper.dart';
import 'package:rusher/components/gameplay/rusher.dart';
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
        menuItems: TextButton(
          onPressed: () {
            gameRef.overlays.remove(SettingsMenu.id);
            gameRef.overlays.add(MainMenu.id);
          },
          child:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
            Text(
              "Back",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ]),
        ),
      ),
    );
  }
}
