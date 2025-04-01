import 'package:exemple_firebase/auth/servei_auth.dart';
import 'package:exemple_firebase/models/missatge.dart';
import 'package:flutter/material.dart';

class BombollaMissatge extends StatelessWidget {
  final String missatge;
  final String idAutor;

  const BombollaMissatge({
    super.key, 
    required this.missatge, 
    required this.idAutor
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Align(
          alignment: idAutor == ServeiAuth().getUsuariActual()!.uid 
              ? Alignment.centerRight 
              : Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: idAutor == ServeiAuth().getUsuariActual()!.uid 
                  ? Colors.green 
                  : Colors.amber[200], // Usamos amber[200] que era el color que tenías aparte
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(12), // Añadido padding para mejor visualización
            child: Text(
              missatge,
              style: TextStyle(
                color: idAutor == ServeiAuth().getUsuariActual()!.uid
                    ? Colors.white // Texto blanco para mensajes verdes (propios)
                    : Colors.black, // Texto negro para mensajes amarillos (ajenos)
              ),
            ),
          ),
        ),
      ),
    );
  }
}