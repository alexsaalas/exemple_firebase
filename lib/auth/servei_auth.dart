import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ServeiAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;




  // Usuari actual
  User? getUsuariActual(){
    return _auth.currentUser;
    
  }
  // Fer logout
  Future<void> Ferlogout() async {
    return await _auth.signOut();
  }

  // Fer login
  Future<String?> loginAmbEmailPassword(String email, String password) async {
    try {
      UserCredential credentialUsuari = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Comprobar si existe el usuario en Firestore
      final QuerySnapshot querySnapshot = await _firestore.collection("Usuaris").where("email", isEqualTo: email).get();
      if(querySnapshot.docs.isEmpty){
        _firestore.collection("Usuaris").doc(credentialUsuari.user!.uid).set({
        "uid": credentialUsuari.user!.uid,
        "email": email,
        "nom": "", // Aquí puedes agregar el campo 'nom' si es necesario
      });
      } 
      return null;
    } on FirebaseAuthException catch (e) {
      return "Error ${e.message}";
    }
  }

  //* Registro
  Future<String?> registeAmbEmailPassword(String email, String password) async {
    try {
      // Registra al usuario
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Guardar los datos del usuario en Firestore
      _firestore.collection("Usuaris").doc(userCredential.user!.uid).set({
        "uid": userCredential.user!.uid,
        "email": email,
        "nom": "", // Aquí puedes agregar el campo 'nom' si es necesario
      });

      return null; // Devuelve null si el registro y inicio de sesión son exitosos
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
    } catch (e) {
      return "Error $e";
    }
  }
}
