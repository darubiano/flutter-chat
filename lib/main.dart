import 'package:chat/pages/LoginPage.dart';
import 'package:chat/routes/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      title: 'ChatApp',
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPage.id,
      routes: appRoutes,
    );
  }
}