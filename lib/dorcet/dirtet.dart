import 'dart:math';

import 'package:dorci/projectile/dirtectile.dart';
import 'package:flame/components.dart';

import 'dorcet.dart';

class Dirtet extends Dorcet {
  Dirtet({required super.position})
      : super(
          baseDamage: 7.5,
          baseAttackSpeed: 1/3,
          speed: 150,
          accuracy: 120,
          unlockCost: 100,
          name: "DIRT DORCET",
        );

  @override
  void createProjectile() {
    final offset = Random().nextInt(accuracy) - accuracy / 2;
    final pposition = Vector2(x + offset, y);
    game.add(Dirtectile(
        speed: speed, damage: damage.toDouble(), position: pposition));
  }
}
