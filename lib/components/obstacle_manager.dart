import 'dart:math';

import 'package:flame/components.dart';
import 'package:rusher/components/rusher.dart';
import 'package:rusher/models/obstacle_data.dart';

import 'obstacle.dart';

class ObstacleManager extends BaseComponent with HasGameRef<Rusher> {
  final List<ObstacleData> _data = [];
  final Random _random = Random();
  final Timer _timer = Timer(2, repeat: true);

  ObstacleManager() {
    _timer.callback = spawnRandomObstacle;
  }

  void spawnRandomObstacle() {
    final randomIndex = _random.nextInt(_data.length);
    final obstacleData = _data.elementAt(randomIndex);
    final obstacle = Obstacle(obstacleData);

    obstacle.anchor = Anchor.bottomLeft;
    obstacle.position = Vector2(
      gameRef.size.x + 32,
      gameRef.size.y - 24,
    );

    if (obstacleData.canFly) {
      final newHeight = _random.nextDouble() * 2 * obstacleData.textureSize.y;
      obstacle.position.y -= newHeight;
    }

    obstacle.size = obstacleData.textureSize/2.35/1.5+obstacleData.textureSize/2.35/2*_random.nextDouble();
    gameRef.add(obstacle);
  }

  @override
  void onMount() {
    shouldRemove = false;
    if (_data.isEmpty) {
      _data.addAll([
        ObstacleData(
          image: gameRef.images.fromCache('tree.png'),
          nFrames: 1,
          stepTime: 1,
          textureSize: Vector2(207, 382),
          speedX: 120,
          canFly: false,
        ),
        ObstacleData(
          image: gameRef.images.fromCache('tree.png'),
          nFrames: 1,
          stepTime: 1,
          textureSize: Vector2(207, 382),
          speedX: 130,
          canFly: false,
        ),
        // ObstacleData(
        //   image: gameRef.images.fromCache('Rino/Run (52x34).png'),
        //   nFrames: 6,
        //   stepTime: 0.09,
        //   textureSize: Vector2(52, 34),
        //   speedX: 150,
        //   canFly: false,
        // ),
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

  void removeAllEnemies() {
    final enemies = gameRef.components.whereType<Obstacle>();
    for (var element in enemies) {
      element.remove;
    }
  }
}