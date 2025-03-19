import 'package:exemple_firebase/auth/servei_auth.dart';
import 'package:exemple_firebase/models/missatge.dart';
import 'package:flutter/material.dart';

class BombollaMissatge extends StatelessWidget {
  final String missatge;
  final String idAutor;

  const BombollaMissatge({super.key, required this.missatge, required this.idAutor}); // Cambié el nombre del constructor a MyWidget

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: idAutor == ServeiAuth().getUsuariActual()!.uid ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: idAutor == ServeiAuth().getUsuariActual()!.uid ? Colors.green : Colors.amber[100],
              borderRadius: BorderRadius.circular(10),
            ),
            color:  Colors.amber[200],
            child: Text(missatge),
          ),
        ),
      ),
    );
  }
}
