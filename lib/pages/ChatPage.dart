import 'dart:io';
import 'package:chat/models/MensajesResponse.dart';
import 'package:chat/services/AuthService.dart';
import 'package:chat/services/ChatService.dart';
import 'package:chat/widgets/ChatMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat/services/SocketService.dart';

class ChatPage extends StatefulWidget {
  static const String id = 'Chat';
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _estaEscribiendo = false;
  ChatService chatService;
  SocketService socket;
  AuthService authService;
  List<ChatMessage> _messages = [
    /*ChatMessage(uid: '123', texto: 'Hola mundo',),
    ChatMessage(uid: '123', texto: 'Hola mundo',),
    ChatMessage(uid: '124', texto: 'Hola mundo1',),
    ChatMessage(uid: '123', texto: 'Hola mundo',),
    ChatMessage(uid: '124', texto: 'Hola mundo1',),
    ChatMessage(uid: '123', texto: 'Hola mundo',),
    ChatMessage(uid: '124', texto: 'Hola mundo1',),*/
  ];

  @override
  void initState() {
    this.chatService = Provider.of<ChatService>(context, listen: false);
    this.socket = Provider.of<SocketService>(context, listen: false);
    this.authService = Provider.of<AuthService>(context, listen: false);
    this.socket.socket.on('mensaje-personal', _escucharMensaje);
    _cargarHistorial(this.chatService.usuarioPara.uid);
    super.initState();
  }

  void _escucharMensaje(dynamic data) {
    ChatMessage message = new ChatMessage(
      texto: data['mensaje'],
      uid: data['de'],
      animationController: AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  void _cargarHistorial(String usuarioID)async{
    List<Mensaje> chat = await this.chatService.getChat(usuarioID);
    final history = chat.map((m) => new ChatMessage(
      texto: m.mensaje,
      uid: m.de,
      animationController: new AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 0),
      )..forward(),
    ));
    setState(() {
      _messages.insertAll(0, history);
    });
  }


  @override
  Widget build(BuildContext context) {
    final usuarioPara = this.chatService.usuarioPara;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Text(usuarioPara.nombre.substring(0, 2),
                  style: TextStyle(fontSize: 12)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            Text(usuarioPara.nombre,
                style: TextStyle(color: Colors.black87, fontSize: 18)),
            /*Icon(
              Icons.settings,
              color: Colors.black,
            ),*/
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: _messages.length,
              itemBuilder: (_, i) => _messages[i],
              reverse: true,
            )),
            Divider(
              height: 1,
            ),
            Container(
              color: Colors.white,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (texto) {
                  setState(() {
                    if (texto.trim().length > 0) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration:
                    InputDecoration.collapsed(hintText: 'Enviar mensaje'),
                focusNode: _focusNode,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: _estaEscribiendo
                          ? () => _handleSubmit(_textController.text)
                          : null,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(Icons.send),
                          onPressed: _estaEscribiendo
                              ? () => _handleSubmit(_textController.text)
                              : null,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  _handleSubmit(String texto) {
    if (texto.length == 0) return null;
    _textController.clear();
    _focusNode.requestFocus();
    final newMessage = ChatMessage(
      uid: this.authService.usuario.uid,
      texto: texto,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      _estaEscribiendo = false;
    });
    this.socket.emit('mensaje-personal', {
      'de': authService.usuario.uid,
      'para': chatService.usuarioPara.uid,
      'mensaje': texto
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    this.socket.socket.off('mensaje-personal');
    super.dispose();
  }
}
