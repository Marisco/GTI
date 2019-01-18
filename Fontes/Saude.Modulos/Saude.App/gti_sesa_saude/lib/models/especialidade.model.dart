class EspecialidadeModel {
  List<_Especialidade> _results = [];

  EspecialidadeModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['especialidades'].length);

    List<_Especialidade> temp = [];
    for (int i = 0; i < parsedJson['especialidades'].length; i++) {
      _Especialidade result = _Especialidade(parsedJson['especialidades'][i]);
      temp.add(result);
    }
    this._results = temp;
  }
  List<_Especialidade> getEspecialidades() {
    return this._results.isEmpty ? null : this._results;
  }
}

class _Especialidade {
  String _numero;
  String _nome;

  _Especialidade(result) {
    _numero = result['numero'].toString();
    _nome = result['nome'];
  }

  String get numero => _numero;
  String get nome => _nome;
}
