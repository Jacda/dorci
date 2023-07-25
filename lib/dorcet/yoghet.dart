import 'dart:math';

import 'package:dorci/dorcet/dorcet.dart';
import 'package:dorci/projectile/yoghectile.dart';
import 'package:flame/components.dart';

class Yoghet extends Dorcet {
  Yoghet({required super.position})
      : super(
          baseDamage: 1,
          baseAttackSpeed: 0.5,
          speed: 200,
          accuracy: 100,
          unlockCost: 10,
          name: "YOGHURT DORCET",
        );

  @override
  void createProjectile() {
    final double offset;
    if (accuracy > 1) {
      offset = Random().nextInt(accuracy) - accuracy / 2;
    } else {
      offset = 0;
    }

    final pposition = Vector2(x + offset, y);
    game.add(Yoghectile(
        speed: speed, damage: damage.toDouble(), position: pposition));
  }
}
