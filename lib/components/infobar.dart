import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusher/components/rusher.dart';

import '/models/player_data.dart';
import 'pause_menu.dart';

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
                      'Score: $score',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    );
                  },
                ),
                Selector<PlayerData, int>(
                  selector: (_, playerData) => playerData.highScore,
                  builder: (_, highScore, __) {
                    return Text(
                      'High: $highScore',
                      style: TextStyle(color: Colors.white),
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
              child: Icon(Icons.pause, color: Colors.white),
            ),
            Selector<PlayerData, int>(
              selector: (_, playerData) => playerData.lives,
              builder: (_, lives, __) {
                return Row(
                  children: List.generate(5, (index) {
                    if (index < lives) {
                      return Icon(
                        Icons.favorite,
                        color: Colors.red,
                      );
                    } else {
                      return Icon(
                        Icons.favorite_border,
                        color: Colors.red,
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
