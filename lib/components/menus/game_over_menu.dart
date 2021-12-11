import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusher/components/menus/menu_wrapper.dart';
import 'package:rusher/models/player_data.dart';

import '../gameplay/infobar.dart';
import 'main_menu.dart';
import '../gameplay/rusher.dart';

class GameOverMenu extends StatelessWidget {
  static const id = 'GameOverMenu';
  final Rusher gameRef;

  const GameOverMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: gameRef.playerData,
      child: MenuWrapper(
        menuItems: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Game Over :(',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.blue[900]),
            ),
            Selector<PlayerData, int>(
              selector: (_, playerData) => playerData.currentScore,
              builder: (_, score, __) {
                return Text(
                  'Score: $score',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue[900]),
                );
              },
            ),
            TextButton(
              child: const Text(
                'Restart',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              onPressed: () {
                gameRef.overlays.remove(GameOverMenu.id);
                gameRef.overlays.add(InfoBar.id);
                gameRef.resumeEngine();
                gameRef.reset();
                gameRef.startGamePlay();
              },
            ),
            TextButton(
              child: const Text(
                'Exit',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              onPressed: () {
                gameRef.overlays.remove(GameOverMenu.id);
                gameRef.overlays.add(MainMenu.id);
                gameRef.resumeEngine();
                gameRef.reset();
              },
            ),
          ],
        ),
      ),
    );
  }
}
