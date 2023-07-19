import 'dart:async';
import 'package:dorci/dorcet/yoghet.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dorci.dart';

class Hub extends PositionComponent with HasGameRef<Dorci> {
  late final Yoghet yoghet;

  Hub();

  @override
  FutureOr<void> onLoad() {
    position = Vector2(game.width / 2, game.height);
    size = Vector2(180, 100);
    final shape = Rect.fromCenter(
      center: Offset.zero,
      width: width,
      height: height,
    );
    rect = RRect.fromRectXY(shape, 10, 10);
    add(yoghet = Yoghet(position: Vector2(x, y - 50)));
  }

  late final RRect rect;
  final Paint shapePaint = Paint()..color = Colors.black;

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(rect, shapePaint);
    super.render(canvas);
  }
}
