import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'components/components.dart';
import 'constants.dart';

class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  late Bird bird;
  late Background background;
  late Ground ground;
  late PipeManager pipeManager;
  late ScoreText scoreText;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    bird = Bird();
    background = Background(size);
    ground = Ground();
    pipeManager = PipeManager();
    scoreText = ScoreText();

    await add(background);
    await add(ground);
    await add(pipeManager);
    await add(bird);
    await add(scoreText);
  }

  @override
  void onTap() {
    super.onTap();
    bird.flap();
  }

  int score = 0;

  void increaseScore() {
    score++;
  }

  bool isGameOver = false;

  void gameOver() {
    if (isGameOver) return;

    isGameOver = true;
    pauseEngine();

    showDialog(
        context: buildContext!,
        builder: (context) => AlertDialog(
                title: const Text(
                  'Game Over',
                ),
                content: Text('Score: $score'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      restart();
                    },
                    child: const Text('Restart'),
                  ),
                ]));
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (bird.position.y + bird.size.y / 2 >= size.y) {
      gameOver();
    }
  }

  void restart() {
    isGameOver = false;
    score = 0;
    bird.position = Vector2(birdStartX, birdStartY);
    bird.velocity = 0.0;
    pipeManager.pipeSpawnTimer = 0;
    pipeManager.timeSinceLastPipeSpawn = 0;

    children.whereType<Pipe>().forEach((pipe) => pipe.removeFromParent());
    resumeEngine();
  }
}
