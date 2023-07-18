import 'package:dorci/dorci.dart';
import 'package:flame/components.dart';

abstract class Dorcet extends PositionComponent with HasGameRef<Dorci> {
  double damage;
  double dps;
  double speed;
  int accuracy;
  Dorcet({
    required this.damage,
    required this.dps,
    required this.speed,
    required this.accuracy,
    required super.position,
  });

  set incDamage(double incDamage) {
    dps = dps * (incDamage / damage);
    damage = incDamage;
  }

  double get frequency => damage / dps;

  double timer = 0;

  @override
  void update(double dt) {
    while (timer >= 0) {
      timer -= frequency;
      createProjectile();
    }
    timer += dt;
  }

  void createProjectile() {}
}
