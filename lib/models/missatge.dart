import 'package:cloud_firestore/cloud_firestore.dart';

class Missatge {
  final String idAutor;
  final String emailAutor;
  final String idReceptor;
  final String missatge;
  final Timestamp timestamp; // Cambié el tipo a Timestamp de Firebase

  // Constructor
  Missatge({
    required this.idAutor,
    required this.emailAutor,
    required this.idReceptor,
    required this.missatge,
    required this.timestamp, // Ahora es de tipo Timestamp
  });

  // Método para convertir el objeto a un mapa de datos
  Map<String, dynamic> retornaMapaMissatge() {
    return {
      "idAutor": idAutor,
      "emailAutor": emailAutor,
      "idReceptor": idReceptor,
      "missatge": missatge,
      "timestamp": timestamp, // Usamos el Timestamp directamente
    };
  }
}
