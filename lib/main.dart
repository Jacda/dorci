import 'dart:ui';

import 'package:dorci/dorci.dart';
import 'package:dorci/hud.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final game = Dorci();
  runApp(App(game: game));
}

class App extends StatefulWidget {
  const App({super.key, required this.game});
  final Dorci game;

  @override
  State<App> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: Scaffold(
        body: Center(
          child: AspectRatio(
            aspectRatio: 9 / 16,
            child: Stack(
              children: [
                GameWidget(game: widget.game),
                Hud(game: widget.game),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
