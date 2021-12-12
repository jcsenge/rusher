import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rusher/components/login/login_page.dart';
import 'package:rusher/components/login/register.dart';

import 'components/gameplay/infobar.dart';
import 'components/gameplay/rusher.dart';
import 'components/menus/game_over_menu.dart';
import 'components/menus/main_menu.dart';
import 'components/menus/pause_menu.dart';
import 'components/menus/settings_menu.dart';
import 'models/player_data.dart';

Rusher _rusher = Rusher();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  await initHive();
  //await dotenv.load();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      
    ),
  );
  runApp(const RusherApp());
}

Future<void> initHive() async {
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  Hive.registerAdapter<PlayerData>(PlayerDataAdapter());
}

class RusherApp extends StatelessWidget {
  const RusherApp({Key? key}) : super(key: key);
  final RusherGame rusherGame = const RusherGame();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rusher',
      theme: ThemeData(
        errorColor: Colors.redAccent,
        inputDecorationTheme:
            const InputDecorationTheme(filled: true, fillColor: Colors.white54),
        fontFamily: 'Audiowide',
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(10.0),
              fixedSize: const Size(200, 40),
              primary: Colors.white54),
        ),
      ),
      home: rusherGame,
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
          LoginPage.id: (_, Rusher gameRef) => LoginPage(gameRef),
          MainMenu.id: (_, Rusher gameRef) => MainMenu(gameRef),
          PauseMenu.id: (_, Rusher gameRef) => PauseMenu(gameRef),
          InfoBar.id: (_, Rusher gameRef) => InfoBar(gameRef),
          GameOverMenu.id: (_, Rusher gameRef) => GameOverMenu(gameRef),
          SettingsMenu.id: (_, Rusher gameRef) => SettingsMenu(gameRef),
          Register.id: (_, Rusher gameRef) => Register(gameRef),
        },
        initialActiveOverlays: const [LoginPage.id],
        game: _rusher,
      ),
    );
  }
}
