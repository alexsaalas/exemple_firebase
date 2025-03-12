import 'package:exemple_firebase/models/missatge.dart';
import 'package:flutter/material.dart';

class BombollaMissatge extends StatelessWidget {
  final String missatge;

  const BombollaMissatge({super.key, required this.missatge}); // Cambié el nombre del constructor a MyWidget

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          color:  Colors.amber[200],
          child: Text(missatge),
        ),
      ),
    );
  }
}
