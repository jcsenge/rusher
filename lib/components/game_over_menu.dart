import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rusher/models/player_data.dart';

import 'infobar.dart';
import 'main_menu.dart';
import 'rusher.dart';

class GameOverMenu extends StatelessWidget {
  static const id = 'GameOverMenu';
  final Rusher gameRef;

  const GameOverMenu(this.gameRef, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: gameRef.playerData,
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.black.withAlpha(100),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Game Over',
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                    Selector<PlayerData, int>(
                      selector: (_, playerData) => playerData.currentScore,
                      builder: (_, score, __) {
                        return Text(
                          'You Score: $score',
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        );
                      },
                    ),
                    ElevatedButton(
                      child: Text(
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
                    ElevatedButton(
                      child: Text(
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
            ),
          ),
        ),
      ),
    );
  }
}
