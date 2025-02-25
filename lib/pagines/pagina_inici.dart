import 'package:flutter/material.dart';
import 'package:exemple_firebase/auth/servei_auth.dart'; // Asegúrate de importar tu servicio de autenticación

class PaginaInici extends StatelessWidget {
  const PaginaInici({super.key});

  // Método para manejar la desconexión (cerrar sesión)
  Future<void> _logout(BuildContext context) async {
    await ServeiAuth().Ferlogout(); // Llamamos a la función Ferlogout.
    // Después de cerrar sesión, puedes redirigir a la pantalla de inicio de sesión o mostrar un mensaje.
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PaginaLogin())); // Ejemplo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagina Inici"),
        actions: [
          IconButton(
            onPressed: () async {
              await _logout(context); // Llamamos al método que gestiona el cierre de sesión.
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text("Pagina Inici"),
      ),
    );
  }
}
