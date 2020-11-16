import 'package:chat/global/Enviroments.dart';
import 'package:chat/services/authService.dart';
import 'package:flutter/cupertino.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// Estados del socket
enum ServerStatus{
  Online,
  Offline,
  Connecting
}

class SocketService with ChangeNotifier{

  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;
  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  void connet() async{

    final token = await AuthService.getToken();

    // Conexion del cliente
    this._socket = IO.io(Enviroments.socketURL,{
      'transports':['websocket'],
      'autoConnect':true,
      'forceNew':true,
      'extraHeaders':{
        'x-token':token
      }
    });

    this._socket.on('connect', (_) {
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });

    this._socket.on('disconnect', (_){
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    this._socket.on('nuevo-mensaje', (payload){
      print('nombre:' + payload['nombre']);
      print('mensaje:' + payload['mensaje']);
    });

    //socket.off();
  }

  void disconnet(){
    this._socket.disconnect();
  }

}