import 'dart:math';

import 'package:dorci/dorcet/dorcet.dart';
import 'package:dorci/projectile/yoghectile.dart';
import 'package:flame/components.dart';

class Yoghet extends Dorcet {
  Yoghet({required super.position})
      : super(damage: 1, dps: 2, speed: 200, accuracy: 100);

  @override
  void createProjectile() {
    final offset = Random().nextInt(accuracy) - accuracy / 2;
    final pposition = Vector2(x + offset, y);
    game.add(Yoghectile(speed: speed, damage: damage, position: pposition));
  }
}
