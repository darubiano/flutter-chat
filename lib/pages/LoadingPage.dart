import 'package:chat/pages/LoginPage.dart';
import 'package:chat/pages/UsuariosPage.dart';
import 'package:chat/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  static const String id = 'Loading';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/loading.gif'),
              Text(
                'Cargando',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();
    if (autenticado) {
      //TODO: conectar socket server
      Navigator.pushReplacementNamed(context, UsuariosPage.id);
      /*Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_,__,___)=>UsuariosPage(),
          transitionDuration: Duration(milliseconds:0)
        ),
      );*/
    } else {
      Navigator.pushReplacementNamed(context, LoginPage.id);
    }
  }
}
