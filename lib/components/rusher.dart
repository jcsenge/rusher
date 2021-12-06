import 'package:flame/game.dart';
import 'package:hive/hive.dart';
import 'package:flame/gestures.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:rusher/components/horse.dart';

import '/models/settings.dart';
import '/models/player_data.dart';
import 'game_over_menu.dart';
import 'infobar.dart';
import 'obstacle_manager.dart';
import 'pause_menu.dart';


class Rusher extends BaseGame with TapDetector, HasCollidables {
  
  static const _imageAssets = [
    'horse.png',
    'hills-scroll.png',
    'scroll_bg_far.png',
    'tree.png',
    'plswork.png',
    'horse.png'
  ];

  late Horse _Horse;
  late Settings settings;
  late PlayerData playerData;
  late ObstacleManager _obstacleManager;
  
  @override
  Future<void> onLoad() async {

    playerData = await _readPlayerData();
    settings = await _readSettings();
    await images.loadAll(_imageAssets);
    this.viewport = FixedResolutionViewport(Vector2(360*1.5, 180*1.7));

    final parallaxBackground = await loadParallaxComponent(
      [
        ParallaxImageData('scroll_bg_far.png'),
        ParallaxImageData('hills-scroll.png'),
      ],
      baseVelocity: Vector2(7, 0),
      velocityMultiplierDelta: Vector2(1.4, 0),
    );
    add(parallaxBackground);
    _obstacleManager = ObstacleManager();
    _Horse = Horse(images.fromCache('horse.png'), playerData);
    return super.onLoad();
  }

  void startGamePlay() {
    add(_Horse);
    add(_obstacleManager);
  }

  void _disconnectActors() {
    _Horse.remove(); 
    _obstacleManager.removeAllEnemies();
    _obstacleManager.remove();
  }

  void reset() {
    _disconnectActors();
    playerData.currentScore = 0;
    playerData.lives = 5;
  }

  @override
  void update(double dt) {
    if (playerData.lives <= 0) {
      this.overlays.add(GameOverMenu.id);
      this.overlays.remove(InfoBar.id);
      this.pauseEngine();
    }
    super.update(dt);
  }
  
  @override
  void onTapDown(TapDownInfo info) {
    if (this.overlays.isActive(InfoBar.id)) {
      
      _Horse.jump();
    }
    super.onTapDown(info);
  }

  
  Future<PlayerData> _readPlayerData() async {
    final playerDataBox =
        await Hive.openBox<PlayerData>('Rusher.PlayerDataBox');
    final playerData = playerDataBox.get('Rusher.PlayerData');
    if (playerData == null) { 
      await playerDataBox.put('Rusher.PlayerData', PlayerData());
    }    
    return playerDataBox.get('Rusher.PlayerData')!;
  }

  
  Future<Settings> _readSettings() async {
    final settingsBox = await Hive.openBox<Settings>('Rusher.SettingsBox');
    final settings = settingsBox.get('Rusher.Settings');
    if (settings == null) {
      await settingsBox.put(
        'Rusher.Settings',
        Settings(bgm: true, sfx: true),
      );
    }
    return settingsBox.get('Rusher.Settings')!;
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!(this.overlays.isActive(PauseMenu.id)) &&
            !(this.overlays.isActive(GameOverMenu.id))) {
          this.resumeEngine();
        }
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:    
        if (this.overlays.isActive(InfoBar.id)) {
          this.overlays.remove(InfoBar.id);
          this.overlays.add(PauseMenu.id);
        }
        this.pauseEngine();
        break;
    }
    super.lifecycleStateChange(state);
  }
}
