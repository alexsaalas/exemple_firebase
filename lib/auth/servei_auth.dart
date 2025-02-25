import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ServeiAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fer login
  Future<String?> loginAmbEmailPassword(String email, String password) async {
    try {
      UserCredential credentialUsuari = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;

    } on FirebaseAuthException catch (e) {
      return "Error ${e.message}";
    }


  //* Registro
  Future<String?> registeAmbEmailPassword(String email, String password) async {
    

    try {  
      // Registra al usuario
      UserCredential userCredential = 
      await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password);

      // Inicia sesión con las mismas credenciales (esto es opcional, pero si se quiere un usuario logueado inmediatamente, es necesario)
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      _firestore.collection("Usuaris").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,           
        "email": email,
        "nom":"",
      });

      return null; // Devuelve el UserCredential si se registra e inicia sesión correctamente
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          return "El email ya está en uso";
        case "invalid-email":
          return "El email no es válido";
        case "operation-not-allowed":
          return "El usuario ya está registrado";
        case "weak-password":
          return "La contraseña es muy débil";
          default:
          return "Error ${e.message}";
      }
        // Maneja los errores específicos de FirebaseAuth
       // Lanza el error con el mensaje específico
    } catch (e) {
      return "Error $e";
    }
  }
}
}