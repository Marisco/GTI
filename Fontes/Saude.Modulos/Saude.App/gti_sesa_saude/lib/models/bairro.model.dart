class BairroModel {
  List<_Bairro> _results = [];

  BairroModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['bairros'].length);

    List<_Bairro> temp = [];
    for (int i = 0; i < parsedJson['bairros'].length; i++) {
      _Bairro result = _Bairro(parsedJson['bairros'][i]);
      temp.add(result);
    }
    this._results = temp;
  }
  List<_Bairro> getBairros() {
    return this._results.isEmpty ? null : this._results;
  }
}

class _Bairro {
  String _numero;
  String _nome;

  _Bairro(result) {
    _numero = result['numero'].toString();
    _nome = result['nome'];
  }

  String get numero => _numero;
  String get nome => _nome;
}
