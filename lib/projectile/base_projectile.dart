import 'package:dorci/dorci.dart';
import 'package:flame/components.dart';

abstract class BaseProjectile extends PositionComponent with HasGameRef<Dorci> {
  final double speed;
  final double damage;
  BaseProjectile({
    required this.speed,
    required this.damage,
    required super.position,
  });

  @override
  void update(double dt) {
    if (y <= 40) removeFromParent();
    y -= speed * dt;
  }

  @override
  void removeFromParent() {
    super.removeFromParent();
    game.credit += damage;
  }
}
