import 'dart:convert';
import 'package:chat/global/Enviroments.dart';
import 'package:chat/models/LoginResponse.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier{
  Usuario usuario;
  bool _autenticando = false;
  // Create storage para guardar token
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor){
    this._autenticando = valor;
    notifyListeners();
  }

  //Getters del token
  static Future<String> getToken()async{
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken()async{
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }
  Future _guardarToken(String token) async{
    // Write value 
    return await _storage.write(key: 'token', value: token);
  }

  Future logOut()async{
    // Delete value 
    await _storage.delete(key: 'token');
  }


  Future<bool> login(String email, String password) async{
    this.autenticando = true;
    Map<String, String> data = {
      "email":email,
      "password": password
    };

    final resp = await http.post('${Enviroments.apiURL}/login',
      body: jsonEncode(data),
      headers: {
        'Content-Type':'application/json'
      }
    );
    //print(resp.body);
    this.autenticando = false;
    if(resp.statusCode == 200){
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    }else{
      return false;
    }

  }

  Future register(String nombre, String email,String password) async{
    this.autenticando = true;
    Map<String, String> data = {
      "nombre":nombre,
      "email":email,
      "password": password,
    };
    final resp = await http.post('${Enviroments.apiURL}/login/new',
      body: jsonEncode(data),
      headers: {
        'Content-Type':'application/json'
      }
    );
    //print(resp.body);
    this.autenticando = false;
    if(resp.statusCode == 200){
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    }else{
      final resBody = jsonDecode(resp.body);
      return resBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async{
    final token = await this._storage.read(key: 'token');
    final resp = await http.get('${Enviroments.apiURL}/login/renew',
      headers: {
        'Content-Type':'application/json',
        'x-token':token
      }
    );
    //print(resp.body);
    if(resp.statusCode == 200){
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    }else{
      this.logOut();
      return false;
    }
    
  }
  

}