import 'package:flutter/material.dart';

class UsuariosPage extends StatelessWidget {
  static const String id = 'Usuarios';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('mundo'),
        centerTitle: true,
        ),
      body: Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}