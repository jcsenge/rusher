import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusher/components/gameplay/rusher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '/models/player_data.dart';
import '../menus/pause_menu.dart';

class InfoBar extends StatelessWidget {
  static const id = 'InfoBar';

  final Rusher gameRef;

  const InfoBar(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: gameRef.playerData,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.currentScore,
                  builder: (_, score, __) {
                    return Text(
                      '${AppLocalizations.of(context)!.score} $score',
                      style: const TextStyle(fontSize: 30, color: Colors.white),
                    );
                  },
                ),
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.highScore,
                  builder: (_, highScore, __) {
                    return Text(
                      '${AppLocalizations.of(context)!.high}: $highScore',
                      style: const TextStyle(color: Colors.white),
                    );
                  },
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                gameRef.overlays.remove(InfoBar.id);
                gameRef.overlays.add(PauseMenu.id);
                gameRef.pauseEngine();
              },
              child: const Icon(Icons.pause, color: Colors.white),
            ),
            Selector<PlayerData, int>(
              selector: (_, playerData) => playerData.lives,
              builder: (_, lives, __) {
                return Row(
                  children: List.generate(3, (index) {
                    if (index < lives) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Image.asset(
                          'assets/images/flower-open.png',
                          height: 50,
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Image.asset(
                          'assets/images/flower.png',
                          height: 50,
                        ),
                      );
                    }
                  }),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
