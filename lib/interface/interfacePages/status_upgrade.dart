import 'dart:async';

import 'package:dorci/dorcet/dorcet.dart';
import 'package:dorci/dorci.dart';
import 'package:dorci/main.dart';
import 'package:flutter/material.dart';

List<Color> colorlist = [Colors.brown, Colors.blue, Colors.orange];

class StatusUpgrade extends StatelessWidget {
  const StatusUpgrade({super.key, required this.game});
  final Dorci game;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: ((context, index) {
        final dorcet = game.dorcetMap[index];
        if (dorcet == null) return Container();
        if (!dorcet.active) return Container();
        return Container(
          height: 190,
          color: const Color.fromRGBO(224, 64, 251, 1),
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: Row(
                  children: [
                    Expanded(
                        child: Center(
                      child: Text(
                        dorcet.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    )),
                    Expanded(
                      child: Column(children: [
                        Expanded(flex: 1, child: Container()),
                        UpgradeButton(
                          game: game,
                          dorcet: dorcet,
                          upgradeType: UpgradeType.attackDamage,
                        ),
                        UpgradeButton(
                          game: game,
                          dorcet: dorcet,
                          upgradeType: UpgradeType.attackSpeed,
                        )
                      ]),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 5,
                    color: Colors.deepPurpleAccent[200],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

class UpgradeButton extends StatefulWidget {
  const UpgradeButton({
    super.key,
    required this.game,
    required this.upgradeType,
    required this.dorcet,
  });
  final Dorci game;
  final Dorcet dorcet;
  final UpgradeType upgradeType;

  @override
  State<UpgradeButton> createState() => _UpgradeButtonState();
}

class _UpgradeButtonState extends State<UpgradeButton> {
  bool isPressed = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void onTapDown(TapDownDetails details) {
    isPressed = true;
    setState(() {});
  }

  void onTapCancel() {
    isPressed = false;
    setState(() {});
  }

  void onTapUp(TapUpDetails details) {
    levelUp();
    setState(() {});
    Future.delayed(
      const Duration(milliseconds: 100),
      () => setState(() {
        isPressed = false;
      }),
    );
  }

  void levelUp() {
    if (widget.upgradeType.isAttackDamage) {
      if (widget.game.credit < widget.dorcet.levelUpDamageCost) return;
      widget.game.credit -= widget.dorcet.levelUpDamageCost;
      widget.dorcet.damageLevel++;
    } else {
      if (widget.game.credit < widget.dorcet.levelUpAttackSpeedCost) return;
      widget.game.credit -= widget.dorcet.levelUpAttackSpeedCost;
      widget.dorcet.attackSpeedLevel++;
    }
  }

  bool enoughMoneyUp() {
    if (widget.upgradeType.isAttackDamage) {
      if (widget.game.credit < widget.dorcet.levelUpDamageCost) return false;
      return true;
    } else {
      if (widget.game.credit < widget.dorcet.levelUpAttackSpeedCost) {
        return false;
      }
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: FractionallySizedBox(
        heightFactor: 0.9,
        widthFactor: 0.95,
        child: GestureDetector(
          onTapDown: onTapDown,
          onTapUp: onTapUp,
          onTapCancel: onTapCancel,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isPressed
                  ? const Color.fromARGB(255, 58, 138, 60)
                  : Colors.green,
              border: Border.all(
                color: Colors.yellowAccent,
                width: 2,
              ),
            ),
            child: Row(children: [
              Expanded(
                flex: 10,
                child: Column(children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.upgradeType.isAttackDamage
                            ? "  DAMAGE"
                            : "  ATTACK SPEED",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.upgradeType.isAttackDamage
                            ? "  ${"${widget.dorcet.damage}000".substring(0, 4)}"
                            : "  ${"${widget.dorcet.attackSpeed}000".substring(0, 4)} per/sec",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
              Expanded(
                flex: 6,
                child: FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 0.95,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      color: enoughMoneyUp()
                          ? Color.fromARGB(255, 0, 255, 8).withOpacity(0.25)
                          : Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        formatText(widget.upgradeType.isAttackDamage
                            ? "${widget.dorcet.levelUpDamageCost.toInt()}"
                            : "${widget.dorcet.levelUpAttackSpeedCost.toInt()}"),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

enum UpgradeType {
  attackDamage,
  attackSpeed;

  bool get isAttackDamage => this == attackDamage;
  bool get isAttackSpeed => this == attackSpeed;
}
