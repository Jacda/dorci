import 'package:dorci/dorci.dart';
import 'package:flutter/material.dart';
import 'dorcet_item.dart';

class Hud extends StatefulWidget {
  const Hud({super.key, required this.game});
  final Dorci game;

  @override
  State<Hud> createState() => _HudState();
}

class _HudState extends State<Hud> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (!isOpen) {
          return Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                isOpen = true;
                widget.game.open();
                setState(() {});
              },
              child: Container(
                width: 60,
                height: 85,
                color: Colors.orangeAccent,
              ),
            ),
          );
        }
        return Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: constraints.maxWidth / 2,
            color: Colors.orange,
            child: Stack(
              children: [
                ItemBuilder(
                  game: widget.game,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      isOpen = false;
                      widget.game.close();
                      setState(() {});
                    },
                    child: Container(
                      width: 60,
                      height: 85,
                      color: Colors.orangeAccent.withOpacity(.85),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

List<String> items = ["yoghie"];

class ItemBuilder extends StatelessWidget {
  const ItemBuilder({
    super.key,
    required this.game,
    required this.width,
    required this.height,
  });
  final Dorci game;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: width / 2 * 0.9,
        height: height * 0.99,
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return SizedBox(
              height: width / 2,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      width: 5,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  child: DorcetItem(
                    game: game,
                    dorcet: game.dorcetMap[index]!,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
