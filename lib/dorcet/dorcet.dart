import 'dart:async';
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
  }) {
    timer = -frequency / 2;
    upgrades = [
      DorcetUpgrade(
        baseCost: baseCost,
        level: 10,
        multiplier: 1.5,
        upgradeType: UpgradeType.dps,
      ),
      DorcetUpgrade(
        baseCost: baseCost,
        level: 25,
        multiplier: 2,
        upgradeType: UpgradeType.acccuracy,
      ),
      DorcetUpgrade(
        baseCost: baseCost,
        level: 50,
        multiplier: 2,
        upgradeType: UpgradeType.dps,
      )
    ];
  }

  late final List<DorcetUpgrade> upgrades;

  bool active = false;

  int _level = 0;

  int get level => _level;
  set level(int level) {
    if (_level == 0) active = true;
    _level = level;
  }

  int get damage => (level * baseDamage).toInt();
  //double get cost => baseCost * pow(1.4, level).toDouble();
  double get cost =>
      baseCost * pow(1.25 - 0.03 * log(e + level), level).toDouble();

  set incDamage(double incDamage) {
    dps = dps * (incDamage / baseDamage);
    baseDamage = incDamage;
  }

  double get effectiveDps => dps * level;
  double get frequency => baseDamage / dps;

  late double timer;

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

  void upgrade(DorcetUpgrade upgrade) {
    if (upgrade.purchased) return;
    switch (upgrade.upgradeType) {
      case UpgradeType.dps:
        dps *= upgrade.multiplier;
      case UpgradeType.acccuracy:
        accuracy = (accuracy / upgrade.multiplier).floor();
    }
    game.credit -= upgrade.cost;
    upgrade.purchased = true;
  }

  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad
    return super.onLoad();
  }
}

class DorcetUpgrade {
  final int baseCost;
  final int level;
  final double multiplier;
  final UpgradeType upgradeType;
  bool purchased = false;

  DorcetUpgrade({
    required this.baseCost,
    required this.level,
    required this.multiplier,
    required this.upgradeType,
  });

  double get cost =>
      baseCost * pow(1.25 - 0.03 * log(e + level), level).toDouble() * 8;
}

enum UpgradeType { dps, acccuracy }
