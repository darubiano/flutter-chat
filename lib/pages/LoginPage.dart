import 'package:chat/pages/RegisterPage.dart';
import 'package:chat/pages/UsuariosPage.dart';
import 'package:chat/services/AuthService.dart';
import 'package:chat/services/SocketService.dart';
import 'package:chat/widgets/CustomInput.dart';
import 'package:chat/widgets/CustomWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'Login';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                logo('Messenger'),
                _Form(),
                labels(context, RegisterPage.id, 'No tienes cuenta?',
                    'Crear una ahora!'),
                Container(
                  height: 35,
                  child: Text('Terminos y condiciones de uso',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socket = Provider.of<SocketService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          buttonCustom(
            'Ingreso',
            authService.autenticando
                ? null
                : () async{
                  // ocultar teclado
                    FocusScope.of(context).unfocus();
                    //print(emailCtrl.text);
                    //print(passCtrl.text);
                    final loginOk = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());
                    if (loginOk) {
                      socket.connet();
                      Navigator.pushReplacementNamed(context, UsuariosPage.id);
                    } else {
                      // Mostrar alerta
                      mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales');
                    }
                  },
          )
        ],
      ),
    );
  }
}
