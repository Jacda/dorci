import 'dart:async';

import 'package:dorci/dorci.dart';
import 'package:dorci/main.dart';
import 'package:flutter/material.dart';

class StatusBar extends StatefulWidget {
  const StatusBar({super.key, required this.game});
  final Dorci game;

  @override
  State<StatusBar> createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 100), (Timer t) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          formatText("  ${widget.game.credit.toInt()}"),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
