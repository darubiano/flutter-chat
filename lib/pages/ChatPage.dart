import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  static const String id = 'Chat';
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