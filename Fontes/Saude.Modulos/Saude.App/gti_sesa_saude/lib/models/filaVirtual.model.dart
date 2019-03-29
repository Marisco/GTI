class FilaVirtualModel {
  List<_FilaVirtual> _results = [];

  FilaVirtualModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['filaVirtuals'].length);

    List<_FilaVirtual> temp = [];
    for (int i = 0; i < parsedJson['filaVirtuals'].length; i++) {
      _FilaVirtual result = _FilaVirtual(parsedJson['filaVirtuals'][i]);
      temp.add(result);
    }
    this._results = temp;
  }
  List<_FilaVirtual> getFilasVirtuais() {
    return this._results.isEmpty ? [] : this._results;
  }
}

class _FilaVirtual {    
  String _numero;
  String _unidade;
  String _consultorio;
  String _especialidade;
  String _medico;
  String _dataInicio;
  String _dataFim;

  _FilaVirtual(result) {
    _numero = result['numero'].toString();
    _unidade = result['unidade_nome'];
    _consultorio = result['consultorio_nome'];
    _especialidade = result['especialidade_nome'];
    _medico = result['medico_nome'];
    _dataInicio = result['data_inicio'];
    _dataFim = result['data_fim'];
  }

  String get numero => _numero;
  String get unidade => _unidade;
  String get consultorio => _consultorio;
  String get especialidade => _especialidade;
  String get medico => _medico;
  String get dataInicio => _dataInicio;
  String get dataFim => _dataFim;

}
