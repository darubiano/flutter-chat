import 'dart:io';

// Vriable globales
// no funciona con la ip http://127.0.0.1:3000/ toca con la ip del pc ipconfig
class Enviroments {
  static String apiURL= Platform.isAndroid 
                        ? 'http://192.168.0.8:3000/api' 
                        : 'http://localhost:3000/api';
  static String socketURL = Platform.isAndroid 
                        ? 'http://192.168.0.8:3000/' 
                        : 'http://localhost:3000';
                  
}







