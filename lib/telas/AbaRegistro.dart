import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prova_zils/Classe/Laudo.dart';

class AbaRegistro extends StatefulWidget {
  @override
  _AbaRegistroState createState() => _AbaRegistroState();
}

class _AbaRegistroState extends State<AbaRegistro> {
  bool _febre = false;
  bool _diarreia = false;
  bool _coriza = false;
  bool _tosse = false;
  bool _espirro = false;
  String label = "";
  String _mensagemErro = "";
  double temperatura = 34;
  int contador = 0;

  List<String> urlImagens = [];

  File _imagem;
  String _idUsuarioLogado = "";
  String _urlImagemRecuperada;
  bool _subindoImagem = false;

  TextEditingController _controllerDescricao = TextEditingController();

  Future _recuperarImagem(String origemImagem) async {
    File imagemSelecionada;
    switch (origemImagem) {
      case "camera":
        imagemSelecionada =
            await ImagePicker.pickImage(source: ImageSource.camera);
        break;
      case "galeria":
        imagemSelecionada =
            await ImagePicker.pickImage(source: ImageSource.gallery);
        break;
    }

    setState(() {
      _imagem = imagemSelecionada;
      if (_imagem != null) {
        _subindoImagem = true;
        _uploadImagem();
        contador++;
      }
    });
  }

  Future _uploadImagem() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser usuarioLogado = await auth.currentUser();

    _idUsuarioLogado = usuarioLogado.uid;
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();
    StorageReference arquivo = pastaRaiz
        .child("imagens")
        .child(_idUsuarioLogado + "-" + contador.toString() + ".jpg");

    //Upload da imagem
    StorageUploadTask task = arquivo.putFile(_imagem);

    //Controlar progresso do upload
    task.events.listen((StorageTaskEvent storageEvent) {
      if (storageEvent.type == StorageTaskEventType.progress) {
        setState(() {
          _subindoImagem = true;
        });
      } else if (storageEvent.type == StorageTaskEventType.success) {
        setState(() {
          _subindoImagem = false;
        });
      }
    });

    //Recuperar url da imagem
    task.onComplete.then((StorageTaskSnapshot snapshot) {
      _recuperarUrlImagem(snapshot);
    });
  }

  Future _recuperarUrlImagem(StorageTaskSnapshot snapshot) async {
    String url = await snapshot.ref.getDownloadURL();
    setState(() {
      _urlImagemRecuperada = url;
    });
  }

  _validaCampos() async {
    String _descricao = _controllerDescricao.text.toString();

    if (_descricao.isNotEmpty) {
      setState(() {
        _mensagemErro = "Cadastrado com Sucesso!";
      });

      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseUser usuarioLogado = await auth.currentUser();

      Laudo laudo = Laudo();
      laudo.idUsuario = usuarioLogado.uid;
      laudo.descricao = _descricao;
      laudo.coriza = _coriza;
      laudo.tosse = _tosse;
      laudo.espirro = _espirro;
      laudo.febre = _febre;
      laudo.diarreia = _diarreia;
      laudo.descricao = _descricao;
      laudo.temperatura = temperatura;

      await _cadastrarLaudo(laudo);
    } else {
      setState(() {
        _mensagemErro = "Por favor descreva oque está sentindo!";
      });
    }
  }

  _cadastrarLaudo(Laudo laudo) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    Firestore db = Firestore.instance;

    db.collection("laudo").document(laudo.idLaudo).setData(laudo.toMap());

    //Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.all(16),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Text(
                    "Informe abaixo os sintomas que tem sentido",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                CheckboxListTile(
                    title: Text("Febre"),
                    activeColor: Color(0xff224B8B),
                    value: _febre,
                    onChanged: (bool valor) {
                      setState(() {
                        _febre = valor;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Diarréia"),
                    activeColor: Color(0xff224B8B),
                    value: _diarreia,
                    onChanged: (bool valor) {
                      setState(() {
                        _diarreia = valor;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Coriza"),
                    activeColor: Color(0xff224B8B),
                    value: _coriza,
                    onChanged: (bool valor) {
                      setState(() {
                        _coriza = valor;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Tosse"),
                    activeColor: Color(0xff224B8B),
                    value: _tosse,
                    onChanged: (bool valor) {
                      setState(() {
                        _tosse = valor;
                      });
                    }),
                CheckboxListTile(
                    title: Text("Espirro"),
                    activeColor: Color(0xff224B8B),
                    value: _espirro,
                    onChanged: (bool valor) {
                      setState(() {
                        _espirro = valor;
                      });
                    }),
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    controller: _controllerDescricao,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                        hintText: "Descrição",
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32))),
                  ),
                ),
                Container(
                  child: Text(
                    "Informe sua temperatura no Slider abaixo",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                Slider(
                    value: temperatura,
                    min: 29,
                    max: 45,
                    label: label,
                    divisions: 100,
                    activeColor: Color(0xff224B8B),
                    inactiveColor: Color(0xffB2DDFF),
                    onChanged: (double novoValor) {
                      setState(() {
                        temperatura = novoValor;
                        label = novoValor.toString();
                      });
                    }),
                Container(
                  child: Text(
                    "Anexe imagens de Laudos (opcional)",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                FlatButton(
                    onPressed: () {
                      _recuperarImagem("camera");
                    },
                    child: Icon(Icons.add_a_photo)),
                Container(
                  child: Text(
                    "Imagens Anexadas: " + contador.toString(),
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 16),
                  child: RaisedButton(
                      child: Text(
                        "Solicitar Atendimento",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      color: Color(0xff224B8B),
                      padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32)),
                      onPressed: () {
                        _validaCampos();
                      }),
                ),
                Center(
                  child: Text(
                    _mensagemErro,
                    style: TextStyle(fontSize: 24, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
