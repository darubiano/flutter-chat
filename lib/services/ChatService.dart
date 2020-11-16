import 'package:chat/global/Enviroments.dart';
import 'package:chat/models/MensajesResponse.dart';
import 'package:chat/services/AuthService.dart';
import 'package:http/http.dart' as http;
import 'package:chat/models/Usuario.dart';
import 'package:flutter/material.dart';

class ChatService with ChangeNotifier{

  Usuario usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async{
    final resp = await http.get('${Enviroments.apiURL}/mensajes/$usuarioID',
      headers: {
        'Content-Type':'application/json',
        'x-token': await AuthService.getToken()
      }
    );

    final mensajesResp = mensajesResponseFromJson(resp.body);
    return mensajesResp.mensajes;
  }
  
}