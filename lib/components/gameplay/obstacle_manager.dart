import 'dart:math';

import 'package:flame/components.dart';
import 'package:rusher/components/gameplay/rusher.dart';
import 'package:rusher/models/obstacle_data.dart';

import 'obstacle.dart';

class ObstacleManager extends BaseComponent with HasGameRef<Rusher> {
  final List<ObstacleData> _data = [];
  final Random _random = Random();
  final Timer _timer = Timer(3, repeat: true);
  final Timer _timeToGetMoreDiffcicult = Timer(30, repeat: true);

  ObstacleManager() {
    _timer.callback = spawnRandomObstacle;
    _timeToGetMoreDiffcicult.callback = getMoreDifficult;
  }

  void getMoreDifficult() {
    _data.addAll([
      ObstacleData(
        image: gameRef.images.fromCache('cloud-0.png'),
        nFrames: 1,
        stepTime: 1,
        textureSize: Vector2(150, 60),
        speedX: 180,
        canFly: true,
      ),
      ObstacleData(
        image: gameRef.images.fromCache('tree.png'),
        nFrames: 1,
        stepTime: 1,
        textureSize: Vector2(207, 382),
        speedX: 120,
        canFly: false,
      ),
    ]);
  }

  void spawnRandomObstacle() {
    final randomIndex = _random.nextInt(_data.length);
    final obstacleData = _data.elementAt(randomIndex);
    final obstacle = Obstacle(obstacleData);

    obstacle.anchor = Anchor.bottomLeft;
    obstacle.position = Vector2(
      gameRef.size.x + 32,
      gameRef.size.y - 85,
    );

    obstacle.size = obstacleData.textureSize / 2.35 / 1.5 +
        obstacleData.textureSize / 2.35 / 2 * _random.nextDouble();

    if (obstacleData.canFly) {
      obstacle.size = obstacleData.textureSize * 1.2;
      final newHeight = _random.nextDouble() * 6 * obstacleData.textureSize.y;
      obstacle.position.y -= newHeight;
    }
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
          speedX: 120,
          canFly: false,
        ),
      ]);
    }
    _timer.start();
    _timeToGetMoreDiffcicult.start();
    super.onMount();
  }

  @override
  void update(double dt) {
    _timer.update(dt);
    _timeToGetMoreDiffcicult.update(dt);
    super.update(dt);
  }

  void removeAllEnemies() {
    final enemies = gameRef.components.whereType<Obstacle>();
    for (var element in enemies) {
      element.remove;
    }
  }
}
