import 'package:flutter/material.dart';
import 'base_projectile.dart';

class TapProjectile extends BaseProjectile {
  TapProjectile({
    required super.speed,
    required super.damage,
    required super.position,
  });

  final paint = Paint()..color = Colors.white;

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset.zero, 2, paint);
  }
}
