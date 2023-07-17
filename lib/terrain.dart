import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dorci.dart';

class Terrain extends PositionComponent with HasGameRef<Dorci> {
  @override
  FutureOr<void> onLoad() {
    position = Vector2.zero();
    grass = Rect.fromCenter(
      center: game.camera.gameSize.toOffset() / 2,
      width: game.camera.gameSize.x,
      height: game.camera.gameSize.y,
    );
  }

  late final Rect grass;
  final Paint _grassPaint = Paint()..color = Colors.green;
  set grassColor(Color color) => _grassPaint.color = color;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(grass, _grassPaint);
  }
}
