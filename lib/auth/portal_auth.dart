import 'package:exemple_firebase/auth/login_o_registre.dart';
import 'package:exemple_firebase/pagines/pagina_inici.dart';
import 'package:exemple_firebase/pagines/pagina_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PortalAuth extends StatelessWidget {
  const PortalAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        // Stream de dades
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context, snapshot) {
        // Dades que nos llegan del servicio
        if (snapshot.hasData) {
          return const PaginaInici();
        } else {
          return const LoginORegistre();
        }
      }
    ),
  );
  }
}