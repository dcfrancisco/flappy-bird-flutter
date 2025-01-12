import 'dart:math';

import 'package:flame/components.dart';

import '../constants.dart';
import '../flappy_bird_game.dart';
import 'pipe.dart';

class PipeManager extends Component with HasGameRef<FlappyBirdGame> {
  double pipeSpawnTimer = 0;
  double timeSinceLastPipeSpawn = 0;

  @override
  void update(double dt) {
    pipeSpawnTimer += dt;
    double pipeSpawnInterval = 8.0;

    if (pipeSpawnTimer > pipeSpawnInterval) {
      pipeSpawnTimer = 0;
      spawnPipe();
    }
  }

  void spawnPipe() {
    double screenHeight = gameRef.size.y;

    final double maxPipeHeight =
        screenHeight - groundHeight - pipeGap - minPipeHeight;

    final double bottomPipeHeight =
        minPipeHeight + Random().nextDouble() * (maxPipeHeight - minPipeHeight);

    final double topPipeHeight =
        screenHeight - groundHeight - bottomPipeHeight - pipeGap;

    final bottomPipe = Pipe(
      Vector2(gameRef.size.x, screenHeight - groundHeight - bottomPipeHeight),
      Vector2(pipeWidth, bottomPipeHeight),
      isTopPipe: false,
    );
    final topPipe = Pipe(
      Vector2(gameRef.size.x, 0),
      Vector2(pipeWidth, topPipeHeight),
      isTopPipe: true,
    );

    gameRef.add(bottomPipe);
    gameRef.add(topPipe);
  }

  void clear() {
    gameRef.children
        .whereType<Pipe>()
        .forEach((pipe) => pipe.removeFromParent());
  }
}
