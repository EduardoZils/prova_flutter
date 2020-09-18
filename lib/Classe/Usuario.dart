class Usuario {
  String _idUsuario;
  String _nome;
  String _rg;
  String _cpf;
  String _carteirasus;
  String _dtnascimento;
  String _cep;
  String _endereco;
  String _cidade;
  String _estado;
  String _email;
  String _senha;
  String _urlImagem;

  Usuario();

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      "nome": this.nome,
      "email": this.email,
      "senha": this.senha,
      "cpf": this.cpf,
      "rg": this.rg,
      "carteirasus": this.carteirasus,
      "dtnascimento": this.dtnascimento,
      "cep": this.cep,
      "endereco": this.endereco,
      "cidade": this.cidade,
      "estado": this.estado,
      "urlImagem": this.urlImagem
    };

    return map;
  }

  String get idUsuario => _idUsuario;

  set idUsuario(String value) {
    _idUsuario = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  String get cpf => _cpf;

  set cpf(String value) {
    _cpf = value;
  }

  String get email => _email;

  set email(String value) {
    _email = value;
  }

  String get senha => _senha;

  set senha(String value) {
    _senha = value;
  }

  String get urlImagem => _urlImagem;

  set urlImagem(String value) {
    _urlImagem = value;
  }

  String get estado => _estado;

  set estado(String value) {
    _estado = value;
  }

  String get cidade => _cidade;

  set cidade(String value) {
    _cidade = value;
  }

  String get endereco => _endereco;

  set endereco(String value) {
    _endereco = value;
  }

  String get cep => _cep;

  set cep(String value) {
    _cep = value;
  }

  String get dtnascimento => _dtnascimento;

  set dtnascimento(String value) {
    _dtnascimento = value;
  }

  String get carteirasus => _carteirasus;

  set carteirasus(String value) {
    _carteirasus = value;
  }

  String get rg => _rg;

  set rg(String value) {
    _rg = value;
  }
}
