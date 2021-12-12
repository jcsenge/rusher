import 'dart:math';

import 'package:flame/components.dart';
import 'package:rusher/components/gameplay/ground.dart';
import 'package:rusher/components/gameplay/rusher.dart';
import 'package:rusher/models/obstacle_data.dart';

class GroundManager extends BaseComponent with HasGameRef<Rusher> {
  final List<ObstacleData> _data = [];
  final Random _random = Random();
  final Timer _timer = Timer(3, repeat: true);

  GroundManager() {
    _timer.callback = spawnRandomObstacle;
  }

  void spawnRandomObstacle() {
    final randomIndex = _random.nextInt(_data.length);
    final groundData = _data.elementAt(randomIndex);
    final ground = Ground(groundData);

    ground.anchor = Anchor.bottomLeft;
    ground.position = Vector2(
      gameRef.size.x + 32,
      gameRef.size.y,
    );

    ground.size = groundData.textureSize;

    gameRef.add(ground);
  }

  @override
  void onMount() {
    shouldRemove = false;
    if (_data.isEmpty) {
      _data.addAll([
        ObstacleData(
          image: gameRef.images.fromCache('tile_grass.png'),
          nFrames: 1,
          stepTime: 1,
          textureSize: Vector2(375, 105),
          speedX: 120,
          canFly: false,
        ),
      ]);
    }
    _timer.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    super.update(dt);
  }

  void removeAllGroundElements() {
    final groundElements = gameRef.components.whereType<Ground>();
    for (var element in groundElements) {
      element.remove;
    }
  }
}
