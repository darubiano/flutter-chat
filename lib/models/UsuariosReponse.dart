// To parse this JSON data, do
//
//     final usuariosReponse = usuariosReponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat/models/Usuario.dart';

UsuariosReponse usuariosReponseFromJson(String str) => UsuariosReponse.fromJson(json.decode(str));

String usuariosReponseToJson(UsuariosReponse data) => json.encode(data.toJson());

class UsuariosReponse {
    UsuariosReponse({
        this.ok,
        this.usuario,
        this.desde,
    });

    bool ok;
    List<Usuario> usuario;
    int desde;

    factory UsuariosReponse.fromJson(Map<String, dynamic> json) => UsuariosReponse(
        ok: json["ok"],
        usuario: List<Usuario>.from(json["usuario"].map((x) => Usuario.fromJson(x))),
        desde: json["desde"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuario": List<dynamic>.from(usuario.map((x) => x.toJson())),
        "desde": desde,
    };
}
