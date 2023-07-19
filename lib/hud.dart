import 'package:dorci/dorci.dart';
import 'package:flutter/material.dart';

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
                      color: Colors.orangeAccent,
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
          itemCount: items.length,
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

class DorcetItem extends StatefulWidget {
  final Dorci game;
  const DorcetItem({super.key, required this.game});

  @override
  State<DorcetItem> createState() => _DorcetItemState();
}

class _DorcetItemState extends State<DorcetItem> {
  bool isFingerInside = true;
  bool isPressed = false;

  void onTapDown(TapDownDetails details) {
    isPressed = true;
    isFingerInside = true;
    setState(() {});
  }

  void onTapUp(TapUpDetails details) {
    widget.game.credit -= widget.game.hub.yoghet.cost;
    widget.game.hub.yoghet.level += 1;
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
      widget.game.credit -= widget.game.hub.yoghet.cost;
      widget.game.hub.yoghet.level += 1;
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
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (contexts, constraints) {
      final double scale = constraints.maxWidth;
      return Stack(
        children: [
          Align(
            alignment: Alignment(0, 0.1),
            child: Text(
              "LVL: ${widget.game.hub.yoghet.level}",
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
                      color: isFingerInside && isPressed
                          ? const Color.fromARGB(255, 41, 100, 43)
                          : Colors.green,
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
                            "${widget.game.hub.yoghet.cost.floor()}",
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
