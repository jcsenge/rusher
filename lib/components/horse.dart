import 'dart:ui';
import 'package:flame/geometry.dart';
import 'package:flame/components.dart';
import 'package:rusher/components/rusher.dart';
import '/models/player_data.dart';

enum HorseAnimationStates {
  Jump,
  Run,
  Hit,
}

final horseSizeX =  192.0;
final horseSizeY = 145.0;

class Horse extends SpriteAnimationGroupComponent<HorseAnimationStates>
    with Hitbox, Collidable, HasGameRef<Rusher> {
  static final _animationMap = {
    HorseAnimationStates.Jump: SpriteAnimationData.sequenced(
      amount: 6,
      stepTime: 0.19,
      textureSize: Vector2(horseSizeX,horseSizeY),
      texturePosition: Vector2(horseSizeX*8.0, 0),
    ),
    HorseAnimationStates.Run: SpriteAnimationData.sequenced(
      amount: 7,
      stepTime: 0.15,
      textureSize: Vector2(horseSizeX,horseSizeY),
      texturePosition: Vector2(0, 0),
    ),
    HorseAnimationStates.Hit: SpriteAnimationData.sequenced(
      amount: 3,
      stepTime: 0.1,
      textureSize: Vector2(horseSizeX,horseSizeY),
      texturePosition: Vector2(horseSizeX*7.0, 0),
    ),
  };

  double yMax = 0.0;
  double speedY = 0.0;
  Timer _hitTimer = Timer(1);
  static const double GRAVITY = 800;
  final PlayerData playerData;
  bool isHit = false;
  
  Horse(Image image, this.playerData)
      : super.fromFrameData(image, _animationMap);

  @override
  void onMount() {
    this._reset();

    final shape = HitboxRectangle(relation: Vector2(0.2, 0.3));
    addShape(shape);
    yMax = this.y;

    _hitTimer.callback = () {
      this.current = HorseAnimationStates.Run;
      this.isHit = false;
    };

    super.onMount();
  }

  @override
  void update(double dt) {
    // v = u + at
    this.speedY += GRAVITY * dt;

    // d = s0 + s * t
    this.y += this.speedY * dt;

    /// This code makes sure that Horse never goes beyond [yMax].
    if (isOnGround) {
      this.y = this.yMax;
      this.speedY = 0.0;
      if ((this.current != HorseAnimationStates.Hit) &&
          (this.current != HorseAnimationStates.Run)) {
        this.current = HorseAnimationStates.Run;
      }
    }

    _hitTimer.update(dt);
    super.update(dt);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    // Call hit only if other component is an Enemy and Horse
    // is not already in hit state.
    // if ((other is Enemy) && (!isHit)) {
    //   this.hit();
    // }
    super.onCollision(intersectionPoints, other);
  }

  bool get isOnGround => (this.y >= this.yMax);

  void jump() {
    if (isOnGround) {
      this.speedY = -470;
      this.current = HorseAnimationStates.Jump;
    }
  }

  void hit() {
    this.isHit = true;
    this.current = HorseAnimationStates.Hit;
    _hitTimer.start();
    playerData.lives -= 1;
  }

  void _reset() {
    this.shouldRemove = false;
    this.anchor = Anchor.bottomLeft;
    this.position = Vector2(32, gameRef.size.y - 22);
    this.size = Vector2.all(100);
    this.current = HorseAnimationStates.Run;
    this.isHit = false;
    speedY = 0.0;
  }
}
