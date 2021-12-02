import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'components/game_over_menu.dart';
import 'components/infobar.dart';
import 'components/main_menu.dart';
import 'components/pause_menu.dart';
import 'components/rusher.dart';
import 'components/settings_menu.dart';
import 'models/player_data.dart';
import 'models/settings.dart';


Rusher _Rusher = Rusher();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  await initHive();
  runApp(RusherApp());
}

Future<void> initHive() async {
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  Hive.registerAdapter<PlayerData>(PlayerDataAdapter());
  Hive.registerAdapter<Settings>(SettingsAdapter());
}

class RusherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rusher',
      theme: ThemeData(
        fontFamily: 'Audiowide',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            fixedSize: Size(200, 60),
          ),
        ),
      ),
      home: Scaffold(
        body: GameWidget(
          loadingBuilder: (conetxt) => Center(
            child: Container(
              width: 200,
              child: LinearProgressIndicator(),
            ),
          ),
  
          overlayBuilderMap: {
            MainMenu.id: (_, Rusher gameRef) => MainMenu(gameRef),
            PauseMenu.id: (_, Rusher gameRef) => PauseMenu(gameRef),
            InfoBar.id: (_, Rusher gameRef) => InfoBar(gameRef),
            GameOverMenu.id: (_, Rusher gameRef) => GameOverMenu(gameRef),
            SettingsMenu.id: (_, Rusher gameRef) => SettingsMenu(gameRef),
          },
      
          initialActiveOverlays: [MainMenu.id],
          game: _Rusher,
        ),
      ),
    );
  }
}
