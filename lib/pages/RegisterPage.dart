import 'package:chat/pages/LoginPage.dart';
import 'package:chat/pages/UsuariosPage.dart';
import 'package:chat/services/AuthService.dart';
import 'package:chat/widgets/CustomInput.dart';
import 'package:chat/widgets/CustomWidgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  static const String id = 'Register';
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
                logo('Registro'),
                _Form(),
                labels(context, LoginPage.id, 'Ya tienes una cuenta?',
                    'Ingresa ahora!'),
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
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
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
                : () async {
                    //print(emailCtrl.text);
                    //print(nameCtrl.text);
                    //print(passCtrl.text);
                    final registerOK = await authService.register(
                        nameCtrl.text.trim(),
                        emailCtrl.text.trim(),
                        passCtrl.text.trim());
                    if (registerOK == true) {
                      // TODO: conectar al socket server
                      Navigator.pushReplacementNamed(context, UsuariosPage.id);
                    } else {
                      // Mostrar alerta
                      mostrarAlerta(context, 'Resigtro incorrecto',registerOK);
                    }
                  },
          ),
        ],
      ),
    );
  }
}
