
import 'package:flutter/material.dart';

Widget logo(String titulo) {
  return Center(
    child: Container(
      width: 170,
      margin: EdgeInsets.only(top:30),
      child: Column(
        children: <Widget>[
          Image(image: AssetImage('assets/tag-logo.png')),
          Text(titulo, style: TextStyle(fontSize: 30)),
        ],
      ),
    ),
  );
}

Widget labels(BuildContext context, String ruta, String titulo, String subtitulo) {
  return Container(
    child: Column(
      children: <Widget>[
        Text(titulo,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            )),
        SizedBox(height: 10),
        GestureDetector(
          child: Text(subtitulo,
              style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
          onTap: (){
            Navigator.pushReplacementNamed(context, ruta);
          },
        ),
      ],
    ),
  );
}

Widget buttonCustom(String text, Function onPressed){
  return RaisedButton(
          elevation: 2,
          highlightElevation: 5,
          color: Colors.blue,
          shape: StadiumBorder(),
          child: Container(
            width: double.infinity,
            height: 25,
            child: Text(text,
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center),
          ),
          onPressed: onPressed
        );
}