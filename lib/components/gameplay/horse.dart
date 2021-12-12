import 'dart:ui';
import 'package:flame/geometry.dart';
import 'package:flame/components.dart';
import 'package:rusher/components/gameplay/obstacle.dart';
import 'package:rusher/components/gameplay/rusher.dart';
import '/models/player_data.dart';

enum HorseAnimationStates {
  jump,
  run,
  hit,
}

const horseSizeX = 192.0;
const horseSizeY = 145.0;

class Horse extends SpriteAnimationGroupComponent<HorseAnimationStates>
    with Hitbox, Collidable, HasGameRef<Rusher> {
  static final _animationMap = {
    HorseAnimationStates.jump: SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.19,
      textureSize: Vector2(horseSizeX, horseSizeY),
      texturePosition: Vector2(horseSizeX * 8.0, 0),
    ),
    HorseAnimationStates.run: SpriteAnimationData.sequenced(
      amount: 7,
      stepTime: 0.15,
      textureSize: Vector2(horseSizeX, horseSizeY),
      texturePosition: Vector2(0, 0),
    ),
    HorseAnimationStates.hit: SpriteAnimationData.sequenced(
      amount: 1,
      stepTime: 0.1,
      textureSize: Vector2(horseSizeX, horseSizeY),
      texturePosition: Vector2(horseSizeX * 7.0, 0),
    ),
  };

  double yMax = 0.0;
  double speedY = 0.0;
  final Timer _hitTimer = Timer(1);
  static const double gravity = 800;
  final PlayerData playerData;
  bool isHit = false;

  Horse(Image image, this.playerData)
      : super.fromFrameData(image, _animationMap);

  @override
  void onMount() {
    _reset();

    final shape = HitboxRectangle(relation: Vector2(0.2, 0.3));
    addShape(shape);
    yMax = y;

    _hitTimer.callback = () {
      current = HorseAnimationStates.run;
      isHit = false;
    };

    super.onMount();
  }

  @override
  void update(double dt) {
    speedY += gravity * dt;
    y += speedY * dt;
    if (isOnGround) {
      y = yMax;
      speedY = 0.0;
      if ((current != HorseAnimationStates.hit) &&
          (current != HorseAnimationStates.run)) {
        current = HorseAnimationStates.run;
      }
    }

    _hitTimer.update(dt);
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    // Call hit only if other component is an Enemy and Horse
    // is not already in hit state.
    if ((other is Obstacle) && (!isHit)) {
      hit();
    }
    super.onCollision(intersectionPoints, other);
  }

  bool get isOnGround => (y >= yMax);

  void jump() {
    if (isOnGround) {
      speedY = -470;
      current = HorseAnimationStates.jump;
    }
  }

  void hit() {
    isHit = true;
    current = HorseAnimationStates.hit;
    _hitTimer.start();
    playerData.lives -= 1;
  }

  void _reset() {
    shouldRemove = false;
    anchor = Anchor.bottomLeft;
    position = Vector2(32, gameRef.size.y - 85);
    size = Vector2.all(100);
    current = HorseAnimationStates.run;
    isHit = false;
    speedY = 0.0;
  }
}
