import 'dart:async';

import 'package:final_project/gameButton.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Undertale extends FlameGame {
  int _time = 0;

  late Timer _timer;

  late TextComponent _timeText;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    _timeText = TextComponent(
      text: 'Score: $_time',
      position: Vector2(size.x - 40, 40),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(
        style: TextStyle(
          color: BasicPalette.red.color,
          fontSize: 30,
        ),
      ),
    );

    add(_timeText);

    _timer = Timer(1, repeat: true, onTick: () {
      _time += 1;
    });

    _timer.start();

    final borderedRectangle =
        BorderedRectangle(size.x / 8, size.y / 4, size.x / 2, size.y / 3);
    add(borderedRectangle);
  }

  @override
  void update(double dt) {
    super.update(dt);

    _timer.update(dt);

    _timeText.text = 'Score: $_time';
    _timeText.position = Vector2(size.x - 40, 40);
  }
}
