import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';

import '../flappy_bird_game.dart';
import 'components.dart';

class Ground extends SpriteComponent
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Ground() : super();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    size = Vector2(2 * gameRef.size.x, groundHeight);
    position = Vector2(0, gameRef.size.y - groundHeight);

    sprite = await Sprite.load('ground.png');

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x -= groundSpeed * dt;

    if (position.x + size.x / 2 <= 0.0) {
      position.x = 0.0;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Bird) {
      gameRef.gameOver();
    }
  }
}
