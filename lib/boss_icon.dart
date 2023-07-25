import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'dorci.dart';

class BossIcon extends PositionComponent with HasGameRef<Dorci> {
  late final Sprite sprite;

  BossIcon({
    required super.size,
    required super.position,
  }) {
    anchor = Anchor.center;
    rrect = RRect.fromLTRBR(
      0,
      height,
      width,
      0,
      const Radius.circular(40),
    );
  }

  @override
  FutureOr<void> onLoad() {
    sprite = Sprite(game.images.fromCache("darc_orc.png"));
  }

  late final RRect rrect;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawCircle(
      (size / 2).toOffset(),
      width / 2 + 2,
      Paint()..color = Colors.white,
    );
    canvas.save();
    canvas.clipRRect(rrect);
    sprite.render(
      canvas,
      size: size * 1.21,
      position: size / 2,
      anchor: Anchor.center,
    );
    canvas.restore();
  }
}
