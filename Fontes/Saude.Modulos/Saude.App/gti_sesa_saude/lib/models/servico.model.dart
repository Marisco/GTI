class ServicoModel {
  List<_Servico> _results = [];

  ServicoModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['servicos'].length);

    List<_Servico> temp = [];
    for (int i = 0; i < parsedJson['servicos'].length; i++) {
      _Servico result = _Servico(parsedJson['servicos'][i]);
      temp.add(result);
    }
    this._results = temp;
  }
  List<_Servico> getServicos() {
    return this._results.isEmpty ? [] : this._results;
  }
}

class _Servico {
  String _numero;
  String _nome;
  String _descricao;

  _Servico(result) {
    _numero = result['numero'].toString();
    _nome = result['nome'];
    _descricao = result['descricao'].toString();
  }

  String get numero => _numero;
  String get nome => _nome;
  String get descricao => _descricao;
}
