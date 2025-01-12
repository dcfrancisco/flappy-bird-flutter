import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_bird/constants.dart';

import '../flappy_bird_game.dart';

class Pipe extends SpriteComponent
    with CollisionCallbacks, HasGameRef<FlappyBirdGame> {
  final bool isTopPipe;
  bool scored = false;

  Pipe(position, Vector2 size, {required this.isTopPipe})
      : super(
          size: size,
          position: position,
        );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load(isTopPipe ? 'pipe-top.png' : 'pipe-bottom.png');

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    position.x -= groundSpeed * dt;

    if (!scored && position.x + size.x < gameRef.bird.position.x) {
      scored = true;

      if (isTopPipe) {
        gameRef.increaseScore();
      }
    }

    if (position.x + size.x <= 0) {
      removeFromParent();
    }
  }
}
