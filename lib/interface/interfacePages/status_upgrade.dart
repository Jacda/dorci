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
      itemCount: game.activeDorcetList.length,
      itemBuilder: ((context, index) {
        final dorcet = game.activeDorcetList[index];
        return Container(
          height: 170,
          color: colorlist[index],
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

  void onTapDown(TapDownDetails details) {
    isPressed = true;
    setState(() {});
  }

  void onTapCancel() {
    isPressed = false;
    setState(() {});
  }

  void onTapUp(TapUpDetails details) {
    //lvlUp();
    setState(() {});
    Future.delayed(
      const Duration(milliseconds: 100),
      () => setState(() {
        isPressed = false;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FractionallySizedBox(
        heightFactor: 0.98,
        child: GestureDetector(
          onTapDown: onTapDown,
          onTapUp: onTapUp,
          onTapCancel: onTapCancel,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:
                  isPressed ? const Color.fromARGB(255, 58, 138, 60) : Colors.green,
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
                            ? "  ${widget.dorcet.damage}"
                            : "  ${"${1 / widget.dorcet.frequency}000".substring(0, 4)} per/sec",
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
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        formatText("531513"),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
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
