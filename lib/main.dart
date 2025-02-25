import 'package:exemple_firebase/auth/portal_auth.dart';
import 'package:exemple_firebase/firebase_options.dart';
import 'package:exemple_firebase/pagines/pagina_login.dart';
import 'package:exemple_firebase/pagines/pagina_registre.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options : DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      home: PortalAuth(),
      
      debugShowCheckedModeBanner: false,

    );
  }

  /*
  1) Tener node.js instalat
  2) Ir a firebase y click a "Go to Console"
  3) Desde console firebase crear nuevo proyecto
  4) Ir al menu Compilacion> Habilitar Authentication y  habilitar Firestore Database
  5) En un cmd ejecutar "npm install -g firebase-tools" (sirve para instalar firebase-tools)
  6) En un cmd ejecutar "firebase login"
  
  */




}
