import 'package:flutter/material.dart';

class EditarDadesUsuaris extends StatefulWidget {
  const EditarDadesUsuaris({super.key});

  @override
  State<EditarDadesUsuaris> createState() => _EditarDadesUsuarisState();
}

class _EditarDadesUsuarisState extends State<EditarDadesUsuaris> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Editar dades usuari"),),
      body: Center(
        child: Column(
          children: [
            Text("Editar Dades Usuaris"),
          ],
        )
      ),
    )
  }
}