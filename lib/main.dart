import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rusher/components/login/login.dart';

import 'components/menus/game_over_menu.dart';
import 'components/gameplay/infobar.dart';
import 'components/menus/main_menu.dart';
import 'components/menus/pause_menu.dart';
import 'components/gameplay/rusher.dart';
import 'components/menus/settings_menu.dart';
import 'models/player_data.dart';
import 'models/settings.dart';

Rusher _rusher = Rusher();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  await initHive();
  runApp(const RusherApp());
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
  const RusherApp({Key? key}) : super(key: key);
  final RusherGame rusherGame = const RusherGame();
  final Login login = const Login();

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
            fixedSize: const Size(200, 60),
          ),
        ),
      ),
      home: login,
    );
  }
}

class RusherGame extends StatelessWidget {
  const RusherGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        loadingBuilder: (conetxt) => const Center(
          child: SizedBox(
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
        initialActiveOverlays: const [MainMenu.id],
        game: _rusher,
      ),
    );
  }
}
