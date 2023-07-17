import 'package:dorci/dorci.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final game = Dorci();
  runApp(GameWidget(game: game));
}
