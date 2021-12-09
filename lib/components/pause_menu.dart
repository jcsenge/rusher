import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusher/components/menu_wrapper.dart';
import '/models/player_data.dart';
import 'infobar.dart';
import 'main_menu.dart';
import 'rusher.dart';
class PauseMenu extends StatelessWidget {

  static const id = 'PauseMenu';
  final Rusher gameRef;

  const PauseMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: gameRef.playerData,
      child: MenuWrapper(
        asd: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Selector<PlayerData, int>(
                selector: (_, playerData) => playerData.currentScore,
                builder: (_, score, __) {
                  return Text(
                    'Score: $score',
                    style: const TextStyle(fontSize: 40, color: Colors.blue),
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () {
                gameRef.overlays.remove(PauseMenu.id);
                gameRef.overlays.add(InfoBar.id);
                gameRef.resumeEngine();
              },
              child: const Text(
                'Resume',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                gameRef.overlays.remove(PauseMenu.id);
                gameRef.overlays.add(InfoBar.id);
                gameRef.resumeEngine();
                gameRef.reset();
                gameRef.startGamePlay();
              },
              child: const Text(
                'Restart',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                gameRef.overlays.remove(PauseMenu.id);
                gameRef.overlays.add(MainMenu.id);
                gameRef.resumeEngine();
                gameRef.reset();
              },
              child: const Text(
                'Exit',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
