import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusher/components/menus/menu_wrapper.dart';
import '/models/player_data.dart';
import '../gameplay/infobar.dart';
import 'main_menu.dart';
import '../gameplay/rusher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PauseMenu extends StatelessWidget {
  static const id = 'PauseMenu';
  final Rusher gameRef;

  const PauseMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: gameRef.playerData,
      child: MenuWrapper(
        menuItems: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Selector<PlayerData, int>(
                selector: (_, playerData) => playerData.currentScore,
                builder: (_, score, __) {
                  return Text(
                    '${AppLocalizations.of(context)!.score} $score',
                    style: const TextStyle(fontSize: 40, color: Colors.white),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove(PauseMenu.id);
                  gameRef.overlays.add(InfoBar.id);
                  gameRef.resumeEngine();
                },
                child: Text(
                  AppLocalizations.of(context)!.resume,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove(PauseMenu.id);
                  gameRef.overlays.add(InfoBar.id);
                  gameRef.resumeEngine();
                  gameRef.reset();
                  gameRef.startGamePlay();
                },
                child: Text(
                  AppLocalizations.of(context)!.restart,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  gameRef.overlays.remove(PauseMenu.id);
                  gameRef.overlays.add(MainMenu.id);
                  gameRef.resumeEngine();
                  gameRef.reset();
                },
                child: Text(
                  AppLocalizations.of(context)!.exit,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
