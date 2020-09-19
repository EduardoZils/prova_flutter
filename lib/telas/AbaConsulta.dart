import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prova_zils/Classe/Laudo.dart';

class AbaConsulta extends StatefulWidget {
  @override
  _AbaConsultaState createState() => _AbaConsultaState();
}

class _AbaConsultaState extends State<AbaConsulta> {
  String _idUsuarioLogado;
  String _emailUsuarioLogado;

  Future<List<Laudo>> _recuperarLaudos() async {
    Firestore db = Firestore.instance;

    QuerySnapshot querySnapshot =
    await db.collection("laudo").getDocuments();

    List<Laudo> listaLaudos = List();
    for (DocumentSnapshot item in querySnapshot.documents) {
      var dados = item.data;
      if (dados["idUsuario"] == _idUsuarioLogado) {
        Laudo laudo = Laudo();
        laudo.idLaudo = item.documentID;
        laudo.descricao = dados["descricao"];

        listaLaudos.add(laudo);
      }
    }
    return listaLaudos;
  }

  _recuperarDadosUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();
    _idUsuarioLogado = usuarioLogado.uid;
    _emailUsuarioLogado = usuarioLogado.email;
  }

  @override
  void initState() {
    super.initState();
    _recuperarDadosUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Laudo>>(
      future: _recuperarLaudos(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: Column(
                children: <Widget>[
                  Text("Carregando Laudos"),
                  CircularProgressIndicator()
                ],
              ),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, indice) {
                  List<Laudo> listaItens = snapshot.data;
                  Laudo laudo = listaItens[indice];

                  return ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, "/detalhes",
                          arguments: laudo);
                    },
                    contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    title: Text(
                      laudo.descricao,
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  );
                });
            break;
        }
      },
    );
  }
}
