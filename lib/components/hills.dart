import 'package:flame/components.dart';

class Hills extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    position.x=gameRef.canvasSize.x;
    position.y=gameRef.canvasSize.y*0.7;
    sprite = await gameRef.loadSprite('hills-scroll.png');
    size = sprite!.originalSize;
    Vector2(sprite!.originalSize.x, sprite!.originalSize.y);
    return super.onLoad();
  }
}
