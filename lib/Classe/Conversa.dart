class Conversa {
  String _nome;
  String _mensagem;

  Conversa(this._nome, this._mensagem);

  String get mensagem => _mensagem;

  set mensagem(String value) {
    _mensagem = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }
}