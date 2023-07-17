import 'dart:async';
import 'dart:math';

import 'package:dorci/dorcet/dorcet.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Yoghet extends Dorcet {
  Yoghet({required super.position})
      : super(damage: 1, dps: 5, speed: 50, accuracy: 50);

  final List<RectangleComponent> bullets = [];
  @override
  FutureOr<void> onLoad() {
    rect = Rect.fromCenter(center: position.toOffset(), width: 6, height: 20);
  }

  final bulletPaint = Paint()..color = Colors.lightBlueAccent;

  late final Rect rect;

  set incDamage(double incDamage) {
    dps = dps * (incDamage / damage);
    damage = incDamage;
  }

  double get frequency => damage / dps;

  List<RectangleComponent> toRemove = [];

  double timer = 0;
  @override
  void update(double dt) {
    for (RectangleComponent bullet in bullets) {
      bullet.y -= speed * dt;
      if (bullet.y < 30) {
        toRemove.add(bullet);
        game.remove(bullet);
      }
    }
    for (RectangleComponent bullet in toRemove) {
      bullets.remove(bullet);
    }
    toRemove.clear();
    while (timer >= 0) {
      timer -= frequency;
      final bullet = RectangleComponent.fromRect(rect)..paint = bulletPaint;
      bullet.x += Random().nextInt(accuracy) - accuracy / 2;
      bullets.add(bullet);
      game.add(bullet);
    }
    timer += dt;
  }
}
