import 'dart:async';

import 'package:dorci/dorcet/dorcet.dart';
import 'package:dorci/hub.dart';
import 'package:dorci/terrain.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class Dorci extends FlameGame with HasTappables {
  final List<Dorcet> activeDorcetList = [];
  final Map<int, Dorcet> dorcetMap = {};

  late int i;

  @override
  Color backgroundColor() => const Color.fromARGB(255, 21, 203, 231);

  double get width => camera.gameSize.x;
  double get height => camera.gameSize.y;

  double credit = 0;

  TextComponent creditText = TextBoxComponent(position: Vector2(10, 10));

  final Hub hub = Hub();
  @override
  FutureOr<void> onLoad() async {
    debugMode = false;
    final width = size.y / (20 / 9);
    camera.viewport = FixedResolutionViewport(Vector2(width, size.y));
    await images.loadAllImages();
    add(Terrain());
    add(hub);
    add(creditText);
    credit = 0;
  }

  @override
  void update(double dt) {
    //resourceCounters(dt);
    super.update(dt);
  }

  void open() => camera.follow = (Vector2(-width / 4, 0));

  void close() => camera.follow = (Vector2(0, 0));

  bool enoughCredit(int cost) => cost <= credit;

  late int componentCount;

  void resourceCounters(double dt) {
    componentCount = 0;
    countComponents(this);

    //first fps is calculated differently as it takes a second for the true fps to be calculated
    if (fpsPerSec == -1) {
      fpsPerSec++;
    }
    resetAtOneSec += dt;
    fpsPerSec++;
    if (resetAtOneSec >= 1) {
      print(fpsPerSec);
      print(componentCount);
      resetAtOneSec -= resetAtOneSec.floor();
      fpsPerSec = 0;
    }
  }

  double resetAtOneSec = 0;
  late double fpsPerSec = 0;

  countComponents(Component ch) {
    componentCount++;
    for (Component c in ch.children) {
      countComponents(c);
    }
  }
}
