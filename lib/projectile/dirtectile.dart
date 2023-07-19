import 'package:flutter/material.dart';
import 'base_projectile.dart';

class Dirtectile extends BaseProjectile {
  Dirtectile({
    required super.speed,
    required super.damage,
    required super.position,
  });

  final paint = Paint()..color = Colors.brown;

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset.zero, 5, paint);
  }
}
