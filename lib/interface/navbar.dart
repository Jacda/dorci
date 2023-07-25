import 'package:dorci/dorci.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key, required this.swapInterface, required this.game});
  final Function(int) swapInterface;
  final Dorci game;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.95,
      child: Row(
        children: [
          NavBarItem(
            color: Colors.teal,
            swapInterface: () => swapInterface(0),
          ),
          NavBarItem(
            color: Colors.blue,
            swapInterface: () => swapInterface(1),
          ),
          NavBarItem(
            color: Colors.red,
            swapInterface: () => swapInterface(2),
          ),
        ],
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.color,
    required this.swapInterface,
  });
  final void Function() swapInterface;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FractionallySizedBox(
        widthFactor: 0.95,
        heightFactor: 0.9,
        child: GestureDetector(
          onTap: swapInterface,
          child: Container(
            decoration: BoxDecoration(
              color: color,
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
