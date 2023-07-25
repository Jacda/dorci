import 'dart:async';
import 'dart:math';
import 'package:dorci/dorcet/aromet.dart';
import 'package:dorci/dorcet/yoghet.dart';
import 'package:dorci/projectile/tap_projectile.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'dorcet/dirtet.dart';
import 'dorci.dart';

class Hub extends SpriteAnimationComponent
    with HasGameRef<Dorci>, Tappable, OpacityProvider {
  late final Yoghet yoghet;
  late final Dirtet dirtet;
  late final Aromet aromet;

  double get totalDPS => yoghet.dps + dirtet.dps + aromet.dps;

  Hub() : super(anchor: Anchor.bottomCenter);

  @override
  FutureOr<void> onLoad() {
    List<Sprite> splist = [];
    for (int i = 0; i < 24; i++) {
      final String s;
      if (i < 10) {
        s = "0$i";
      } else {
        s = "$i";
      }

      splist.add(Sprite(game.images.fromCache("frame_${s}_delay-0.06s.gif")));
    }
    animation = SpriteAnimation.spriteList(splist, stepTime: 0.05);
    opacity = 1;
    position = Vector2(game.width / 2, game.height * 2 / 3.2);
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
    //canvas.drawRRect(rect, shapePaint);
    super.render(canvas);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    final offset = Random().nextInt(40) - 20;
    final pposition = Vector2(x + offset, y - 50);
    game.add(TapProjectile(
      speed: 250,
      damage: (totalDPS / 4).floor() + 0.2,
      position: pposition,
    ));
    return false;
  }
}
