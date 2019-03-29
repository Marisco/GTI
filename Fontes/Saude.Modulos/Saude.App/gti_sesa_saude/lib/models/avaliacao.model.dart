class AvaliacaoModel {
  List<_Avaliacao> _results = [];

  AvaliacaoModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['avaliacoes'].length);

    List<_Avaliacao> temp = [];
    for (int i = 0; i < parsedJson['avaliacoes'].length; i++) {
      _Avaliacao result = _Avaliacao(parsedJson['avaliacoess'][i]);
      temp.add(result);
    }
    this._results = temp;
  }
  List<_Avaliacao> getAvaliacoes() {
    return this._results.isEmpty ? [] : this._results;
  }
}

class _Avaliacao {
  String _numero;
  String _nome;

  _Avaliacao(result) {
    _numero = result['numero'].toString();
    _nome = result['nome'];
  }

  String get numero => _numero;
  String get nome => _nome;
}
