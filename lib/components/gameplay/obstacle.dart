import 'package:flame/geometry.dart';
import 'package:flame/components.dart';
import 'package:rusher/components/gameplay/rusher.dart';
import 'package:rusher/models/obstacle_data.dart';

class Obstacle extends SpriteAnimationComponent
    with Hitbox, Collidable, HasGameRef<Rusher> {
  final ObstacleData obstacleData;

  Obstacle(this.obstacleData) {
    animation = SpriteAnimation.fromFrameData(
      obstacleData.image,
      SpriteAnimationData.sequenced(
        amount: obstacleData.nFrames,
        stepTime: obstacleData.stepTime,
        textureSize: obstacleData.textureSize,
      ),
    );
  }

  @override
  void onMount() {
    final shape = HitboxRectangle(relation: Vector2.all(0.8));
    addShape(shape);
    size *= 0.6;
    super.onMount();
  }

  @override
  void update(double dt) {
    position.x -= obstacleData.speedX * dt;

    if (position.x < -obstacleData.textureSize.x) {
      remove();
      gameRef.playerData.currentScore += 1;
    }

    super.update(dt);
  }
}