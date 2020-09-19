import 'package:flutter/material.dart';
import 'package:prova_zils/Cadastro.dart';
import 'package:prova_zils/Detalhes.dart';
import 'package:prova_zils/Home.dart';
import 'package:prova_zils/Login.dart';
import 'package:prova_zils/Mensagens.dart';
class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => Login());
      case "/login":
        return MaterialPageRoute(builder: (_) => Login());
      case "/cadastro":
        return MaterialPageRoute(builder: (_) => Cadastro());
      case "/home":
        return MaterialPageRoute(builder: (_) => Home());
      case "/mensagem":
        return MaterialPageRoute(builder: (_) => Mensagens(args));
      case "/detalhes":
        return MaterialPageRoute(builder: (_) => Detalhes());
      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Tela não encontrada!"),
        ),
        body: Center(
          child: Text("Tela não encontrada!"),
        ),
      );
    });
  }
}