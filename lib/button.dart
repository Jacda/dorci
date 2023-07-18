import 'dart:ui';

import 'package:dorci/dorci.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class Button extends PositionComponent with Tappable, HasGameRef<Dorci> {
  final void Function() f;
  late final SpriteComponent sp;
  final Paint _paint;

  Button({
    required super.position,
    required super.size,
    required this.f,
    super.anchor,
    Paint? paint,
  }) : _paint = paint ?? Paint();

  late final Rect rect;

  @override
  Future<void> onLoad() async {
    rect = Rect.fromLTWH(0, 0, width, height);
  }

  @override
  bool onTapDown(TapDownInfo info) {
    f();
    return true;
  }

  @override
  void render(Canvas canvas) {
    canvas.drawRect(rect, _paint);
  }
}
