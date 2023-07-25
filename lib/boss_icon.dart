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
    anchor = Anchor.topLeft;
    rrect = RRect.fromLTRBR(
      -width / 2,
      height / 2,
      width / 2,
      -height / 2,
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
    canvas.save();
    canvas.clipRRect(rrect);
    sprite.render(
      canvas,
      size: size * 1.21,
      position: Vector2.zero(),
      anchor: Anchor.center,
    );
    canvas.restore();
  }
}
