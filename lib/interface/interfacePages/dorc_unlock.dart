import 'dart:async';

import 'package:dorci/dorcet/dorcet.dart';
import 'package:dorci/dorci.dart';
import 'package:flutter/material.dart';

class DorcUnclock extends StatefulWidget {
  const DorcUnclock({super.key, required this.game});
  final Dorci game;
  @override
  State<DorcUnclock> createState() => _DorcUnclockState();
}

class _DorcUnclockState extends State<DorcUnclock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.deepPurpleAccent,
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: ((context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 101, 63, 207)),
            height: 110,
            child: BuyButton(
              dorcet: widget.game.dorcetMap[index]!,
              game: widget.game,
            ),
          );
        }),
      ),
    );
  }
}

class BuyButton extends StatefulWidget {
  const BuyButton({super.key, required this.dorcet, required this.game});
  final Dorcet dorcet;
  final Dorci game;

  @override
  State<BuyButton> createState() => _BuyButtonState();
}

class _BuyButtonState extends State<BuyButton> {
  bool isPressed = false;

  Timer? timer;

  void onTapDown(TapDownDetails details) {
    isPressed = true;
    setState(() {});
  }

  void onTapCancel() {
    isPressed = false;
    setState(() {});
  }

  void onTapUp(TapUpDetails details) {
    buyDorcet();
    setState(() {});
    Future.delayed(
      const Duration(milliseconds: 100),
      () => setState(() {
        isPressed = false;
      }),
    );
  }

  void buyDorcet() {
    if (widget.dorcet.active ||
        !widget.game.enoughCredit(widget.dorcet.cost.toInt())) {
      return;
    }
    widget.dorcet.level += 1;
  }

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is initialized
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    timer?.cancel();
    super.dispose();
  }

  Color getColor() {
    if (widget.dorcet.active) {
      return const Color.fromARGB(255, 102, 102, 102);
    } else if (!widget.game.enoughCredit(widget.dorcet.cost.toInt())) {
      return Colors.grey;
    } else if (isPressed) {
      return const Color.fromARGB(255, 96, 30, 30);
    }
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: Text(
              widget.dorcet.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ),
        Expanded(
          child: FractionallySizedBox(
            heightFactor: 0.9,
            widthFactor: 0.9,
            child: GestureDetector(
              onTapDown: onTapDown,
              onTapUp: onTapUp,
              onTapCancel: onTapCancel,
              child: Container(
                decoration: BoxDecoration(
                  color: getColor(),
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    widget.dorcet.active ? "UNCLOCKED" : "UNLOCK",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
