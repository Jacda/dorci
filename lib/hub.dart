import 'dart:async';
import 'package:dorci/dorcet/aromet.dart';
import 'package:dorci/dorcet/yoghet.dart';
import 'package:flame/components.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flutter/material.dart';
import 'dorcet/dirtet.dart';
import 'dorci.dart';

class Hub extends PositionComponent with HasGameRef<Dorci>, Tappable {
  late final Yoghet yoghet;
  late final Dirtet dirtet;
  late final Aromet aromet;

  Hub();

  @override
  FutureOr<void> onLoad() {
    anchor = Anchor.center;
    position = Vector2(game.width / 2, game.height);
    size = Vector2(180, 100);
    final shape = Rect.fromCenter(
      center: (size / 2).toOffset(),
      width: width,
      height: height,
    );
    rect = RRect.fromRectXY(shape, 10, 10);
    add(yoghet = Yoghet(position: Vector2(x, y - 50)));
    game.dorcetMap[0] = yoghet;
    add(dirtet = Dirtet(position: Vector2(x, y - 50)));
    game.dorcetMap[1] = dirtet;
    add(aromet = Aromet(position: Vector2(x, y - 50)));
    game.dorcetMap[2] = aromet;
  }

  late final RRect rect;
  final Paint shapePaint = Paint()..color = Colors.black;

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(rect, shapePaint);
    super.render(canvas);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    game.credit *= 20;
    return false;
  }
}
