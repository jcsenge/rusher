import 'package:flame/components.dart';
import 'package:rusher/components/gameplay/rusher.dart';
import 'package:rusher/models/obstacle_data.dart';

class Ground extends SpriteAnimationComponent with HasGameRef<Rusher> {
  final ObstacleData obstacleData;

  Ground(this.obstacleData) {
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
  void update(double dt) {
    position.x -= obstacleData.speedX * dt;
    super.update(dt);
  }
}
