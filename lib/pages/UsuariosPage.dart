import 'package:chat/models/Usuario.dart';
import 'package:chat/pages/ChatPage.dart';
import 'package:chat/pages/LoginPage.dart';
import 'package:chat/services/AuthService.dart';
import 'package:chat/services/ChatService.dart';
import 'package:chat/services/SocketService.dart';
import 'package:chat/services/UsuariosService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  static const String id = 'Usuarios';
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  final usuariosService = new UsuariosService();
  List<Usuario> usuarios = [];
  /*final usuarios = [
    Usuario(uid: '1', nombre: 'Mario', email: 'mario@gmail.com', online: true),
    Usuario(uid: '2', nombre: 'David', email: 'david@gmail.com', online: false),
    Usuario(
        uid: '3',
        nombre: 'Santiago',
        email: 'santiago@gmail.com',
        online: true),
    Usuario(
        uid: '4', nombre: 'Gabriel', email: 'gabriel@gmail.com', online: true),
    Usuario(uid: '5', nombre: 'Evert', email: 'evert@gmail.com', online: false),
  ];*/

  @override
  void initState() {
    _cargarUsuarios();
    super.initState();
  }
  
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final usuario = authService.usuario;
    final socket = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          usuario.nombre,
          style: TextStyle(color: Colors.black87),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87),
          onPressed: () {
            socket.disconnet();
            Navigator.pushReplacementNamed(context, LoginPage.id);
            AuthService.deleteToken();
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socket.serverStatus == ServerStatus.Offline)
            ? Icon(Icons.offline_bolt, color: Colors.red)
            : Icon(Icons.check_circle, color: Colors.blue[400]),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(
            Icons.check,
            color: Colors.blue[400],
          ),
          waterDropColor: Colors.blue[400],
        ),
        child: _listViewUsuarios(),
      ),
    );
  }

  void _cargarUsuarios() async {
    usuarios = await usuariosService.getUsuarios();
    setState(() {});
    //await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
        backgroundColor: Colors.blue[200],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: usuario.online ? Colors.green[300] : Colors.red,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onTap: (){
        print(usuario.uid);
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, ChatPage.id);
      },
    );
  }
}
