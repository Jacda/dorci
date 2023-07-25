import 'dart:math';

import 'package:dorci/dorci.dart';
import 'package:flame/components.dart';

abstract class Dorcet extends PositionComponent with HasGameRef<Dorci> {
  double baseDamage;
  double baseAttackSpeed;
  double speed;
  int accuracy;
  int unlockCost;
  final String name;
  Dorcet({
    required this.baseDamage,
    required this.baseAttackSpeed,
    required this.speed,
    required this.accuracy,
    required this.unlockCost,
    required super.position,
    required this.name,
  }) {
    timer = -cooldown / 2;
  }

  double get cooldown => 1 / attackSpeed;
  double get dps {
    if (!active) return 0;
    return damage * attackSpeed;
  }

  bool _active = false;
  bool get active => _active;
  set active(bool active) {
    if (!_active) {
      game.activeDorcetList.add(this);
    }
    _active = active;
  }

  int damageLevel = 0;
  int _attackSpeedLevel = 0;

  int get attackSpeedLevel => _attackSpeedLevel;
  set attackSpeedLevel(int attackSpeedLevel) {
    _attackSpeedLevel = attackSpeedLevel;
    timer = -cooldown / 2;
  }

  double get damage => (damageLevel * (baseDamage / 3) + baseDamage);
  double get attackSpeed =>
      (attackSpeedLevel * (baseAttackSpeed / 9) + baseAttackSpeed);
  double get levelUpDamageCost =>
      unlockCost *
      pow(1.2 - 0.02 * log(e + damageLevel), damageLevel).toDouble();
  double get levelUpAttackSpeedCost =>
      unlockCost *
      pow(1.18 - 0.02 * log(e + attackSpeedLevel), attackSpeedLevel).toDouble();

  late double timer;

  @override
  void update(double dt) {
    if (!active) return;
    while (timer >= 0) {
      timer -= cooldown;
      createProjectile();
    }
    timer += dt;
  }

  void createProjectile() {}
}
