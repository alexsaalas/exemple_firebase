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

  // Usamos el FocusNode para escuchar cambios del teclado
  FocusNode teclatMobil = FocusNode();

  @override
  void initState() {
    super.initState();

    // Agregamos un listener al FocusNode para controlar cuando el teclado se abre/cierra
    teclatMobil.addListener(() {
      if (teclatMobil.hasFocus) {
        // El teclado está visible
        Future.delayed(const Duration(milliseconds: 500), () {
          ferScrollCapAvall();
        });
      }
    });

    // Este Future.delayed es redundante ya que se manejará con el listener de teclatMobil
    Future.delayed(const Duration(milliseconds: 500), () {
      ferScrollCapAvall();
    });
  }

  @override
  void dispose() {
    // No olvides limpiar el FocusNode
    teclatMobil.dispose();
    super.dispose();
  }

  void ferScrollCapAvall() {
    // Desplazamos la lista hasta el final
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 40,
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
          // Zona de mensajes
          _crearZonaMostrarMensajes(),

          // Zona para enviar mensajes
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

          // Si hay datos (mensajes)
          if (snapshot.hasData) {
            return ListView(
              controller: _scrollController,
              children: snapshot.data!.docs.map((document) {
                return _construirItemMissatge(document);
              }).toList(),
            );
          }

          // Si no hay mensajes
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
              focusNode: teclatMobil, // Vinculamos el FocusNode al TextField
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
            color: Colors.green, // Color del ícono
          ),
        ],
      ),
    );
  }

  void enviarMissatge() async {
    if (tecMissatge.text.isNotEmpty) {
      // Enviar el mensaje a Firestore
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
