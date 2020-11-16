import 'package:chat/global/Enviroments.dart';
import 'package:chat/models/UsuariosReponse.dart';
import 'package:chat/services/AuthService.dart';
import 'package:http/http.dart' as http;
import 'package:chat/models/Usuario.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get(
        '${Enviroments.apiURL}/usuarios',
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        },
      );

      final usuariosReponse = usuariosReponseFromJson(resp.body);
      return usuariosReponse.usuario;
    } catch (e) {
      return [];
    }
  }
}
