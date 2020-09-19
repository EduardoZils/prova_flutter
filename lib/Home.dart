import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prova_zils/telas/AbaConsulta.dart';
import 'package:prova_zils/telas/AbaContatos.dart';
import 'package:prova_zils/telas/AbaRegistro.dart';

import 'Classe/Usuario.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String _emailUsuarioLogado = "";
  Usuario usuarioMedico = new Usuario();
  List<String> itensMenus = ["Configurações", "Logoff"];

  Future _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();

    setState(() {
      _emailUsuarioLogado = usuarioLogado.email;
    });

    _recuperaMedico();
  }

  _recuperaMedico() async{
      Firestore db = Firestore.instance;

      QuerySnapshot querySnapshot =
      await db.collection("usuarios").where("nome", isEqualTo: "Médico Jorge").getDocuments();
    }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
    Navigator.pushReplacementNamed(context, "/login");
  }

  _escolhaMenu(String itemEscolhido) {
    switch (itemEscolhido) {
      case "Configurações":
        Navigator.pushNamed(context, "/configuracoes");
        break;
      case "Logoff":
        _deslogarUsuario();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _recuperarDadosUsuario();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SUS do BraZils"),
        bottom: TabBar(
          indicatorWeight: 4,
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(
              text: "Atendimento",
            ),
            Tab(
              text: "Consulta",
            ),Tab(
              text: "Chat",
            ),
          ],
        ),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: _escolhaMenu, //metodo para tratar as opções escolhidas
            itemBuilder: (context) {
              //Criou as opções de menu
              return itensMenus.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          AbaRegistro(),
          AbaConsulta(),
          AbaContatos(),
        ],
      ),
    );
  }
}
