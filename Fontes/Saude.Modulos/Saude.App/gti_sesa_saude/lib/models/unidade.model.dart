class UnidadeModel {
  List<_Unidade> _results = [];

  UnidadeModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['unidades'].length);

    List<_Unidade> temp = [];
    for (int i = 0; i < parsedJson['unidades'].length; i++) {
      _Unidade result = _Unidade(parsedJson['unidades'][i]);
      temp.add(result);
    }
    this._results = temp;
  }
  List<_Unidade> getUnidades() {
    return this._results.isEmpty ? [] : this._results;
  }
}

class _Unidade {
  String _numero;
  String _nome;

  _Unidade(result) {
    _numero = result['numero'].toString();
    _nome = result['nome'];
  }

  String get numero => _numero;
  String get nome => _nome;
}
