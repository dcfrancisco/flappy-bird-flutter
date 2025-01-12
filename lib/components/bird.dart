import 'package:flame/cache.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../constants.dart';
import '../flappy_bird_game.dart';
import 'ground.dart';
import 'pipe.dart';

class Bird extends SpriteAnimationComponent with CollisionCallbacks {
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
    var images = Images();
    final spriteSheet = await images.load('bird_spritesheet.png');
    final spriteSize = Vector2(24.0, 24.0);

    // Create the animation
    final spriteAnimation = SpriteAnimation.fromFrameData(
      spriteSheet,
      SpriteAnimationData.sequenced(
        amount: 3, // Number of frames
        stepTime: 0.1, // Time per frame
        textureSize: spriteSize,
      ),
    ); // Set the animation

    animation = spriteAnimation;

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
