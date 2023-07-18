import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'button.dart';
import 'dorci.dart';

class Hud extends PositionComponent with HasGameRef<Dorci> {
  late final Button button;
  @override
  FutureOr<void> onLoad() {
    width = game.width / 2;
    height = game.height;
    x = -width;
    ground = Rect.fromLTWH(0, 0, width, height);
    button = Button(
      position: Vector2(width, height / 2),
      size: Vector2(50, 80),
      f: open,
      anchor: Anchor.centerLeft,
      paint: Paint()..color = Colors.orangeAccent,
    );
    add(button);
  }

  bool isOpen = false;

  late final Rect ground;
  final Paint groundPaint = Paint()
    ..color = const Color.fromARGB(255, 255, 193, 100);

  @override
  void render(Canvas canvas) {
    canvas.drawRect(ground, groundPaint);
  }

  void open() {
    if (isOpen) {
      isOpen = false;
      button.anchor = Anchor.centerLeft;
      x = -width;
      game.camera.follow = (Vector2(0, 0));
      game.creditText.position = Vector2(0, 0);
      return;
    }
    isOpen = true;
    game.camera.follow = (Vector2(-width / 2, 0));
    button.anchor = Anchor.centerRight;
    game.creditText.position = Vector2(width / 2, 0);
    x = -width / 2;
  }
}
