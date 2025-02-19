import 'package:firebase_auth/firebase_auth.dart';

class ServeiAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //* Registro
  Future<UserCredential> registeAmbEmailPassword(String email, String password) async {
    print("email " + email);
    print("password " + password);
    
    try {
      // Registra al usuario
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Inicia sesión con las mismas credenciales (esto es opcional, pero si se quiere un usuario logueado inmediatamente, es necesario)
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      return userCredential; // Devuelve el UserCredential si se registra e inicia sesión correctamente
    } on FirebaseAuthException catch (e) {
      // Maneja los errores específicos de FirebaseAuth
      throw Exception(e.message); // Lanza el error con el mensaje específico
    }
  }
}
