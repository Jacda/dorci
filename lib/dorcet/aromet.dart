import 'dart:math';

import 'package:dorci/projectile/aromectile.dart';
import 'package:flame/components.dart';

import 'dorcet.dart';

class Aromet extends Dorcet {
  Aromet({required super.position})
      : super(
          baseDamage: 100,
          dps: 10,
          speed: 50,
          accuracy: 150,
          baseCost: 5000,
        );

  @override
  void createProjectile() {
    final offset = Random().nextInt(accuracy) - accuracy / 2;
    final pposition = Vector2(x + offset, y);
    game.add(Aromectile(speed: speed, damage: damage, position: pposition));
  }
}
