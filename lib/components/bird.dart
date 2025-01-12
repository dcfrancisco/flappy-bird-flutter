import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../constants.dart';
import '../flappy_bird_game.dart';
import 'ground.dart';
import 'pipe.dart';

class Bird extends SpriteComponent with CollisionCallbacks {
  Bird()
      : super(
          position: Vector2(birdStartX, birdStartY),
          size: Vector2(birdWidth, birdHeight),
        );

  double velocity = 0.0;
  final double gravity = 400.0;
  final double jumpStrength = -300.0;
  bool isJumping = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load('bird.png');

    add(RectangleHitbox());
  }

  void flap() {
    velocity = jumpStrength;
  }

  @override
  void update(double dt) {
    super.update(dt);
    velocity += gravity * dt;
    position.y += velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Ground) {
      (parent as FlappyBirdGame).gameOver();
    }

    if (other is Pipe) {
      (parent as FlappyBirdGame).gameOver();
    }
  }
}
