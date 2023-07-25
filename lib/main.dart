import 'dart:ui';

import 'package:dorci/dorci.dart';
import 'package:dorci/interface/interface.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  final game = Dorci();
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(App(game: game));
}

class App extends StatefulWidget {
  const App({super.key, required this.game});
  final Dorci game;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      home: Scaffold(
        body: Center(
          child: Stack(
            children: [
              GameWidget(game: widget.game),
              Interface(game: widget.game),
              // Hud(game: widget.game),
            ],
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

RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
String Function(Match) mathFunc = (Match match) => '${match[1]},';

String formatText(String newText) => newText.replaceAllMapped(reg, mathFunc);
