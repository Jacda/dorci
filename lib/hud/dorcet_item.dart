import 'dart:async';

import 'package:dorci/dorcet/dorcet.dart';
import 'package:dorci/main.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';

import '../dorci.dart';

class DorcetItem extends StatefulWidget {
  final Dorcet dorcet;
  final Dorci game;
  const DorcetItem({super.key, required this.game, required this.dorcet});

  @override
  State<DorcetItem> createState() => _DorcetItemState();
}

class _DorcetItemState extends State<DorcetItem> {
  bool isFingerInside = true;
  bool isPressed = false;
  Timer? timer;

  void onTapDown(TapDownDetails details) {
    isPressed = true;
    isFingerInside = true;
    setState(() {});
  }

  void onTapUp(TapUpDetails details) {
    lvlUp();
    setState(() {});
    Future.delayed(
      const Duration(milliseconds: 200),
      () => setState(
        () => {
          isFingerInside = false,
          isPressed = true,
        },
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details, BuildContext context) {
    RenderBox box = context.findRenderObject() as RenderBox;
    Offset localPosition = box.globalToLocal(details.globalPosition);
    isFingerInside = box.paintBounds.contains(localPosition);
    setState(() {});
  }

  void onPanEnd(DragEndDetails details) {
    if (isFingerInside && isPressed) {
      lvlUp();
    }
    setState(() {});
    Future.delayed(
      const Duration(milliseconds: 200),
      () => setState(
        () => {
          isFingerInside = false,
          isPressed = true,
        },
      ),
    );
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

  Color getBoxColor() {
    if (!widget.game.enoughCredit(widget.dorcet.cost.toInt())) {
      return Colors.grey;
    } else if (isFingerInside && isPressed) {
      return const Color.fromARGB(255, 41, 100, 43);
    }
    return Colors.green;
  }

  void lvlUp() {
    if (!widget.game.enoughCredit(widget.dorcet.cost.toInt())) {
      return;
    }
    widget.game.credit -= widget.dorcet.cost;
    widget.dorcet.level += 1;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (contexts, constraints) {
      final double scale = constraints.maxWidth;
      final dps = widget.dorcet.effectiveDps;
      return Stack(
        children: [
          Align(
            alignment: const Alignment(0, -0.3),
            child: SizedBox(
              width: scale / 1.5,
              height: scale / 5,
              child: Row(
                children: [
                  UpgradeButton(
                    color: Colors.tealAccent,
                    index: 0,
                    dorcet: widget.dorcet,
                    game: widget.game,
                  ),
                  UpgradeButton(
                    color: Colors.teal,
                    index: 1,
                    dorcet: widget.dorcet,
                    game: widget.game,
                  ),
                  UpgradeButton(
                    color: Colors.greenAccent,
                    index: 2,
                    dorcet: widget.dorcet,
                    game: widget.game,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "DPS: ${dps < 100 ? dps : dps.floor()}",
              style: TextStyle(
                fontSize: scale / 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.1),
            child: Text(
              "LVL: ${widget.dorcet.level}",
              style: TextStyle(
                fontSize: scale / 9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.8),
            child: SizedBox(
              width: scale / 1.5,
              height: scale / 3,
              child: Builder(builder: (context) {
                return GestureDetector(
                  onTapDown: onTapDown,
                  onTapUp: onTapUp,
                  onPanUpdate: (details) => onPanUpdate(details, context),
                  onPanEnd: onPanEnd,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: getBoxColor(),
                      border: Border.all(
                        width: 4,
                        color: Colors.yellowAccent,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: const Alignment(0, -0.8),
                          child: Text(
                            "LVL UP",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: scale / 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Align(
                          alignment: const Alignment(0, 0.7),
                          child: Text(
                            formatText("${widget.dorcet.cost.floor()}"),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: scale / 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ].reversed.toList(),
      );
    });
  }
}

class UpgradeButton extends StatefulWidget {
  final Dorci game;
  final Dorcet dorcet;
  final Color color;
  final int index;
  const UpgradeButton({
    super.key,
    required this.color,
    required this.index,
    required this.dorcet,
    required this.game,
  });

  @override
  State<UpgradeButton> createState() => _UpgradeButtonState();
}

class _UpgradeButtonState extends State<UpgradeButton> {
  bool available(DorcetUpgrade dorcetUpgrade) {
    if (dorcetUpgrade.purchased) return false;
    if (dorcetUpgrade.cost > widget.game.credit) return false;
    if (widget.dorcet.level < dorcetUpgrade.level) return false;
    return true;
  }

  Timer? timer;
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

  void buyUpgrade(DorcetUpgrade dorcetUpgrade) {
    if (!available(dorcetUpgrade)) return;
    widget.dorcet.upgrade(dorcetUpgrade);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final dorcetUpgrade = widget.dorcet.upgrades[widget.index];
    return Expanded(
      child: GestureDetector(
        onTap: () => buyUpgrade(dorcetUpgrade),
        child: Container(
          color: available(dorcetUpgrade)
              ? widget.color
              : widget.color.darken(0.7),
        ),
      ),
    );
  }
}
