import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exemple_firebase/models/missatge.dart'; // Asegúrate de tener esta clase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ServeiChat {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Método para obtener los usuarios de la colección 'Usuaris'
  Stream<List<Map<String, dynamic>>> getUsuaris() {
    return _firestore.collection("Usuaris").snapshots().map((event) {
      return event.docs.map((document) {
        return document.data() as Map<String, dynamic>;
      }).toList();
    });
  }

  // Método para enviar mensaje entre usuarios
  Future<void> enviarMensaje(String idReceptor, String missatge) async {
    String idUsuariActual = _auth.currentUser!.uid;
    String emailUsuariActual = _auth.currentUser!.email!;
    Timestamp timestamp = Timestamp.now();

    // Crear una instancia de la clase Missatge
    Missatge nouMissatge = Missatge(
      idAutor: idUsuariActual,
      emailAutor: emailUsuariActual,
      idReceptor: idReceptor,
      missatge: missatge,
      timestamp: timestamp, // Usar la variable timestamp aquí
    );

    // Ordenar los IDs de los usuarios para crear una sala de chat única
    List<String> idsUsuaris = [idUsuariActual, idReceptor];
    idsUsuaris.sort(); // Ordena la lista de IDs para evitar duplicados

    String idSalaChat = idsUsuaris.join("_");

    // Guardar el mensaje en la colección correspondiente
    await _firestore.collection("SalesChat")
        .doc(idSalaChat) // Referencia única de la sala
        .collection("Missatges") // Subcolección de mensajes
        .add({
      'idAutor': nouMissatge.idAutor,
      'emailAutor': nouMissatge.emailAutor,
      'idReceptor': nouMissatge.idReceptor,
      'missatge': nouMissatge.missatge,
      'timestamp': nouMissatge.timestamp,
    });
  }
}
