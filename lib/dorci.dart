import 'dart:async';

import 'package:dorci/terrain.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class Dorci extends FlameGame {
  @override
  Color backgroundColor() => const Color.fromARGB(255, 21, 203, 231);

  @override
  FutureOr<void> onLoad() {
    debugMode = true;
    final width = size.y / (16 / 9);
    camera.viewport = FixedResolutionViewport(Vector2(width, size.y));
    add(Terrain());
  }
}
