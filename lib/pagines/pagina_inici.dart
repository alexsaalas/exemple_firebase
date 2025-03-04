import 'package:exemple_firebase/chat/ServeiChat.dart';
import 'package:exemple_firebase/components/item_usuari.dart';
import 'package:flutter/material.dart';
import 'package:exemple_firebase/auth/servei_auth.dart'; // Asegúrate de importar tu servicio de autenticación

class PaginaInici extends StatefulWidget {
  const PaginaInici({super.key});

  @override
  State<PaginaInici> createState() => _PaginaIniciState();
}

class _PaginaIniciState extends State<PaginaInici> {
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
        backgroundColor: Colors.deepPurple[200],
        title:  Text(ServeiAuth().getUsuariActual()!.email.toString()),
        actions: [
          IconButton(
            onPressed: () async {
              await _logout(context); // Llamamos al método que gestiona el cierre de sesión.
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: ServeiChat().getUsuaris(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error en el snapshot");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Cargando...");
          }

          // Se devuelven los datos
          return ListView(
            children: snapshot.data!.map<Widget>((dadesUsuari) {
              return _construeixUsuari(dadesUsuari); // Llamar a tu función _construeixUsuari
            }).toList(), // Asegúrate de convertir el map en una lista
          );
        },
      ),
    );
  }

  Widget _construeixUsuari(Map<String, dynamic> dadesUsuari) {
    if(dadesUsuari ["email"] == ServeiAuth().getUsuariActual()!.email) {
      return Container();

    }
    
    return ItemUsuari(emailUsuari: dadesUsuari["email"], onTap: () {},);
    // Aquí construyes tu widget para mostrar los datos del usuario
    
  }
}
