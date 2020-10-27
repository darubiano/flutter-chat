import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  static const String id = 'Loading';
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