import 'package:flutter/material.dart';

class ItemUsuari extends StatelessWidget {
  final String emailUsuari;
  
  const ItemUsuari({super.key, required this.emailUsuari});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber[200],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(top: 10, left: 40, right: 40),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(emailUsuari),
      ));
  }
}