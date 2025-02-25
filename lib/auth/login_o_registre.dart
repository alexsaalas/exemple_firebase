import 'package:exemple_firebase/pagines/pagina_login.dart';
import 'package:exemple_firebase/pagines/pagina_registre.dart';
import 'package:flutter/material.dart';

class LoginORegistre extends StatefulWidget {
  const LoginORegistre({super.key});

  @override
  State<LoginORegistre> createState() => _LoginORegistreState();
}

class _LoginORegistreState extends State<LoginORegistre> {

  bool mostraPaginaLogin = true;
  void intercambiarMostrarPaginaLogin(){
    mostraPaginaLogin = !mostraPaginaLogin;
  }

  

  @override
  Widget build(BuildContext context) {

    if(mostraPaginaLogin){
    return PaginaLogin(ferClic: intercambiarMostrarPaginaLogin,);
  }else {
    return PaginaRegistre(ferClic: intercambiarMostrarPaginaLogin,); 
  }
  }
}