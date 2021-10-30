import 'package:flame/components.dart';

class World extends SpriteComponent with HasGameRef {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('scroll_bg_far.png');
    size = sprite!.originalSize;
    Vector2(sprite!.originalSize.x, sprite!.originalSize.y);
    return super.onLoad();
  }
}
