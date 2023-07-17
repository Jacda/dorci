import 'dart:async';

import 'package:dorci/dorci.dart';
import 'package:flame/components.dart';

class Dorcet extends PositionComponent with HasGameRef<Dorci> {
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
}
