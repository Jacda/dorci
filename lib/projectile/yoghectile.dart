import 'package:dorci/projectile/base_projectile.dart';
import 'package:flutter/material.dart';

class Yoghectile extends BaseProjectile {
  Yoghectile({
    required super.speed,
    required super.damage,
    required super.position,
  });

  final shape = Rect.fromCenter(center: Offset.zero, width: 6, height: 20);
  final paint = Paint()..color = Colors.lightBlueAccent;

  @override
  void render(Canvas canvas) {
    canvas.drawRect(shape, paint);
  }
}
