import 'package:exemple_firebase/chat/ServeiChat.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PaginaChat extends StatefulWidget {
  final String idReceptor;
  const PaginaChat({super.key, required this.idReceptor,});

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
    return Expanded(child: Text("Zona1"));
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

    if(tecMissatge.text.isNotEmpty){
      ServeiChat().enviarMensaje(
        widget.idReceptor, 
        tecMissatge.text
        );

        tecMissatge.clear();


  }

}
}