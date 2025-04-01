import 'dart:io';
import 'dart:typed_data';

import 'package:exemple_firebase/auth/servei_auth.dart';
import 'package:exemple_firebase/mongodb/db_conf.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as mongodb;

class EditarDadesUsuari extends StatefulWidget {
  const EditarDadesUsuari({super.key});

  @override
  State<EditarDadesUsuari> createState() => _EditarDadesUsuariState();
}

class _EditarDadesUsuariState extends State<EditarDadesUsuari> {

  mongodb.Db? _db;
  Uint8List? _imatgeEnBytes;
  final ImagePicker imagePicker = ImagePicker();

  @override
  void dispose() {
    // TODO: implement dispose
    _db?.close();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _connectarAmbMongoDB().then((_) => print("Connectats amb MongoDB"));
  }

  Future _connectarAmbMongoDB() async {

    _db = await mongodb.Db.create(DBConf().connectionString);

    await _db!.open();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar dades usuari"
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Edita les teves dades"),

            // Afegim la imatge o un text
            _imatgeEnBytes != null
                ? Image.memory(
              _imatgeEnBytes!, height: 200,
              )
              : const Text("No s'ha seleccionat cap imatge"),

            const SizedBox(
              height: 20,
            ),

            ElevatedButton(
              onPressed: (){
                _pujarImatge();
              },
              child: const Text("Pujar imatge"),
            ),

            ElevatedButton(
              onPressed: (){
                _recuperarImatge();
              },
              child: const Text("Recuperar imatge"),
            ),
          ],
        ),
      ),
    );
  }

  Future _pujarImatge() async{

    final imatgeSeleccionada = await imagePicker.pickImage(source: ImageSource.gallery);

    // Mirem si ha trobat una imatge.
    if(imatgeSeleccionada != null){

      //Per guardar la imatge l'hem de passar a bytes
      final bytesImatge = await File(imatgeSeleccionada.path).readAsBytes();
      // Passaem els bytes en el format que MongoDB li va bé
      final dadesBinaries = mongodb.BsonBinary.from(bytesImatge);

      final collection = _db!.collection("imatges_perfils");

      await collection.replaceOne(
        {
            "id_usuari_firebase": ServeiAuth().getUsuariActual()!.uid
        }
          ,
        {
          "id_usuari_firebase": ServeiAuth().getUsuariActual()!.uid,
          "nom_foto": "foto_perfil",
          "imatge": dadesBinaries,
          "data_pujada": DateTime.now()
        },

        //Fer que si no troba el document, el crei.
        upsert: true
      );
      print("Imatge pujada");
    }
  }

  Future<void> _recuperarImatge() async{

    try{

      //Ens connectem amb la collection que volem
      final collection = _db!.collection("imatge_perfils");

      //Trobem el document buscat
      final doc = await collection
          .findOne({"id_usuari_firebase": ServeiAuth().getUsuariActual()!.uid});

      //Podem haver recuperat la imatge, però està en el format Bson del MongoDB
      if(doc != null && doc["imatge"] != null){
        final imatgesBson = doc["imatge"] as mongodb.BsonBinary;
        setState(() {
          _imatgeEnBytes = imatgesBson.byteList;
        });
      } else{
        print("Error trobant la imatge en el document");
      }
    }catch(e){
      print("Error intentat recuperar el document");
    }
  }
}