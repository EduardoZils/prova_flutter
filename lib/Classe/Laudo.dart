/*Alguns sintomas
são pré-definidos na aplicação: (febre, diarreia, coriza, tosse, espirro pode ser
utilizado como checkbox). Na mesma interface do usuário irá informar dados como
descrição do problema, anexar imagens (laudos, exames), informar a temperatura
(deve ser utilizado como componente de entrada um slider), um campo de entrada
para informar a pressão arterial e um botão para envio da informações. Lembrando
que esse registro deverá gerar um número de protocolo.
 */

class Laudo {
  String _idLaudo;
  String _idUsuario;
  bool _febre;
  bool _diarreia;
  bool _coriza;
  bool _tosse;
  bool _espirro;
  List<String> _urlImagem;
  String _descricao;
  List<String> urlImagens;
  double _temperatura;

  Laudo();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "idUsuario": this._idUsuario,
      "febre": this._febre,
      "diarreia": this._diarreia,
      "coriza": this._coriza,
      "tosse": this._tosse,
      "espirro": this._espirro,
      "urlImagem": this._urlImagem,
      "temperatura": this._temperatura,
      "descricao": this._descricao,
    };

    return map;
  }


  double get temperatura => _temperatura;

  set temperatura(double value) {
    _temperatura = value;
  }

  String get descricao => _descricao;

  set descricao(String value) {
    _descricao = value;
  }

  List<String> get urlImagem => _urlImagem;

  set urlImagem(List<String> value) {
    _urlImagem = value;
  }

  bool get espirro => _espirro;

  set espirro(bool value) {
    _espirro = value;
  }

  bool get tosse => _tosse;

  set tosse(bool value) {
    _tosse = value;
  }

  bool get coriza => _coriza;

  set coriza(bool value) {
    _coriza = value;
  }

  bool get diarreia => _diarreia;

  set diarreia(bool value) {
    _diarreia = value;
  }

  bool get febre => _febre;

  set febre(bool value) {
    _febre = value;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get idLaudo => _idLaudo;

  set idLaudo(String value) {
    _idLaudo = value;
  }
  
}
