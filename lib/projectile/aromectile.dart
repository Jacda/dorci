import 'package:flutter/material.dart';
import 'base_projectile.dart';

class Aromectile extends BaseProjectile {
  Aromectile({
    required super.speed,
    required super.damage,
    required super.position,
  });

  final paint = Paint()..color = Colors.deepPurpleAccent;

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset.zero, 20, paint);
  }
}
