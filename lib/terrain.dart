import 'dart:async';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dorci.dart';

class Terrain extends PositionComponent with HasGameRef<Dorci> {
  @override
  FutureOr<void> onLoad() {
    position = Vector2.zero();
    grass = Rect.fromCenter(
      center: Offset(game.width, game.height) / 2,
      width: game.width,
      height: game.height,
    );
    target = Rect.fromCenter(
      center: Offset(game.width, 0) / 2,
      width: game.width,
      height: 100,
    );
  }

  late final Rect grass;
  final Paint _grassPaint = Paint()..color = Colors.green;
  set grassColor(Color color) => _grassPaint.color = color;

  late final Rect target;
  final targetPaint = Paint()..color = Colors.grey;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(grass, _grassPaint);
    canvas.drawRect(target, targetPaint);
    super.render(canvas);
  }
}
