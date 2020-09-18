import 'package:flutter/material.dart';
import 'package:prova_zils/Login.dart';
import 'package:prova_zils/RouteGenerator.dart';

void main() async {
  runApp(MaterialApp(
    home: Login(),
    theme: ThemeData(
        primaryColor: Color(0xff4169E1), accentColor: Color(0xff87CEFA)),
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    onGenerateRoute: RouteGenerator
        .generateRoute, //chamado toda vez que uma rota precisa ser inicializada ou aberta

  ));
}