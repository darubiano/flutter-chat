import 'dart:io';

// Vriable globales
// no funciona con la ip http://127.0.0.1:3000/ toca con la ip del pc ipconfig
// Para probar en local 'http://192.168.0.8:3000/api'
class Enviroments {
  static String apiURL= Platform.isAndroid 
                        ? "flutter-chat-node.herokuapp.com"
                        : "flutter-chat-node.herokuapp.com";
  static String socketURL = Platform.isAndroid 
                        ? "flutter-chat-node.herokuapp.com/" 
                        : "flutter-chat-node.herokuapp.com/";
                  
}







