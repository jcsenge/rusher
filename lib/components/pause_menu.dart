import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/player_data.dart';
import 'hud.dart';
import 'main_menu.dart';
import 'rusher.dart';

// This represents the pause menu overlay.
class PauseMenu extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = 'PauseMenu';

  // Reference to parent game.
  final Rusher gameRef;

  const PauseMenu(this.gameRef, {Key? key}) : super(key: key);

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
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Selector<PlayerData, int>(
                        selector: (_, playerData) => playerData.currentScore,
                        builder: (_, score, __) {
                          return Text(
                            'Score: $score',
                            style: TextStyle(fontSize: 40, color: Colors.white),
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        gameRef.overlays.remove(PauseMenu.id);
                        gameRef.overlays.add(Hud.id);
                        gameRef.resumeEngine();
                      
                      },
                      child: Text(
                        'Resume',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        gameRef.overlays.remove(PauseMenu.id);
                        gameRef.overlays.add(Hud.id);
                        gameRef.resumeEngine();
                        gameRef.reset();
                        gameRef.startGamePlay();
                        
                      },
                      child: Text(
                        'Restart',
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        gameRef.overlays.remove(PauseMenu.id);
                        gameRef.overlays.add(MainMenu.id);
                        gameRef.resumeEngine();
                        gameRef.reset();
                       
                      },
                      child: Text(
                        'Exit',
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
      ),
    );
  }
}
