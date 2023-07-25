import 'package:dorci/dorci.dart';
import 'package:dorci/interface/interfacePages/dorc_unlock.dart';
import 'package:dorci/interface/interfacePages/status_upgrade.dart';
import 'package:dorci/interface/navbar.dart';
import 'package:dorci/interface/statusbar.dart';
import 'package:flutter/material.dart';

class Interface extends StatefulWidget {
  final Dorci game;
  const Interface({super.key, required this.game});

  @override
  State<Interface> createState() => _InterfaceState();
}

class _InterfaceState extends State<Interface> {
  late final List<Widget> interfacePages;
  late Widget interface;

  void swapInterface(int index) {
    interface = interfacePages[index];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    interfacePages = [
      StatusUpgrade(game: widget.game),
      Container(color: Colors.black),
      DorcUnclock(game: widget.game),
    ];
    interface = interfacePages[0];
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.amber,
        height: MediaQuery.of(context).size.height / 2.5,
        child: Column(
          children: [
            Expanded(child: StatusBar(game: widget.game)),
            Expanded(
                flex: 7,
                child: Container(
                  child: interface,
                )),
            Expanded(
              child: NavBar(
                game: widget.game,
                swapInterface: swapInterface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



