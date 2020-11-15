import 'package:chat/pages/LoadingPage.dart';
import 'package:chat/routes/Routes.dart';
import 'package:chat/services/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>AuthService(),)
      ],
      child: MaterialApp(
        title: 'ChatApp',
        debugShowCheckedModeBanner: false,
        initialRoute: LoadingPage.id,
        routes: appRoutes,
      ),
    );
  }
}
