class ConsultaModel {
  List<_Consulta> _results = [];

  ConsultaModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['consultas'].length);

    List<_Consulta> temp = [];
    for (int i = 0; i < parsedJson['consultas'].length; i++) {
      _Consulta result = _Consulta(parsedJson['consultas'][i]);
      temp.add(result);
    }
    this._results = temp;
  }
  List<_Consulta> getConsultas() {
    return this._results.isEmpty ? [] : this._results;
  }
}

class _Consulta {    
  String _numero;
  String _unidade;
  String _consultorio;
  String _especialidade;
  String _medico;
  String _dataInicio;
  String _dataFim;

  _Consulta(result) {
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
