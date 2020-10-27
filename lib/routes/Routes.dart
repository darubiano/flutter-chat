import 'package:chat/pages/ChatPage.dart';
import 'package:chat/pages/LoadingPage.dart';
import 'package:chat/pages/LoginPage.dart';
import 'package:chat/pages/RegisterPage.dart';
import 'package:chat/pages/usuariosPage.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  UsuariosPage.id: (_) => UsuariosPage(),
  ChatPage.id: (_) => ChatPage(),
  LoginPage.id: (_) => LoginPage(),
  RegisterPage.id: (_) => RegisterPage(),
  LoadingPage.id: (_) => LoadingPage(),
};