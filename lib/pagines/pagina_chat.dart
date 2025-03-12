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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500), () {
      ferScrollCapAvall();
    });
  }

  void ferScrollCapAvall() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Sala chat"),
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
              controller: _scrollController,
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
      Future.delayed(const Duration(milliseconds: 500), () {
        ferScrollCapAvall();
      });
    }
  }

  // Función para construir un item de mensaje
  Widget _construirItemMissatge(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return BombollaMissatge(
      missatge: data["missatge"],
      idAutor: data["idAutor"],
    );
  }
}
