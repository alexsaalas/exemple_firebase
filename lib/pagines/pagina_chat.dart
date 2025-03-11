import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exemple_firebase/auth/servei_auth.dart';
import 'package:exemple_firebase/chat/ServeiChat.dart';
import 'package:exemple_firebase/components/bombolla_missatge.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaginaChat extends StatefulWidget {
  final String idReceptor;
  const PaginaChat({super.key, required this.idReceptor});

  @override
  State<PaginaChat> createState() => _PaginaChatState();
}

class _PaginaChatState extends State<PaginaChat> {
  final TextEditingController tecMissatge = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Sala chat"),
      ),
      body: Column(
        children: [
          // Zona mensajes
          _crearZonaMostrarMensajes(),

          // Zona enviar mensaje
          _crearZonaEnviarMensaje(),
        ],
      ),
    );
  }

  Widget _crearZonaMostrarMensajes() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: ServeiChat().getMissatges(
          ServeiAuth().getUsuariActual()!.uid,
          widget.idReceptor,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error en el snapshot");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Cargando...");
          }

          // Retornar datos (mensajes)
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return _construirItemMissatge(document);
              }).toList(),
            );
          }

          // Si no hay datos
          return const Center(child: Text("No hay mensajes"));
        },
      ),
    );
  }

  Widget _crearZonaEnviarMensaje() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: tecMissatge,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.amber[200],
              ),
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            onPressed: enviarMissatge,
            icon: const Icon(Icons.send),
            color: Colors.green, // Cambia el color del icono aquí
          ),
        ],
      ),
    );
  }

  void enviarMissatge() async {
    if (tecMissatge.text.isNotEmpty) {
      await ServeiChat().enviarMensaje(
        widget.idReceptor,
        tecMissatge.text,
      );

      tecMissatge.clear();
    }
  }

  // Función para construir un item de mensaje
  Widget _construirItemMissatge(DocumentSnapshot DocumentSnapshot) {
     Map<String, dynamic> data = DocumentSnapshot.data() as Map<String, dynamic>;

     return BombollaMissatge(missatge : data["missatge"]);

    // Timestamp si existe
    ;
  }
}
