import 'dart:math';

import 'package:dorci/dorci.dart';
import 'package:flame/components.dart';

abstract class Dorcet extends PositionComponent with HasGameRef<Dorci> {
  double baseDamage;
  double dps;
  double speed;
  int accuracy;
  int baseCost;
  Dorcet({
    required this.baseDamage,
    required this.dps,
    required this.speed,
    required this.accuracy,
    required this.baseCost,
    required super.position,
  });

  bool active = false;

  int _level = 0;

  int get level => _level;
  set level(int level) {
    if (_level == 0) active = true;
    _level = level;
  }

  int get damage => (level * baseDamage).toInt();
  double get cost => baseCost * pow(1.4, level).toDouble();

  set incDamage(double incDamage) {
    dps = dps * (incDamage / baseDamage);
    baseDamage = incDamage;
  }

  double get frequency => baseDamage / dps;

  double timer = 0;

  @override
  void update(double dt) {
    if (!active) return;
    while (timer >= 0) {
      timer -= frequency;
      createProjectile();
    }
    timer += dt;
  }

  void createProjectile() {}
}
